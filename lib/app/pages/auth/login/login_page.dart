import 'package:dw9_delivery_app/app/core/ui/styles/text_styles.dart';
import 'package:dw9_delivery_app/app/core/ui/widgets/delivery_appbar.dart';
import 'package:dw9_delivery_app/app/core/ui/widgets/delivery_button.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DeliveryAppbar(),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Login",
                      style: context.textStyles.textTitle,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    TextFormField(decoration: InputDecoration(labelText: "Email")),
                    SizedBox(
                      height: 30,
                    ),
                    TextFormField(decoration: InputDecoration(labelText: "Senha")),
                    SizedBox(
                      height: 50,
                    ),
                    Center(
                      child: DeliveryButton(onPressed: () {}, width: double.infinity, label: "Entrar"),
                    )
                  ],
                ),
              ),
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
                  Text("Não possui uma conta", style: context.textStyles.textBold),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      "Cadastre-se",
                      style: context.textStyles.textBold.copyWith(color: Colors.blue),
                    ),
                  ),
                ]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
