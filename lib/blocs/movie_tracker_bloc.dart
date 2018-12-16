import 'dart:async';
import 'package:flutter_world/movie.dart';
import 'package:rxdart/rxdart.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' show json, utf8;

class MovieTrackerBloc {
  final url = 'http://10.0.2.2:4000/movies';

  final _moviesSubject = BehaviorSubject<List<Movie>>();

  Stream<List<Movie>> get movies => _moviesSubject.stream;

  MovieTrackerBloc() {
    fetchMovies().then((movies) {
      _moviesSubject.add(movies);
    });
  }

  Future<List<Movie>> fetchMovies() async {
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final movies = json.decode(response.body).cast<Map<String, dynamic>>();
      return movies.map<Movie>((json) => Movie.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load movies');
    }
  }

  Map<String, String> headers = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
  };

  void saveMovie(Movie movie) async {
    final response = await http.post(url,
        body: json.encode(movie.toJson()), headers: headers);
    if (response.statusCode == 200) {
      _moviesSubject.add(List.unmodifiable([]
        ..addAll(_moviesSubject.value ?? [])
        ..add(movie)));
    } else {
      throw Exception('Failed to save movie');
    }
  }

  void deleteMovie(String id) async {
    final response = await http.delete(url+'/$id', headers: headers);
    if(response.statusCode == 200) {

    }
  }
}
