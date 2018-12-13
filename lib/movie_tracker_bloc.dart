import 'dart:async';
import 'package:flutter_world/movie.dart';
import 'package:rxdart/rxdart.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' show json, utf8;

class MovieTrackerBloc {
  final _moviesSubject = BehaviorSubject<List<Movie>>();

  Stream<List<Movie>> get movies => _moviesSubject.stream;

  MovieTrackerBloc() {
    fetchMovies().then((movies) {
      _moviesSubject.add(movies);
    });
  }

  Future<List<Movie>> fetchMovies() async {
    final response = await http.get('http://10.0.2.2:4000/movies');
    if (response.statusCode == 200) {
      final movies = json.decode(response.body).cast<Map<String, dynamic>>();
      return movies.map<Movie>((json) => Movie.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load movies');
    }
  }
}
