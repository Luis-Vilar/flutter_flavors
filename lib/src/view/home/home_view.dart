import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gerencia_estado_injecao_dependencia/core/app_injection.dart';
import 'package:gerencia_estado_injecao_dependencia/flavors.dart';
import 'package:gerencia_estado_injecao_dependencia/src/blocs/home/home_bloc.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late final HomeBloc bloc;

  @override
  void initState() {
    bloc = injection.get<HomeBloc>();
    bloc.add(HomeEventGetBreed());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(F.title), centerTitle: true),
      body: BlocBuilder<HomeBloc, HomeState>(
        bloc: bloc,
        builder: (context, state) {
          if (state is HomeSuccess) {
            return Center(
              child: Column(
                children: [
                  Divider(),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 8, left: 8),
                        child: Icon(Icons.web),
                      ),
                      Text(F.apiUrl),
                    ],
                  ),
                  Divider(),
                  SizedBox(height: 8),
                  Card(
                    child: ListTile(
                      title: Text(
                        state.breed.name,
                        style: TextStyle(fontWeight: .bold),
                      ),
                      subtitle: Text(state.breed.temperament),
                      trailing: Text(state.breed.origin),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.network(
                      state.breed.image['url'],
                      errorBuilder: (context, error, stackTrace) =>
                          Text('Sem Imagem'),
                    ),
                  ),
                  Spacer(),
                ],
              ),
            );
          }
          if (state is HomeError) {
            return Text(state.message);
          }

          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
