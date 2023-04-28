import 'package:banana/dio/httpdio.dart';
import 'package:banana/model/productos.dart';
import 'package:flutter_modular/flutter_modular.dart';

class Repository {
  Future<dynamic> getProductos() async {
    var dio = Modular.get<HttpDio>().hhtp;

    final result = await dio.get('products');
    return Productos.fromJson(result.data);
  }

  Future<dynamic> getFilter(String filter) async {
    var dio = Modular.get<HttpDio>().hhtp;

    final result = await dio.get('products/search?q=$filter');
    return Productos.fromJson(result.data);
  }
}
