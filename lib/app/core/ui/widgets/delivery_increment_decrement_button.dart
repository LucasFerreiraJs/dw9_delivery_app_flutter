// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:dw9_delivery_app/app/core/ui/styles/colors_app.dart';
import 'package:dw9_delivery_app/app/core/ui/styles/text_styles.dart';

class DeliveryIncrementDecrementButton extends StatelessWidget {
  final int amount;
  final VoidCallback incrementTap;
  final VoidCallback decrementTap;
  final bool _compact;

  const DeliveryIncrementDecrementButton({
    Key? key,
    required this.amount,
    required this.incrementTap,
    required this.decrementTap,
  })  : _compact = false,
        super(key: key);

  const DeliveryIncrementDecrementButton.compact({
    Key? key,
    required this.amount,
    required this.incrementTap,
    required this.decrementTap,
  })  : _compact = true,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: _compact ? const EdgeInsets.all(5) : null,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(7),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          InkWell(
            onTap: decrementTap,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                '-',
                style: context.textStyles.textMedium.copyWith(fontSize: _compact ? 10 : 22, color: Colors.grey),
              ),
            ),
          ),
          Text(
            amount.toString(),
            style: context.textStyles.textRegular.copyWith(fontSize: _compact ? 13 : 17, color: context.colors.secondary),
          ),
          InkWell(
            onTap: incrementTap,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                '+',
                style: context.textStyles.textMedium.copyWith(fontSize: _compact ? 10 : 22, color: context.colors.secondary),
              ),
            ),
          ),
        ],
      ),
    );
  }
}




// 27: aula 3