import 'package:dw9_delivery_app/app/core/ui/base_state/base_state.dart';
import 'package:dw9_delivery_app/app/core/ui/styles/text_styles.dart';
import 'package:dw9_delivery_app/app/core/ui/widgets/delivery_appbar.dart';
import 'package:dw9_delivery_app/app/core/ui/widgets/delivery_button.dart';
import 'package:dw9_delivery_app/app/pages/auth/register/register_controller.dart';
import 'package:dw9_delivery_app/app/pages/auth/register/register_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:validatorless/validatorless.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends BaseState<RegisterPage, RegisterController> {
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
  void onReady() {
    // TODO: implement onReady
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterController, RegisterState>(
      listener: (context, state) => {
        state.status.matchAny(
          any: () => hideLoader(),
          register: () => showLoader(),
          error: () {
            hideLoader();
            showError("Erro ao registar usuário");
          },
          success: () {
            hideLoader();
            showSuccess("Cadastro realizado com sucesso");
            Navigator.pop(context);
          },
        )
      },
      child: Scaffold(
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
                        if (valid) {
                          controller.register(_nameEC.text, _emailEC.text, _passwordEC.text);
                        }
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
      ),
    );
  }
}
