import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dw9_delivery_app/app/dto/order_dto.dart';
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

  void incrementProduct(int index) {
    final ordersProductList = [...state.orderProducts];
    final order = ordersProductList[index];
    ordersProductList[index] = order.copyWith(amount: order.amount + 1);
    emit(state.copyWith(orderProducts: ordersProductList, status: OrderStatus.updateOrder));
  }

  void decrementProduct(int index) {
    final ordersProductList = [...state.orderProducts];
    final order = ordersProductList[index];
    final amount = order.amount;

    if (amount == 1) {
      // excluir
      if (state.status != OrderStatus.confirmRemoveProduct) {
        emit(OrderConfirmDeleteproductState(
          orderProduct: order,
          index: index,
          status: OrderStatus.confirmRemoveProduct,
          orderProducts: state.orderProducts,
          paymentTypes: state.paymentTypes,
          errorMessage: state.errorMessage,
        ));
        return;
      } else {
        ordersProductList.removeAt(index);
      }
    } else {
      ordersProductList[index] = order.copyWith(amount: order.amount - 1);
    }

    if (ordersProductList.isEmpty) {
      emit(state.copyWith(status: OrderStatus.emptyBag));
      return;
    }

    emit(state.copyWith(orderProducts: ordersProductList, status: OrderStatus.updateOrder));
  }

  void cancelDeleteProcess() {
    emit(state.copyWith(status: OrderStatus.loaded));
  }

  void emptyBag() {
    emit(state.copyWith(status: OrderStatus.emptyBag));
  }

  Future<void> saveOrder({required String address, required String document, required int paymentMethodId}) async {
    emit(state.copyWith(status: OrderStatus.loading));
    await _orderRepository.saveOrder(OrderDto(
      products: state.orderProducts,
      address: address,
      document: document,
      paymentMethodId: paymentMethodId,
    ));
    emit(state.copyWith(status: OrderStatus.success));
  }
}
