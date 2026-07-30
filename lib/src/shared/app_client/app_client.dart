import 'package:dio/dio.dart';

sealed class AppClient {
  Future<Map<String, dynamic>> get({
    required String url,
    Map<String, dynamic>? header,
  });
}

final class AppClientDioImpl implements AppClient {
  final Dio dio;

  AppClientDioImpl({required this.dio});

  @override
  Future<Map<String, dynamic>> get({
    required String url,
    Map<String, dynamic>? header,
  }) async {
    try {
      final result = await dio.get(url);
      if (result.statusCode == 200) {
        return result.data;
      }
      throw Exception();
    } on DioException catch (e) {
      throw e.error as Exception;
    } catch (e) {
      rethrow;
    }
  }
}
