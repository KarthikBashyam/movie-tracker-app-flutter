import 'package:flutter/material.dart';
import 'package:flutter_world/blocs/movie_tracker_bloc_provider.dart';
import 'package:flutter_world/movie_list.dart';

void main() => runApp(MovieTrackerBlocProvider(child: MovieTrackerApp()));

class MovieTrackerApp extends StatelessWidget {
  MovieTrackerApp({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie Tracker',
      theme: _buildTheme(),
      home: MovieList(),
    );
  }
}

ThemeData _buildTheme() {
  final ThemeData base = ThemeData.light();
  return base.copyWith(
    primaryColor: Colors.lime,
    primaryTextTheme: TextTheme(
      title: TextStyle(fontFamily: 'Corda-Regular', color: Colors.black),
    ),
    primaryIconTheme: base.iconTheme.copyWith(color: Colors.black),
  );
}
