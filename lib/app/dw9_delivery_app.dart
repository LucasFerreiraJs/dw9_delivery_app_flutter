import 'package:dw9_delivery_app/app/core/ui/theme/theme_config.dart';
import 'package:dw9_delivery_app/app/pages/splash/splash_page.dart';
import 'package:flutter/material.dart';

class DeliveryApp extends StatelessWidget {
  const DeliveryApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeConfig.theme,
      title: "Vakinha Burguer",
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => const SplashPage(),
      },
    );
  }
}
