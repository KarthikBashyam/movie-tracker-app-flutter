import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_world/Movie.dart';
import 'dart:convert' show json, utf8;
import 'dart:io';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
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
  List<Movie> movieList = new List<Movie>();

  final font = TextStyle(
    fontSize: 20.0,
  );

  @override
  void initState() {
    fetchMovies().then((movies) {
      print(movies);
      this.movieList = movies;
    }).catchError((error) {});
  }

  Future<List<Movie>> fetchMovies() async {
    final response = await http.get('http://10.0.2.2:4000/movies');
    if (response.statusCode == 200) {
      //print(json.decode(response.body));
      final movies = json.decode(response.body).cast<Map<String, dynamic>>();
      return movies.map<Movie>((json) => Movie.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load movies');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Movie Tracker'),
        //actions: <Widget>[IconButton(icon: Icon(Icons.list))],
      ),
      body: buildList(),
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

  Widget buildList() {
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
