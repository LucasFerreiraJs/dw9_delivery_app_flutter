import 'package:dw9_delivery_app/app/pages/home/home_controller.dart';
import 'package:dw9_delivery_app/app/pages/home/home_page.dart';
import 'package:dw9_delivery_app/app/repositories/products/products_repository_impl.dart';
import 'package:dw9_delivery_app/app/repositories/products/products_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeRouter {
  HomeRouter._();

  static Widget get page => MultiProvider(
        providers: [
          Provider<ProductRepository>(
            create: (context) => ProductRepositoryImpl(dio: context.read()), // * dio pega direto do context pelo application bind
          ),
          Provider<HomeController>(
            create: (context) => HomeController(context.read()), // * passa ProductRepositoryImpl pelo context (lá dentro faz ref a classe abstrata ProductRepository)
          )
        ],
        child: const HomePage(),
      );
}
