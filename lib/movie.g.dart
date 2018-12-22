// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Movie _$MovieFromJson(Map<String, dynamic> json) {
  return Movie(
      id: json['_id'] as String,
      name: json['name'] as String,
      director: json['director'] as String,
      rating: json['rating'] as int,
      status: json['status'] as String,
      created: json['created'] as String,
      language: json['language'] as String);
}

Map<String, dynamic> _$MovieToJson(Movie instance) => <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'director': instance.director,
      'rating': instance.rating,
      'status': instance.status,
      'created': instance.created,
      'language': instance.language
    };
