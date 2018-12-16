import 'package:json_annotation/json_annotation.dart';
part 'movie.g.dart';

///
@JsonSerializable()
class Movie {
  @JsonKey(nullable: true, includeIfNull: true)
  final String id;
  @JsonKey(nullable: true, includeIfNull: true)
  final String name;
  @JsonKey(nullable: true, includeIfNull: true)
  final String director;
  @JsonKey(nullable: true, includeIfNull: true)
  final int rating;
  @JsonKey(nullable: true, includeIfNull: true)
  final String status;
  @JsonKey(nullable: true, includeIfNull: true)
  final String created;
  @JsonKey(nullable: true, includeIfNull: true)
  final String language;

  Movie(
      {this.id,
      this.name,
      this.director,
      this.rating,
      this.status,
      this.created,
      this.language});

  factory Movie.fromJson(Map<String, dynamic> json) => _$MovieFromJson(json);

  Map<String, dynamic> toJson() => _$MovieToJson(this);

  /*factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id : json['_id'],
      name: json['name'],
      director: json['director'],
      rating:  json['rating'],
      status : json['sstatus'],
      created: json['created'],
      language: json['language']
    );
  }*/

}
