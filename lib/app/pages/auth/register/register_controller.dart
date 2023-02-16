import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dw9_delivery_app/app/pages/auth/register/register_state.dart';
import 'package:dw9_delivery_app/app/repositories/auth/auth_repository.dart';
import 'package:dw9_delivery_app/app/repositories/auth/auth_repository_impl.dart';

class RegisterController extends Cubit<RegisterState> {
  final AuthRepository _authrepository;

  // pelo provider
  RegisterController(this._authrepository) : super(RegisterState.initial());

  Future<void> register(String name, String email, String password) async {
    try {
      emit(state.copyWith(status: RegisterStatus.register));
      await _authrepository.register(name, email, password);

      emit(state.copyWith(status: RegisterStatus.success));
    } catch (err, stackErr) {
      log("Erro ao registrar usuário", error: err, stackTrace: stackErr);
      emit(state.copyWith(status: RegisterStatus.error));
    }
  }
}
