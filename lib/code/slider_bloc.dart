import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gamebot/model/games_model.dart';
import 'package:gamebot/repository/repository_games.dart';

abstract class SliderState {}

class SliderInitial extends SliderState {}

class SliderLoading extends SliderState {}

class SliderError extends SliderState {
  final String message;
  SliderError(this.message);
}

class SliderLoaded extends SliderState {
  final List<GamesModel> games;
  SliderLoaded(this.games);
}

class SliderEvent {}

class SliderBloc extends Bloc<SliderEvent, SliderState> {
  final RepositoryGames _repositoryGames;

  SliderBloc(this._repositoryGames) : super(SliderInitial());

  @override
  Stream<SliderState> mapEventToState(SliderEvent event) async* {
    try {
      yield SliderLoading();
      List<GamesModel> games = await _repositoryGames.getGameSlider();
      yield SliderLoaded(games);
    } catch (e) {
      yield SliderError(e.toString());
    }
  }
}
