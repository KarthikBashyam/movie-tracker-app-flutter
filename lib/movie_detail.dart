import 'package:flutter/material.dart';
import 'package:flutter_world/movie.dart';

class MovieDetail extends StatelessWidget {
  final Movie movie;

  MovieDetail({this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${movie.name}"),
      ),
      body: buildDetails(movie),
    );
  }

  buildDetails(Movie movie) {

  }
}
