// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ffi';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:dw9_delivery_app/app/core/extensions/formatter_extension.dart';
import 'package:dw9_delivery_app/app/dto/order_product_dto.dart';
import 'package:flutter/material.dart';

import 'package:dw9_delivery_app/app/core/ui/base_state/base_state.dart';
import 'package:dw9_delivery_app/app/core/ui/helpers/size_extensions.dart';
import 'package:dw9_delivery_app/app/core/ui/styles/text_styles.dart';
import 'package:dw9_delivery_app/app/core/ui/widgets/delivery_appbar.dart';
import 'package:dw9_delivery_app/app/core/ui/widgets/delivery_increment_decrement_button.dart';
import 'package:dw9_delivery_app/app/models/product_model.dart';
import 'package:dw9_delivery_app/app/pages/product_detail/product_detail_controller.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailPage extends StatefulWidget {
  final ProductModel product;
  final OrderProductDto? order;
  const ProductDetailPage({
    Key? key,
    required this.product,
    this.order,
  }) : super(key: key);

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends BaseState<ProductDetailPage, ProductDetailController> {
  @override
  void onReady() {
    // TODO: implement onReady
    final amount = widget.order?.amount ?? 1;
    controller.initial(amount, widget.order != null);
  }

  void _showConfirmDelete(int amount) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(title: Text("Deseja excluir o produto?"), actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                "Cancelar",
                style: context.textStyles.textBold.copyWith(color: Colors.red),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.of(context).pop(OrderProductDto(
                  product: widget.product,
                  amount: amount,
                ));
              },
              child: Text(
                "Confirmar",
                style: context.textStyles.textBold.copyWith(),
              ),
            )
          ]);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DeliveryAppbar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: context.screenWidth,
            height: context.percentHeight(.4),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(widget.product.image),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              widget.product.name,
              style: context.textStyles.textExtraBold.copyWith(fontSize: 22),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: SingleChildScrollView(child: Text(widget.product.description)),
            ),
          ),
          Divider(),
          Row(
            children: <Widget>[
              Container(
                width: context.percentWidth(.5),
                height: 68,
                padding: EdgeInsets.all(8),
                child: BlocBuilder<ProductDetailController, int>(
                  builder: (context, state) {
                    return DeliveryIncrementDecrementButton(
                      amount: state,
                      incrementTap: () {
                        controller.increment();
                        // setState(() {});
                      },
                      decrementTap: () {
                        controller.decrement();
                        // setState(() {});
                      },
                    );
                  },
                ),
              ),
              Container(
                width: context.percentWidth(.5),
                height: 68,
                padding: const EdgeInsets.all(8),
                child: BlocBuilder<ProductDetailController, int>(
                  builder: (context, state) {
                    return ElevatedButton(
                      style: state == 0 ? ElevatedButton.styleFrom(backgroundColor: Colors.red) : null,
                      onPressed: () {
                        if (state == 0) {
                          _showConfirmDelete(state);
                        } else {
                          Navigator.of(context).pop(OrderProductDto(
                            product: widget.product,
                            amount: state,
                          ));
                        }
                      },
                      child: Visibility(
                        visible: state > 0,
                        replacement: Text("Excluir Produto", style: context.textStyles.textExtraBold),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Expanded(child: Text("Adicionar", style: context.textStyles.textExtraBold.copyWith(fontSize: 13))),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: AutoSizeText(
                                  (widget.product.price * state).currencyPTBR,
                                  maxFontSize: 13,
                                  minFontSize: 5,
                                  maxLines: 1,
                                  style: context.textStyles.textExtraBold.copyWith(fontSize: 13),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
