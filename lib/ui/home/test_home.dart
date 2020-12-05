import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gamebot/code/pop_bloc.dart';
import 'package:gamebot/code/slider_bloc.dart';
import 'package:gamebot/model/games_model.dart';
import 'package:gamebot/repository/repository_games.dart';
import 'package:gamebot/shared/error_widget.dart';
import 'package:gamebot/shared/loader_widget.dart';
import 'package:gamebot/ui/style/item_card.dart';

import 'detail_pages.dart';

class TestHome extends StatefulWidget {
  @override
  _TestHomeState createState() => _TestHomeState();
}

class _TestHomeState extends State<TestHome> {
  // final GamesBloc _gamesBloc = GamesBloc(RepositoryGames());
  // final GamePopularBloc _gamePopularBloc =
  //     GamePopularBloc(RepositoryPopGames());

  final SliderBloc _sliderBloc = SliderBloc(RepositoryGames());
  final PopGameBloc _popGameBloc = PopGameBloc(RepositoryGames());

  List<GamesModel> _games = List();

  @override
  void initState() {
    _sliderBloc.add(SliderEvent());
    _popGameBloc.add(PopGameEvent());
    super.initState();
  }

  // void _fetchGames() => _gamesBloc.add(FetchGamesEvent());
  // void _fetchGamesPopular() => _gamePopularBloc.add(FetchGamesPopularEvent());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Multi'),
      ),
      body: SafeArea(
        child: MultiBlocProvider(
          providers: [
            BlocProvider<SliderBloc>(
              create: (context) => _sliderBloc,
            ),
            BlocProvider<PopGameBloc>(
              create: (context) => _popGameBloc,
            ),
          ],
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Slider',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
              _buildGamesWidget(),
              SizedBox(
                height: 16,
              ),
              Text(
                'Popular',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
              _buildGamesPopularWidget(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGamesWidget() {
    return Expanded(
      child: BlocBuilder<SliderBloc, SliderState>(
        builder: (context, state) {
          if (state is SliderLoading) {
            return buildLoadingWidget(state);
          } else if (state is SliderError) {
            print('Error ' + state.message);
            return buildErrorWidget(state.message);
          } else if (state is SliderLoaded) {
            print('success');
            _games.addAll(state.games);
            return Container(
              height: 200,
              width: double.infinity,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _games.length,
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      (index == 0)
                          ? SizedBox(
                              width: 16,
                            )
                          : Container(),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    DetailPages(games: _games[index]),
                              ));
                        },
                        child: ItemCard(
                          name: _games[index].name,
                          // ratting: '3.4',
                          imgPoster: 'assets/images/placeimage.png',
                          imgBackDrop:
                              'https://images.igdb.com/igdb/image/upload/t_screenshot_big/${_games[index].cover.imageId}.jpg',
                        ),
                      ),
                    ],
                  );
                },
              ),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }

  Widget _buildGamesPopularWidget() {
    return Expanded(
      child: BlocBuilder<PopGameBloc, PopGameState>(
        builder: (context, state) {
          if (state is PopGameLoading) {
            return buildLoadingWidget(state);
          } else if (state is PopGameError) {
            return buildErrorWidget(state.message);
          } else if (state is PopGameLoaded) {
            _games.addAll(state.games);
            return Container(
              height: 200,
              width: double.infinity,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _games.length,
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      (index == 0)
                          ? SizedBox(
                              width: 16,
                            )
                          : Container(),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    DetailPages(games: _games[index]),
                              ));
                        },
                        child: ItemCard(
                          name: _games[index].name,
                          // ratting: '3.4',
                          imgPoster: 'assets/images/placeimage.png',
                          imgBackDrop:
                              'https://images.igdb.com/igdb/image/upload/t_screenshot_big/${_games[index].cover.imageId}.jpg',
                        ),
                      ),
                    ],
                  );
                },
              ),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
