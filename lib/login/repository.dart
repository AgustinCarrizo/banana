import 'package:banana/dio/httpdio.dart';
import 'package:banana/model/login.dart';
import 'package:banana/model/usuario.dart';
import 'package:flutter_modular/flutter_modular.dart';

class Repository {
  Future<dynamic> postLogin(Login usuario) async {
    var dio = Modular.get<HttpDio>().hhtp;
    var data = {"username": usuario.usuario, "password": usuario.contrasenia};
    final result = await dio.post('auth/login', data: data);
    return Usuario.fromJson(result.data);
  }
}