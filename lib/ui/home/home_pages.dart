import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:gamebot/bloc/games_bloc.dart';
import 'package:gamebot/bloc/games_event.dart';
import 'package:gamebot/bloc/games_state.dart';
import 'package:gamebot/model/games_model.dart';
import 'package:gamebot/repository/repository_games.dart';
import 'package:gamebot/ui/home/detail_pages.dart';
import 'package:gamebot/ui/style/custom_field.dart';
import 'package:gamebot/shared/error_widget.dart';
import 'package:gamebot/shared/loader_widget.dart';
import 'package:gamebot/ui/style/item_card.dart';
import 'package:gamebot/ui/style/theme_color.dart' as style;
import 'package:page_indicator/page_indicator.dart';

class HomePages extends StatefulWidget {
  @override
  _HomePagesState createState() => _HomePagesState();
}

class _HomePagesState extends State<HomePages> {
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
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 32,
                  child: Icon(
                    Entypo.leaf,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: CustomField(
                    label: 'Search games...',
                    iconData: MaterialIcons.keyboard_voice,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: BlocConsumer<GamesBloc, GamesState>(
              cubit: _gamesBloc,
              builder: (context, state) {
                return Stack(
                  children: [
                    _buildGameWidget(),
                    buildLoadingWidget(state),
                  ],
                );
              },
              listener: (context, state) {
                if (state is GameErrorState) {
                  print('error ' + state.message);
                  buildErrorWidget(state.message);
                } else if (state is GameLoadedState) {
                  print('success');
                  // _games.clear();
                  _games.addAll(state.games);
                }
              },
            ),
          )
        ],
      ),
    );
  }

  Widget _buildGameWidget() {
    if (_games.isNotEmpty) {
      return SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Choice',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        'Your game',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 24,
                  ),
                  Icon(
                    FontAwesome5Brands.fantasy_flight_games,
                    color: style.ThemeColor.secondaryColor,
                    size: 28,
                  ),
                ],
              ),
            ),
            // build Slider Games
            Container(
              height: 220,
              child: PageIndicatorContainer(
                align: IndicatorAlign.bottom,
                length: _games.take(5).length,
                indicatorSpace: 8,
                padding: EdgeInsets.all(0),
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
                                      'https://images.igdb.com/igdb/image/upload/t_cover_big/${_games[index].cover.imageId}.jpg',
                                    )),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8)),
                              ),
                            ),
                          ),
                          Positioned(
                            left: 20,
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
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Recommended games',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                    size: 20,
                  )
                ],
              ),
            ),
            Container(
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
                          ratting: _games[index].rating.toStringAsFixed(1),
                          imgPoster:
                              'https://images.igdb.com/igdb/image/upload/t_thumb/${_games[index].cover.imageId}.jpg',
                          imgBackDrop:
                              'https://images.igdb.com/igdb/image/upload/t_screenshot_huge/${_games[index].screenshot[0].imageId}.jpg',
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'New Release',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                    size: 20,
                  )
                ],
              ),
            ),
            Container(
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
                      ItemCard(
                        name: _games[index].name,
                        ratting: _games[index].rating.toStringAsFixed(1),
                        imgPoster:
                            'https://images.igdb.com/igdb/image/upload/t_thumb/${_games[index].cover.imageId}.jpg',
                        imgBackDrop:
                            'https://images.igdb.com/igdb/image/upload/t_screenshot_huge/${_games[index].screenshot[0].imageId}.jpg',
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      );
    }
    return Container(
      alignment: Alignment(0, -0.5),
      child: Text(
        'Load games...',
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
