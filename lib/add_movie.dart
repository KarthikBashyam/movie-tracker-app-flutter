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
  String _language;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('New Movie'),
          actions: [
            FlatButton(
              child: Text('SAVE'),
              onPressed: _saveMovie,
            )
          ],
          leading: IconButton(
            icon: Icon(Icons.clear),
            onPressed: () {
              Navigator.of(context).pop(null);
            },
          ),
        ),
        body: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(
                      hintText: 'Movie Name', hintStyle: TextStyle(fontSize: 30),border: OutlineInputBorder()),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter movie name';
                    }
                  },
                  onSaved: (String val) {
                    _name = val;
                  },
                  style: TextStyle(height: 1,fontSize: 30,color: Colors.black,),
                ),
                TextFormField(
                  decoration: InputDecoration(
                      hintText: 'Director', border: OutlineInputBorder()),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter movie name';
                    }
                  },
                  onSaved: (String val) {
                    _director = val;
                  },
                ),
                Divider(indent: 20,),
                ChoiceChip(label: Text('TV Show'),selected: false,onSelected: (value) => {

                },)
              ],
            )));
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
    Navigator.of(context).pop(null);
  }
}
