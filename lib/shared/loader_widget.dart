import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gamebot/bloc/games_state.dart';

Widget buildLoadingWidget(state) {
  if (state is GameLoadingState) {
    return Center(
      child: Platform.isIOS
          ? CupertinoActivityIndicator()
          : CircularProgressIndicator(),
    );
  }
  return Container();
}
