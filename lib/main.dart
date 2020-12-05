import 'package:flutter/material.dart';
import 'package:gamebot/shared/bottom_navigation.dart';
import 'package:gamebot/ui/style/theme_font.dart';
import 'package:gamebot/ui/style/theme_color.dart' as style;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GameBot',
      theme: ThemeData(
        primarySwatch: Colors.cyan,
        primaryColor: style.ThemeColor.backgroundColor,
        canvasColor: style.ThemeColor.backgroundColor,
        textTheme: ThemeFont.textTheme,
      ),
      home: BottomNavigation(),
    );
  }
}
