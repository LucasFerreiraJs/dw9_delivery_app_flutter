import 'package:dw9_delivery_app/app/core/ui/base_state/base_state.dart';
import 'package:dw9_delivery_app/app/core/ui/styles/text_styles.dart';
import 'package:dw9_delivery_app/app/core/ui/widgets/delivery_appbar.dart';
import 'package:dw9_delivery_app/app/core/ui/widgets/delivery_button.dart';
import 'package:dw9_delivery_app/app/dto/order_product_dto.dart';
import 'package:dw9_delivery_app/app/models/payment_type_model.dart';
import 'package:dw9_delivery_app/app/models/product_model.dart';
import 'package:dw9_delivery_app/app/pages/order/order_controller.dart';
import 'package:dw9_delivery_app/app/pages/order/order_state.dart';
import 'package:dw9_delivery_app/app/pages/order/widget/order_field.dart';
import 'package:dw9_delivery_app/app/pages/order/widget/order_product_tile.dart';
import 'package:dw9_delivery_app/app/pages/order/widget/payment_types_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:validatorless/validatorless.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends BaseState<OrderPage, OrderController> {
  final formKey = GlobalKey<FormState>();
  final addreddEC = TextEditingController();
  final documentEC = TextEditingController();
  int? paymentId;

  @override
  void onReady() {
    final products = ModalRoute.of(context)!.settings.arguments as List<OrderProductDto>;
    controller.load(products);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<OrderController, OrderState>(
      listener: ((context, state) => {
            state.status.matchAny(
              any: () => hideLoader(),
              loading: () => showLoader(),
              error: () {
                hideLoader();
                showError(state.errorMessage ?? "Erro ao carregar a página");
              },
            ),
          }),
      child: Scaffold(
        appBar: DeliveryAppbar(),
        body: Form(
          key: formKey,
          child: CustomScrollView(
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
              BlocSelector<OrderController, OrderState, List<OrderProductDto>>(
                selector: (state) {
                  return state.orderProducts;
                },
                builder: (context, orderProducts) {
                  return SliverList(
                    delegate: SliverChildBuilderDelegate(
                      // parecido com ListView
                      childCount: orderProducts.length,
                      (contetx, index) {
                        final orderproductItem = orderProducts[index];

                        return Column(children: <Widget>[
                          OrderProductTile(
                            index: index,
                            orderProduct: orderproductItem,
                          ),
                          Divider(color: Colors.grey),
                        ]);
                      },
                    ),
                  );
                },
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
                    BlocSelector<OrderController, OrderState, List<PaymentTypeModel>>(
                      selector: (state) {
                        return state.paymentTypes;
                      },
                      builder: (context, paymentsTypes) {
                        return PaymentTypesField(
                          paymentTypes: paymentsTypes,
                        );
                      },
                    ),
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
                        onPressed: () {
                          final valid = formKey.currentState?.validate() ?? false;

                          if (valid) {
                            print("valid");
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


// 2:09