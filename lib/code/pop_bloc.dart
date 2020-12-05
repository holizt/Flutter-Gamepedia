import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gamebot/model/games_model.dart';
import 'package:gamebot/repository/repository_games.dart';

abstract class PopGameState {}

class PopGameInitial extends PopGameState {}

class PopGameLoading extends PopGameState {}

class PopGameError extends PopGameState {
  final String message;
  PopGameError(this.message);
}

class PopGameLoaded extends PopGameState {
  final List<GamesModel> games;
  PopGameLoaded(this.games);
}

class PopGameEvent {}

class PopGameBloc extends Bloc<PopGameEvent, PopGameState> {
  final RepositoryGames _repositoryPopGames;

  PopGameBloc(this._repositoryPopGames) : super(PopGameInitial());

  @override
  Stream<PopGameState> mapEventToState(PopGameEvent event) async* {
    try {
      yield PopGameLoading();
      List<GamesModel> games = await _repositoryPopGames.getGamesPopular();
      yield PopGameLoaded(games);
    } catch (e) {
      yield PopGameError(e.toString());
    }
  }
}
