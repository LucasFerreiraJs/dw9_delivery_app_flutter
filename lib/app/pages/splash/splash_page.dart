import 'package:dw9_delivery_app/app/core/ui/styles/app_styles.dart';
import 'package:dw9_delivery_app/app/core/ui/styles/colors_app.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          iconTheme: IconThemeData(color: Colors.black),
        ),
        primaryColor: ColorsApp.instance.primary,
        colorScheme: ColorScheme.fromSeed(
          seedColor: ColorsApp.instance.primary,
          primary: ColorsApp.instance.primary,
          secondary: ColorsApp.instance.secondary,
        ), // * range de cores com base na cor passada por parâmetro
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: AppStyles.instance.primaryButton,
        ),
        inputDecorationTheme: InputDecorationTheme(
          fillColor: Colors.white,
          filled: true,
          isDense: true,
          contentPadding: const EdgeInsets.all(13),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(7),
            borderSide: BorderSide(color: Colors.grey[400]!),
          ),
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Splash"),
        ),
        body: Column(
          children: [
            Container(),
            ElevatedButton(
              onPressed: () {},
              child: const Text("teste"),
            ),
            TextFormField()
          ],
        ),
      ),
    );
  }
}
