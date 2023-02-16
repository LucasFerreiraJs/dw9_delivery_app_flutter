import 'package:dw9_delivery_app/app/core/ui/styles/text_styles.dart';
import 'package:dw9_delivery_app/app/core/ui/widgets/delivery_appbar.dart';
import 'package:dw9_delivery_app/app/core/ui/widgets/delivery_button.dart';
import 'package:flutter/material.dart';
import 'package:validatorless/validatorless.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  // ec editing controller
  final _nameEC = TextEditingController();
  final _emailEC = TextEditingController();
  final _passwordEC = TextEditingController();

  @override
  void dispose() {
    _nameEC.dispose();
    _emailEC.dispose();
    _passwordEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DeliveryAppbar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("Cadastro", style: context.textStyles.textTitle),
                Text("Preencha os campos abaixo para criar o  seu cadastro.", style: context.textStyles.textMedium.copyWith(fontSize: 18)),
                SizedBox(
                  height: 30,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: "Nome"),
                  controller: _nameEC,
                  validator: Validatorless.required("Nome obrigatório"),
                ),
                SizedBox(
                  height: 30,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: "E-mail"),
                  controller: _emailEC,
                  validator: Validatorless.multiple([
                    Validatorless.required("Email obrigatório"),
                    Validatorless.email("Email inválido"),
                  ]),
                ),
                SizedBox(
                  height: 30,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: "Senha"),
                  obscureText: true,
                  controller: _passwordEC,
                  validator: Validatorless.multiple([
                    Validatorless.required("Senha obrigatória"),
                    Validatorless.min(6, "Mínimo 6 caractares"),
                  ]),
                ),
                SizedBox(
                  height: 30,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: "Confirmar senha"),
                  obscureText: true,
                  validator: Validatorless.multiple([
                    Validatorless.required("confirma senha obrigatória"),
                    Validatorless.compare(_passwordEC, "senhas diferentes"),
                  ]),
                ),
                SizedBox(
                  height: 30,
                ),
                Center(
                  child: DeliveryButton(
                    onPressed: () {
                      final valid = _formKey.currentState?.validate() ?? false;
                      if (valid) {}
                    },
                    label: "Cadastrar",
                    width: double.infinity,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
