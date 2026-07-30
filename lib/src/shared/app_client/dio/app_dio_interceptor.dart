import 'package:dio/dio.dart';
import 'package:gerencia_estado_injecao_dependencia/src/shared/app_exceptions.dart';

final class AppDioInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.type == DioExceptionType.connectionError) {
      DioException appException = DioException(
        requestOptions: err.requestOptions,
        error: AppNetworkException(),
      );
      return handler.next(appException);
    }
    if (err.type == DioExceptionType.badCertificate) {
      DioException appException = DioException(
        requestOptions: err.requestOptions,
        error: AppTokenExpiredExcetion(),
      );
      return handler.next(appException);
    }

    DioException appException = DioException(
      requestOptions: err.requestOptions,
      error: AppNetworkException(),
    );
    return handler.next(appException);
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers['x-api-key'] =
        'live_sAQtB5PmXpBasJuhm9UU27CfHmnGaOLYySV0XWVyhkRaM1485Ljvx5xru4iYaG1w';
    return handler.next(options);
  }

  @override
  void onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    return handler.next(response);
  }
}
