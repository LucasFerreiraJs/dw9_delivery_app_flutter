// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:bloc/bloc.dart';

import 'package:dw9_delivery_app/app/pages/home/home_state.dart';
import 'package:dw9_delivery_app/app/repositories/products/products_repository.dart';

class HomeController extends Cubit<HomeState> {
  final ProductRepository _productRepository;

  HomeController(
    this._productRepository,
  ) : super(const HomeState.inital());

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
}
