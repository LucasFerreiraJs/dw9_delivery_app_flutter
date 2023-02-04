import 'package:flutter/material.dart';

class DeliveryAppbar extends AppBar {
  DeliveryAppbar({
    super.key,
    double elevationCustom = 1,
  }) : super(
          elevation: elevationCustom,
          title: Image.asset(
            "assets/images/logo.png",
            width: 80,
          ),
        );
}
