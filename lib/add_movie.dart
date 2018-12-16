import 'package:flutter/material.dart';
import 'package:flutter_world/movie.dart';
import 'package:flutter_world/blocs/movie_tracker_bloc_provider.dart';

class AddMovie extends StatefulWidget {
  @override
  State createState() {
    return AddMovieState();
  }
}

class AddMovieState extends State<AddMovie> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  String _name;
  String _director;

  @override
  Widget build(BuildContext context) {
    return new Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(hintText: 'Add a movie'),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter movie name';
                }
              },
              onSaved: (String val) {
                _name = val;
              },
            ),
            TextFormField(
              decoration: InputDecoration(
                hintText: 'Director',
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter movie name';
                }
              },
              onSaved: (String val) {
                _director = val;
              },
            ),
            ButtonBar(
              children: <Widget>[
                FlatButton(
                  child: Text(
                    'Add',
                  ),
                  onPressed: _saveMovie,
                )
              ],
            )
          ],
        ));
  }

  void _saveMovie() {
    _formKey.currentState.save();
    print("$_name,$_director");
    final movie = Movie(
        name: _name,
        director: _director,
        language: 'test',
        created: '',
        rating: 5,
        status: 'PENDING');

      MovieTrackerBlocProvider.of(context).saveMovie(movie);

  }
}
