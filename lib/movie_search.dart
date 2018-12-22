import 'package:flutter/material.dart';
import 'package:flutter_world/movie.dart';
import 'package:flutter_world/blocs/movie_tracker_bloc_provider.dart';

class MovieSearch extends SearchDelegate<Movie> {
  @override
  Widget buildSuggestions(BuildContext context) {
    return StreamBuilder<List<Movie>>(
      stream: MovieTrackerBlocProvider.of(context).movies,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: Text(
              'No Movies',
              style: TextStyle(fontSize: 20),
            ),
          );
        } else {
          return ListView.builder(itemBuilder: (context, i) {
            List<Movie> movies = snapshot.data
                .where((m) => m.name.toLowerCase().contains(query))
                .toList();
            if (i < movies.length) {
              return ListTile(
                title: Text(movies[i].name),
              );
            }
          });
        }
      },
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }
}
