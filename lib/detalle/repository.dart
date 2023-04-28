import 'package:banana/dio/httpdio.dart';
import 'package:banana/model/producto.dart';
import 'package:flutter_modular/flutter_modular.dart';

class Repository {
  Future<dynamic> getProductoDetlle(int id) async {
    var dio = Modular.get<HttpDio>().hhtp;

    final result = await dio.get('/products/$id');
    return Producto.fromJson(result.data);
  }
}
