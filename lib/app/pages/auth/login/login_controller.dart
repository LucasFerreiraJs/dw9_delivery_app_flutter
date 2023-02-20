import 'dart:developer';

import 'package:dw9_delivery_app/app/core/exceptions/unauthorized_exception.dart';
import 'package:dw9_delivery_app/app/pages/auth/login/login_state.dart';
import 'package:dw9_delivery_app/app/repositories/auth/auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends Cubit<LoginState> {
  final AuthRepository _authRepository;

  LoginController(this._authRepository) : super(LoginState.initial());

  Future<void> login(String email, String password) async {
    emit(state.copyWith(status: LoginStatus.login));
    try {
      final authModel = await _authRepository.login(email, password);
      final sp = await SharedPreferences.getInstance();
      sp.setString('accessToken', authModel.accessToken);
      sp.setString('refreshToken', authModel.refreshToken);

      emit(state.copyWith(status: LoginStatus.success));
    } on UnauthorizedException catch (err, stackErr) {
      log("Login ou Senha inválidos", error: err, stackTrace: stackErr);
      emit(state.copyWith(status: LoginStatus.loginError, errorMessage: "Login ou Senha inválidos"));
    } catch (err, stackErr) {
      emit(state.copyWith(status: LoginStatus.error, errorMessage: "Login ou Senha inválidos"));
      log("Erro ao realizar login", error: err, stackTrace: stackErr);
    }
  }
}
