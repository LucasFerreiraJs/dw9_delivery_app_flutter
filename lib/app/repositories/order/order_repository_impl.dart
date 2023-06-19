// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:dw9_delivery_app/app/core/exceptions/repository_exception.dart';
import 'package:dw9_delivery_app/app/core/rest_client/custom_dio.dart';
import 'package:dw9_delivery_app/app/dto/order_dto.dart';
import 'package:dw9_delivery_app/app/models/payment_type_model.dart';
import 'package:dw9_delivery_app/app/repositories/order/order_repository.dart';

class OrderRepositoryImpl implements OrderRepository {
  final CustomDio dio;

  OrderRepositoryImpl({
    required this.dio,
  });

  @override
  Future<List<PaymentTypeModel>> getAllPaymentsTypes() async {
    try {
      final result = await dio.auth().get("/payment-types");
      // return result.data.map((payment) => PaymentTypeModel.fromMap(payment)).toList() as List<PaymentTypeModel>;

      return (result.data as List).cast<Map<String, dynamic>>().map<PaymentTypeModel>(PaymentTypeModel.fromMap).toList();
    } on DioError catch (err, stackErr) {
      log("erro ao buscar formas de pagamentos", error: err, stackTrace: stackErr);
      throw RepositoryException(message: "erro ao buscar formas de pagamentos");
    }
  }

  @override
  Future<void> saveOrder(OrderDto order) async {
    try {
      await dio.auth().post("/orders", data: {
        'products': order.products
            .map(
              (item) => {
                'id': item.product.id,
                'amount': item.amount,
                'total_price': item.totalPrice,
              },
            )
            .toList(),
        'user_id': '#userAuthRef',
        'address': order.address,
        'CPF': order.document,
        'payment_method_id': order.paymentMethodId,
      });
    } on DioError catch (err, stack) {
      log("Erro ao registrar pedido", error: err, stackTrace: stack);
      throw RepositoryException(message: "Erro ao registrar pedido");
    }
  }
}
