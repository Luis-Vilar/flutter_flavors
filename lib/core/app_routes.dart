import 'package:flutter/material.dart';
import 'package:gerencia_estado_injecao_dependencia/src/view/home/home_view.dart';

class AppRoutes {
  static const String home = '/';

  static final routes = <String, Widget Function(BuildContext)>{
    home: (context) => HomeView(),
  };
}
