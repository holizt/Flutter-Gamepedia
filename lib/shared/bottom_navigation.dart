import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:gamebot/ui/home/home_pages.dart';
import 'package:gamebot/ui/news/news_pages.dart';
import 'package:gamebot/ui/profile/profile_pages.dart';
import 'package:gamebot/ui/streaming/streaming_pages.dart';
import 'package:gamebot/ui/style/theme_color.dart' as style;

class BottomNavigation extends StatefulWidget {
  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _currentIndex = 0;

  List _setPages = [
    HomePages(),
    StreamingPages(),
    NewsPages(),
    ProfilPages(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _setPages[_currentIndex],
      bottomNavigationBar: Container(
        child: BottomNavyBar(
          backgroundColor: style.ThemeColor.bottomNavColor,
          selectedIndex: _currentIndex,
          containerHeight: 60,
          animationDuration: Duration(milliseconds: 250),
          onItemSelected: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: <BottomNavyBarItem>[
            BottomNavyBarItem(
              icon: Padding(
                padding: EdgeInsets.only(left: 5),
                child: Icon(
                  Entypo.game_controller,
                  size: 18,
                  color: _currentIndex == 0
                      ? style.ThemeColor.mainColor
                      : Colors.white,
                ),
              ),
              title: Text(
                ' Game',
                style: TextStyle(color: style.ThemeColor.mainColor),
              ),
              activeColor: style.ThemeColor.bottomNavColorActiv,
            ),
            BottomNavyBarItem(
              icon: Padding(
                padding: EdgeInsets.only(left: 5),
                child: Icon(
                  MaterialIcons.ondemand_video,
                  size: 18,
                  color: _currentIndex == 1
                      ? style.ThemeColor.mainColor
                      : Colors.white,
                ),
              ),
              title: Text(
                ' Streaming',
                style: TextStyle(color: style.ThemeColor.mainColor),
              ),
              activeColor: style.ThemeColor.bottomNavColorActiv,
            ),
            BottomNavyBarItem(
              icon: Padding(
                padding: EdgeInsets.only(left: 5),
                child: Icon(
                  FontAwesome.newspaper_o,
                  size: 18,
                  color: _currentIndex == 2
                      ? style.ThemeColor.mainColor
                      : Colors.white,
                ),
              ),
              title: Text(
                ' News',
                style: TextStyle(color: style.ThemeColor.mainColor),
              ),
              activeColor: style.ThemeColor.bottomNavColorActiv,
            ),
            BottomNavyBarItem(
              icon: Padding(
                padding: EdgeInsets.only(left: 5),
                child: Icon(
                  FontAwesome.user_circle_o,
                  size: 18,
                  color: _currentIndex == 3
                      ? style.ThemeColor.mainColor
                      : Colors.white,
                ),
              ),
              title: Text(
                ' Profile',
                style: TextStyle(color: style.ThemeColor.mainColor),
              ),
              activeColor: style.ThemeColor.bottomNavColorActiv,
            ),
          ],
        ),
      ),
    );
  }
}
