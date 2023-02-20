import 'package:dw9_delivery_app/app/core/ui/styles/colors_app.dart';
import 'package:dw9_delivery_app/app/core/ui/styles/text_styles.dart';
import 'package:dw9_delivery_app/app/core/ui/widgets/delivery_increment_decrement_button.dart';
import 'package:dw9_delivery_app/app/dto/order_product_dto.dart';
import 'package:flutter/material.dart';

class OrderProductTile extends StatelessWidget {
  final int index;
  final OrderProductDto product;

  const OrderProductTile({
    Key? key,
    required this.index,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(children: <Widget>[
        Image.network(
          "https://assets.unileversolutions.com/recipes-v2/106684.jpg?imwidth=800",
          width: 100,
          height: 100,
          fit: BoxFit.cover,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "X-burger",
                  style: context.textStyles.textRegular.copyWith(
                    fontSize: 16,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "19,90",
                      style: context.textStyles.textMedium.copyWith(
                        fontSize: 14,
                        color: context.colors.secondary,
                      ),
                    ),
                    DeliveryIncrementDecrementButton(
                      amount: 1,
                      incrementTap: () {},
                      decrementTap: () {},
                    ),
                  ],
                )
              ],
            ),
          ),
        )
      ]),
    );
  }
}
