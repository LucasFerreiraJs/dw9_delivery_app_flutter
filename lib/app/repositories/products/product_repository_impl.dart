import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:dw9_delivery_app/app/core/exceptions/repository_exception.dart';
import 'package:dw9_delivery_app/app/core/rest_client/custom_dio.dart';
import 'package:dw9_delivery_app/app/models/product_model.dart';
import 'package:dw9_delivery_app/app/repositories/products/products_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  final CustomDio dio;
  ProductRepositoryImpl({required this.dio});

  @override
  Future<List<ProductModel>> findAllProduct() async {
    try {
      final result = await dio.unauth().get('/products');
      var products = ProductModel.fromJson(result.toString());
      print(products);

      // * passar o <ProductModel>, se não será list<dynamic>
      return result.data.map<ProductModel>((prod) => ProductModel.fromMap(prod)).toList();
    } on DioError catch (err, stack) {
      log("Erro ao buscar os produtos", error: err, stackTrace: stack);
      throw RepositoryException(message: "Erro ao buscar os produtos");
    }
  }
}
