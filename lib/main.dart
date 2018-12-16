import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_world/movie.dart';
import 'package:flutter_world/blocs/movie_tracker_bloc_provider.dart';
import 'package:flutter_world/blocs/movie_tracker_bloc.dart';
import 'package:flutter_world/movie_search.dart';
import 'package:flutter_world/movie_detail.dart';
import 'package:flutter_world/add_movie.dart';
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
        onPressed: () {
          showModalBottomSheet(
              context: context,
              builder: (BuildContext context) {
                return AddMovie();
              }).then((response) {}).catchError((err) {

          });
        },
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
      // if (i.isOdd) return Divider(height: 10.0,);
      if (i < movieList.length) {
        final movie = movieList[i];
        return buildRow(movie);
      }
    });
  }

  Widget buildRow(Movie movie) {
    return Dismissible(
      key: Key(movie.id),
      background: Container(color: Colors.yellow),
      child: ListTile(
        title: Text(movie.name,
            style: TextStyle(fontFamily: 'Corda-Regular', fontSize: 20)),
        trailing: Checkbox(
          value: false,
        ),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => MovieDetail(movie: movie)));
        },
      ),
      onDismissed: (direction) {
        print(movie.id);
        MovieTrackerBlocProvider.of(context).deleteMovie(movie.id);
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
