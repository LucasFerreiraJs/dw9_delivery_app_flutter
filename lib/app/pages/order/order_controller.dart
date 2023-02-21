import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dw9_delivery_app/app/dto/order_product_dto.dart';
import 'package:dw9_delivery_app/app/pages/order/order_state.dart';
import 'package:dw9_delivery_app/app/repositories/order/order_repository.dart';

class OrderController extends Cubit<OrderState> {
  final OrderRepository _orderRepository;

  OrderController(this._orderRepository) : super(OrderState.initial());

  void load(List<OrderProductDto> products) async {
    try {
      emit(state.copyWith(status: OrderStatus.loading));
      // pegar formas de pagameto
      final paymentTypes = await _orderRepository.getAllPaymentsTypes();

      emit(state.copyWith(
        status: OrderStatus.loaded,
        orderProducts: products,
        paymentTypes: paymentTypes,
      ));
    } catch (err, stackErr) {
      log("Erro ao carregar a página", error: err, stackTrace: stackErr);
      emit(state.copyWith(status: OrderStatus.error, errorMessage: "Erro ao carregar a página"));
    }
  }
}
