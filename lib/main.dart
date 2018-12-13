import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_world/movie.dart';
import 'package:flutter_world/movie_tracker_bloc_provider.dart';
import 'package:flutter_world/movie_tracker_bloc.dart';
import 'package:flutter_world/movie_search.dart';
import 'package:flutter_world/loading_widget.dart';
import 'dart:convert' show json, utf8;
import 'dart:io';

void main() => runApp(MovieTrackerBlocProvider(child: MovieTrackerApp()));

class MovieTrackerApp extends StatelessWidget {
  MovieTrackerApp({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie Tracker',
      theme: ThemeData(primaryColor: Colors.yellow),
      home: MovieList(),
    );
  }
}

class MovieListState extends State<MovieList> {
  final font = TextStyle(
    fontSize: 20.0,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Movie Tracker'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: MovieSearch());
            },
          )
        ],
      ),
      body: StreamBuilder<List<Movie>>(
          //stream: widget.bloc.movies,
          stream: MovieTrackerBlocProvider.of(context).movies,
          builder: (context, snapshot) => snapshot.hasData
              ? buildList(snapshot.data)
              : LoadingSpinnerWidget()),
      drawer: buildDrawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: null,
        backgroundColor: Colors.yellow,
        child: Icon(Icons.add),
      ),
    );
  }

  Widget buildDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text(
              'Movies',
              style: font,
            ),
            decoration: BoxDecoration(color: Colors.yellow),
          ),
          ListTile(
            title: Text(
              'Yet to Watch',
              style: font,
            ),
            onTap: () {},
          ),
          ListTile(
            title: Text(
              'Completed',
              style: font,
            ),
            onTap: () {},
          )
        ],
      ),
    );
  }

  Widget buildList(List<Movie> movieList) {
    return ListView.builder(itemBuilder: (context, i) {
      // if (i.isOdd) return Divider();
      if (i <= movieList.length - 1) {
        final movie = movieList[i];
        return buildRow(movie);
      }
    });
  }

  Widget buildRow(Movie movie) {
    final bool alreadyWatched = (movie.status != 'PENDING');
    return ListTile(
      title: Text(movie.name, style: font),
      trailing: Icon(alreadyWatched ? Icons.favorite : Icons.favorite_border,
          color: alreadyWatched ? Colors.red : null),
      onTap: () {
        setState(() {
          if (alreadyWatched) {
            //saved.remove(pair);
          } else {
            //saved.add(pair);
          }
        });
      },
    );
  }
}

class MovieList extends StatefulWidget {
  @override
  State createState() {
    return MovieListState();
  }
}
