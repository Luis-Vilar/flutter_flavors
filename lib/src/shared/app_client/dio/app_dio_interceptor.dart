import 'package:dio/dio.dart';
import 'package:gerencia_estado_injecao_dependencia/src/shared/app_exceptions.dart';

final class AppDioInterceptor implements InterceptorsWrapper {
  //@override
  //void onError(DioException err, ErrorInterceptorHandler handler) {
  //  if (err.type == DioExceptionType.connectionError) {
  //    final appException = DioException(
  //      requestOptions: err.requestOptions,
  //      error: AppNetworkException(),
  //    );
  //    handler.next(appException);
  //    return;
  //  }
  //  if (err.type == DioExceptionType.badCertificate) {
  //    final appException = DioException(
  //      requestOptions: err.requestOptions,
  //      error: AppTokenExpiredExcetion(),
  //    );
  //    handler.next(appException);
  //    return;
  //  }
  //
  //  final appException = DioException(
  //    requestOptions: err.requestOptions,
  //    error: AppNetworkException(),
  //  );
  //  handler.next(appException);
  //}

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers['x-api-key'] =
        'live_sAQtB5PmXpBasJuhm9UU27CfHmnGaOLYySV0XWVyhkRaM1485Ljvx5xru4iYaG1w';
    handler.next(options);
  }

  @override
  void onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {}

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // TODO: implement onError
  }
}
