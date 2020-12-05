import 'package:flutter/material.dart';

Widget buildErrorWidget(String error) {
  return Center(
    child: Padding(
        padding: const EdgeInsets.all(8),
        child: Text(
          error,
          style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
        )),
  );
}
