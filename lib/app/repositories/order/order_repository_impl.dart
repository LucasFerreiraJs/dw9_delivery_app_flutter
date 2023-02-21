// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:dw9_delivery_app/app/core/exceptions/repository_exception.dart';
import 'package:dw9_delivery_app/app/core/rest_client/custom_dio.dart';
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
}
