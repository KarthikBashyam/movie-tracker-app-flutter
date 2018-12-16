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
    return Card(
        child: ListView(
      children: <Widget>[
        ListTile(
          leading: Icon(IconData(0xeb03, fontFamily: 'director')),
          title: Text(movie.director),
        ),
        ListTile(
          leading: Icon(Icons.rate_review),
          title: Text(movie.rating.toString()),
        ),
      ],
    ));
  }
}
