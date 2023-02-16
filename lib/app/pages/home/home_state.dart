// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dw9_delivery_app/app/dto/order_product_dto.dart';
import 'package:equatable/equatable.dart';
import 'package:match/match.dart';

import 'package:dw9_delivery_app/app/models/product_model.dart';

part 'home_state.g.dart';

@match
enum HomeStateStatus {
  initial,
  loading,
  loaded,
  error,
}

class HomeState extends Equatable {
  final HomeStateStatus status;
  final List<ProductModel> products;
  final String? errorMessage;
  final List<OrderProductDto> shoppingBag;

  const HomeState(this.status, this.products, this.errorMessage, this.shoppingBag);

  HomeState.initial()
      : status = HomeStateStatus.initial,
        products = const <ProductModel>[],
        errorMessage = null,
        shoppingBag = const <OrderProductDto>[];

  @override
  List<Object?> get props => [status, products, errorMessage, shoppingBag];

  // * para gerar novo status
  HomeState copyWith({
    HomeStateStatus? status,
    List<ProductModel>? products,
    String? errorMessage,
    List<OrderProductDto>? shoppingBag,
  }) {
    return HomeState(
      status ?? this.status,
      products ?? this.products,
      errorMessage ?? this.errorMessage,
      shoppingBag ?? this.shoppingBag,
    );
  }
}
