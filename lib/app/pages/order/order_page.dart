import 'package:dw9_delivery_app/app/core/ui/styles/text_styles.dart';
import 'package:dw9_delivery_app/app/core/ui/widgets/delivery_appbar.dart';
import 'package:dw9_delivery_app/app/core/ui/widgets/delivery_button.dart';
import 'package:dw9_delivery_app/app/dto/order_product_dto.dart';
import 'package:dw9_delivery_app/app/models/product_model.dart';
import 'package:dw9_delivery_app/app/pages/order/widget/order_field.dart';
import 'package:dw9_delivery_app/app/pages/order/widget/order_product_tile.dart';
import 'package:dw9_delivery_app/app/pages/order/widget/payment_types_field.dart';
import 'package:flutter/material.dart';
import 'package:validatorless/validatorless.dart';

class OrderPage extends StatelessWidget {
  const OrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DeliveryAppbar(),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
              child: Row(
                children: <Widget>[
                  Text("Carrinho", style: context.textStyles.textTitle),
                  IconButton(
                    onPressed: () {},
                    icon: Image.asset('assets/images/trashRegular.png'),
                  )
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              // parecido com ListView
              childCount: 10,
              (contetx, index) {
                return Column(children: <Widget>[
                  OrderProductTile(
                    index: index,
                    product: OrderProductDto(
                      product: ProductModel.fromMap({}),
                      amount: 10,
                    ),
                  ),
                  Divider(color: Colors.grey),
                ]);
              },
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Total do pedido",
                        style: context.textStyles.textExtraBold.copyWith(
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        "R\$ 200.00",
                        style: context.textStyles.textExtraBold.copyWith(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(color: Colors.grey),
                SizedBox(
                  height: 10,
                ),
                OrderField(
                  title: "Endereço de Entrega",
                  controller: TextEditingController(),
                  validator: Validatorless.required("err"),
                  hintText: "Digite o endereço",
                ),
                SizedBox(
                  height: 10,
                ),
                OrderField(
                  title: "CPF",
                  controller: TextEditingController(),
                  validator: Validatorless.required("err"),
                  hintText: "Digite o CPF",
                ),
                const PaymentTypesField(),
              ],
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Divider(
                  color: Colors.grey,
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: DeliveryButton(
                    width: double.infinity,
                    height: 48,
                    label: "FINALIZAR",
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


// 2:09