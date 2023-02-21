import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthInterceptor extends Interceptor {
  // add antes da requisiçao
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final sp = await SharedPreferences.getInstance();
    final accessToken = sp.getString("accessToken");
    options.headers["Authorization"] = "Bearer $accessToken";

    // ! não travar no interceptor
    handler.next(options);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      // Redirecionar o usuário para a tela de home
      final sp = await SharedPreferences.getInstance();
      sp.clear();

      print("clear sp");

      handler.next(err);
    } else {
      handler.next(err);
    }
  }
}
