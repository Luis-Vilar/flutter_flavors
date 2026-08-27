import 'package:gerencia_estado_injecao_dependencia/flavors.dart';
import 'package:gerencia_estado_injecao_dependencia/src/shared/app_client/app_client.dart';

sealed class IBreedRemoteDatasource {
  Future<Map<String, dynamic>> getBreed();
}

class BreedRemoteDatasourceImpl implements IBreedRemoteDatasource {
  final AppClient client;

  BreedRemoteDatasourceImpl({required this.client});

  @override
  Future<Map<String, dynamic>> getBreed() async {
    final result = await client.get(
      url: F.apiUrl,
      header: {
        'x-api-key':
            'live_sAQtB5PmXpBasJuhm9UU27CfHmnGaOLYySV0XWVyhkRaM1485Ljvx5xru4iYaG1w',
      },
    );

    return result;
  }
}
