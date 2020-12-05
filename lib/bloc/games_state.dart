import 'package:equatable/equatable.dart';
import 'package:gamebot/model/games_model.dart';

abstract class GamesState extends Equatable {}

class GameInitialstate extends GamesState {
  @override
  List<Object> get props => [];

  @override
  bool get stringify => false;
}

class GameLoadingState extends GamesState {
  @override
  List<Object> get props => [];

  @override
  bool get stringify => false;
}

class GameLoadedState extends GamesState {
  final List<GamesModel> games;

  GameLoadedState(this.games);

  @override
  List<Object> get props => [games];

  @override
  bool get stringify => true;
}

class GameErrorState extends GamesState {
  final String message;

  GameErrorState(this.message);

  @override
  List<Object> get props => [message];

  @override
  bool get stringify => false;
}
