import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:gamebot/model/Item.dart';
import 'package:gamebot/model/games_model.dart';
import 'package:gamebot/ui/style/theme_color.dart' as style;
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class DetailPages extends StatefulWidget {
  final GamesModel games;
  DetailPages({Key key, @required this.games}) : super(key: key);

  @override
  _DetailPagesState createState() => _DetailPagesState(games);
}

class _DetailPagesState extends State<DetailPages>
    with SingleTickerProviderStateMixin {
  final GamesModel _games;

  TabController _tabController;

  final customColors = CustomSliderColors(
      dotColor: Colors.white.withOpacity(0.8),
      trackColor: Colors.grey,
      progressBarColor: style.ThemeColor.ratingColor,
      hideShadow: true);

  final tabs = <Item>[
    Item(id: 0, name: 'OVERVIEW'),
    Item(id: 1, name: 'SCREENSHOTS')
  ];

  _DetailPagesState(this._games);

  @override
  void initState() {
    _tabController = TabController(
      length: tabs.length,
      vsync: this,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                width: double.infinity,
                height: 220,
                child: Hero(
                    tag: _games.id,
                    child: Image.network(
                      'https://images.igdb.com/igdb/image/upload/t_screenshot_big/${_games.screenshot[0].imageId}.jpg',
                      fit: BoxFit.cover,
                    )),
              ),
              Positioned(
                top: 20,
                left: 0,
                child: IconButton(
                  icon: Icon(
                    SimpleLineIcons.arrow_left,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      stops: [
                        0.0,
                        0.9
                      ],
                      colors: [
                        style.ThemeColor.bottomNavColor.withOpacity(1.0),
                        style.ThemeColor.backgroundColor.withOpacity(0.0)
                      ]),
                ),
              ),
              Positioned(
                  bottom: 10,
                  left: 10,
                  child: Container(
                    height: 65,
                    width: 65,
                    child: SleekCircularSlider(
                      appearance: CircularSliderAppearance(
                        angleRange: 360,
                        customColors: customColors,
                        customWidths: CustomSliderWidths(
                            progressBarWidth: 4, trackWidth: 2),
                      ),
                      min: 0,
                      max: 100,
                      initialValue: _games.rating,
                      innerWidget: (double value) {
                        return Column(
                          children: [
                            Expanded(
                                child: Align(
                              alignment: Alignment.center,
                              child: Hero(
                                tag: _games.cover,
                                child: ClipOval(
                                  child: Image.network(
                                    'https://images.igdb.com/igdb/image/upload/t_cover_big/${_games.cover.imageId}.jpg',
                                    fit: BoxFit.cover,
                                    width: 60,
                                    height: 60,
                                  ),
                                ),
                              ),
                            ))
                          ],
                        );
                      },
                    ),
                  )),
              Positioned(
                  bottom: 30,
                  left: 85,
                  child: Text(
                    _games.name,
                    style: TextStyle(
                      height: 1.5,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ))
            ],
          ),
          TabBar(
              controller: _tabController,
              indicatorColor: style.ThemeColor.mainColor,
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorWeight: 2,
              unselectedLabelColor: Colors.white,
              labelColor: style.ThemeColor.mainColor,
              isScrollable: false,
              tabs: tabs.map((Item genre) {
                return Container(
                  padding: EdgeInsets.only(bottom: 15, top: 15),
                  child: Text(
                    genre.name,
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                );
              }).toList()),
          Expanded(
            child: TabBarView(
                controller: _tabController,
                physics: NeverScrollableScrollPhysics(),
                children: <Widget>[
                  ListView(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Text(
                          "Summary".toUpperCase(),
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          _games.summary,
                          style: TextStyle(
                            height: 1.5,
                            color: Colors.white.withOpacity(0.5),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 13,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Text(
                          "Storyline".toUpperCase(),
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          _games.storyLine,
                          style: TextStyle(
                            height: 1.5,
                            color: Colors.white.withOpacity(0.5),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Expanded(
                          child: AnimationLimiter(
                        child: AnimationLimiter(
                          child: Padding(
                            padding:
                                EdgeInsets.only(top: 10, left: 10, right: 10),
                            child: GridView.count(
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              childAspectRatio: 1.33,
                              crossAxisCount: 3,
                              children: List.generate(
                                _games.screenshot.length,
                                (int index) {
                                  return AnimationConfiguration.staggeredGrid(
                                    position: index,
                                    duration: Duration(milliseconds: 370),
                                    columnCount: 3,
                                    child: ScaleAnimation(
                                      child: FadeInAnimation(
                                        child: AspectRatio(
                                          aspectRatio: 4 / 3,
                                          child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(5.0)),
                                                image: DecorationImage(
                                                    image: NetworkImage(
                                                      "https://images.igdb.com/igdb/image/upload/t_screenshot_big/${_games.screenshot[index].imageId}.jpg",
                                                    ),
                                                    fit: BoxFit.cover)),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      ))
                    ],
                  )
                ]),
          )
        ],
      ),
    );
  }
}
