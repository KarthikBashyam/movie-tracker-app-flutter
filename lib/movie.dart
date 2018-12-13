///
class Movie {

  final String id;

  final String name;

  final String director;

  final int rating;

  final String status;

  final String created;

  final String language;

  Movie({this.id, this.name, this.director, this.rating, this.status,
      this.created, this.language});

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id : json['_id'],
      name: json['name'],
      director: json['director'],
      rating:  json['rating'],
      status : json['sstatus'],
      created: json['created'],
      language: json['language']
    );
  }

}