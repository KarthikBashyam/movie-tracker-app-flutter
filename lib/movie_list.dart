import 'package:flutter/material.dart';
import 'package:flutter_world/blocs/movie_tracker_bloc_provider.dart';
import 'package:flutter_world/movie_detail.dart';
import 'package:flutter_world/movie.dart';
import 'package:flutter_world/movie_search.dart';
import 'package:flutter_world/loading_widget.dart';
import 'package:flutter_world/add_movie.dart';

class MovieList extends StatefulWidget {
  @override
  State createState() {
    return MovieListState();
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
          stream: MovieTrackerBlocProvider.of(context).movies,
          builder: (context, snapshot) => snapshot.hasData
              ? buildList(snapshot.data)
              : LoadingSpinnerWidget()),
      drawer: buildDrawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddMovie()));
        },
        backgroundColor: Colors.lime,
        child: Icon(
          Icons.movie,
        ),
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
            decoration: BoxDecoration(color: Colors.lime),
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
    return ListView.separated(
        itemCount: movieList.length,
        separatorBuilder: (BuildContext context, int index) =>
            Divider(height: 10),
        itemBuilder: (context, i) {
          if (i < movieList.length) {
            final movie = movieList[i];
            return buildListTile(movie);
          }
        });
  }

  Widget buildListTile(Movie movie) {
    return Dismissible(
      key: Key(movie.id),
      background: Container(color: Colors.yellow),
      direction: DismissDirection.endToStart,
      child: ListTile(
        title: Text(movie.name,
            style: TextStyle(fontFamily: 'Corda-Regular', fontSize: 18)),
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
        if (direction == DismissDirection.endToStart) {
          MovieTrackerBlocProvider.of(context).deleteMovie(movie.id);
        }
      },
    );
  }
}
