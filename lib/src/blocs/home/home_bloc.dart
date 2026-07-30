// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gerencia_estado_injecao_dependencia/src/data/breed/breed_model.dart';
import 'package:gerencia_estado_injecao_dependencia/src/data/breed/brred_repository.dart';
import 'package:gerencia_estado_injecao_dependencia/src/shared/app_exceptions.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final IBreedRepository _breedRepository;

  HomeBloc(this._breedRepository) : super(HomeInitial()) {
    on<HomeEventGetBreed>((event, emit) async {
      try {
        emit(HomeLoading());
        final breed = await _breedRepository.getBreed();
        emit(HomeSuccess(breed: breed));
      } on ConvertDataException {
        emit(HomeError(message: 'Erro ao processar dados'));
      } catch (e) {
        emit(HomeError(message: 'Erro ao fazer a requisição'));
      }
    });
  }
}
