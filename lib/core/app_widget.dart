import 'package:flutter/material.dart';
import 'package:gerencia_estado_injecao_dependencia/core/app_routes.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(routes: AppRoutes.routes);
  }
}
