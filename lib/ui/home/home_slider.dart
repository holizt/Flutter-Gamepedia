import 'package:flutter/material.dart';
import 'package:gamebot/bloc/games_bloc.dart';
import 'package:gamebot/bloc/games_event.dart';
import 'package:gamebot/model/games_model.dart';
import 'package:gamebot/repository/repository_games.dart';
import 'package:page_indicator/page_indicator.dart';

class HomeSlider extends StatefulWidget {
  @override
  _HomeSliderState createState() => _HomeSliderState();
}

class _HomeSliderState extends State<HomeSlider> {
  GamesBloc _gamesBloc;
  List<GamesModel> _games = List();

  PageController _pageController = PageController(
    viewportFraction: 1,
    keepPage: true,
  );
  @override
  void initState() {
    _gamesBloc = GamesBloc(RepositoryGames());
    _fetchGames();
    super.initState();
  }

  void _fetchGames() => _gamesBloc.add(FetchGamesEvent());

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      child: PageIndicatorContainer(
        align: IndicatorAlign.bottom,
        length: _games.take(5).length,
        indicatorSpace: 8,
        padding: const EdgeInsets.all(5),
        indicatorColor: Colors.grey[600],
        indicatorSelectorColor: Colors.white,
        shape: IndicatorShape.circle(size: 5),
        child: PageView.builder(
          controller: _pageController,
          scrollDirection: Axis.horizontal,
          itemCount: _games.take(5).length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {},
              child: Stack(
                children: [
                  Hero(
                    tag: _games[index].id,
                    child: Container(
                      clipBehavior: Clip.antiAlias,
                      margin: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                              'https://images.igdb.com/igdb/image/upload/t_screenshot_big/${_games[index].cover.imageId}.jpg',
                            )),
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 30,
                    bottom: 30,
                    child: Container(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      width: 250,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _games[index].name,
                            style: TextStyle(
                              height: 1.5,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
