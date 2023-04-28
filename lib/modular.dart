import 'package:banana/dio/httpdio.dart';
import 'package:flutter_modular/flutter_modular.dart'
    hide ModularWatchExtension;

import 'home/page.dart' as home;
import 'login/page.dart' as login;
import 'detalle/page.dart' as detalle;

class BananaModular extends Module {
  @override
  List<Bind> get binds => [
        Bind((i) => HttpDio.instance),
      ];
  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute,
        child: (context, args) => const login.Page()),
    ChildRoute(
      '/home',
      child: (context, args) => const home.Page(),
    ),
    ChildRoute(
      '/detalle',
      child: (context, args) => detalle.Page(producto: args.data),
    ),
  ];
}
