import 'dart:async';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:gerencia_estado_injecao_dependencia/core/app_injection.dart';
import 'package:gerencia_estado_injecao_dependencia/core/app_widget.dart';
import 'package:gerencia_estado_injecao_dependencia/src/shared/app_client/dio/app_dio_interceptor.dart';

void bootstrap() {
  runZonedGuarded(
    () {
      WidgetsFlutterBinding.ensureInitialized();
      Dio dio = Dio();
      initDependencyInjection(dio: dio);
      runApp(AppWidget());
    },
    (error, stack) {
      log(error.toString());
    },
  );
}
