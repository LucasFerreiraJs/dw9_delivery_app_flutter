// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dw9_delivery_app/app/dto/order_product_dto.dart';

import 'package:dw9_delivery_app/app/pages/home/home_state.dart';
import 'package:dw9_delivery_app/app/repositories/products/products_repository.dart';

class HomeController extends Cubit<HomeState> {
  final ProductRepository _productRepository;

  HomeController(
    this._productRepository,
  ) : super(HomeState.initial());

  Future<void> loadProduct() async {
    emit(state.copyWith(status: HomeStateStatus.loading));

    try {
      await Future.delayed(Duration(seconds: 2));
      final products = await _productRepository.findAllProducts();
      // throw Exception();
      emit(state.copyWith(status: HomeStateStatus.loaded, products: products));
    } catch (err, stackerr) {
      log("erro ao buscar produtos", error: err, stackTrace: stackerr);
      emit(state.copyWith(status: HomeStateStatus.error, errorMessage: "erro ao buscar produtos"));
    }
  }

  void addOrUpdateBag(OrderProductDto orderProduct) {
    // * stream não é reativo, por isso duplicamos o estado e entregamos uma nova versão dele
    final shoppingBag = [...state.shoppingBag];

    // verificar se já está adicionado
    final orderItemIndex = shoppingBag.indexWhere((orderItem) => orderItem.product == orderProduct.product);
    if (orderItemIndex > -1) {
      // remover da lista
      if (orderProduct.amount == 0) {
        shoppingBag.removeAt(orderItemIndex);
      } else {
        shoppingBag[orderItemIndex] = orderProduct;
      }
    } else {
      shoppingBag.add(orderProduct);
    }

    emit(state.copyWith(shoppingBag: shoppingBag));
  }

  void updateBag(List<OrderProductDto> updateBag) {
    emit(state.copyWith(shoppingBag: updateBag));
  }
}
