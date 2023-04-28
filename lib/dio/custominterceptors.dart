

import 'package:banana/dio/conection.dart';
import 'package:banana/utils/variable_static.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class CustomerInterceptors extends Interceptor {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    var conection = await Conection().conectio();
    if (conection == true) {
      super.onRequest(options, handler);
    } else {
      var scaffoldMessengerKey = NavigationService.navigatorKey;
      scaffoldMessengerKey.currentState?.showSnackBar(
        SnackBar(
          content: Column(
            children: const [
              Text('No tiene conecion a internet '),
            ],
          ),
        ),
      );
      handler.reject(DioError(
        requestOptions: options,
        type: DioErrorType.connectionError,
        error: 'No hay conexión a Internet.',
      ));
      return;
    }

    return;
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    super.onResponse(response, handler);
    return;
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    return handler.next(err);
  }
}
