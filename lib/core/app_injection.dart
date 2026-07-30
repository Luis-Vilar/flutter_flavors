import 'package:dio/dio.dart';
import 'package:gerencia_estado_injecao_dependencia/src/blocs/home/home_bloc.dart';
import 'package:gerencia_estado_injecao_dependencia/src/data/breed/breed_remote_datasource.dart';
import 'package:gerencia_estado_injecao_dependencia/src/data/breed/brred_repository.dart';
import 'package:gerencia_estado_injecao_dependencia/src/shared/app_client/app_client.dart';
import 'package:get_it/get_it.dart';

final injection = GetIt.instance;

void initDependencyInjection({required Dio dio}) {
  injection.registerLazySingleton<AppClient>(() => AppClientDioImpl(dio: dio));
  injection.registerFactory<IBreedRemoteDatasource>(
    () => BreedRemoteDatasourceImpl(client: injection<AppClient>()),
  );
  injection.registerFactory<IBreedRepository>(
    () => BreedRepositoryImpl(datasource: injection<IBreedRemoteDatasource>()),
  );
  injection.registerFactory<HomeBloc>(
    () => HomeBloc(injection<IBreedRepository>()),
  );

}
