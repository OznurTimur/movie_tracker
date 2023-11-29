import 'Media.dart';

class Movie extends Media {
  Movie({
    required String title,
    required String backDropPath,
    required String originalTitle,
    required String overview,
    required String posterPath,
    required String releaseDate,
    required double voteAverage,
    required int id,
    required List<dynamic> genre,
    required String mediaType,
    required int? runTime,
  }) : super(
          title: title,
          backDropPath: backDropPath,
          originalTitle: originalTitle,
          overview: overview,
          posterPath: posterPath,
          releaseDate: releaseDate,
          voteAverage: voteAverage,
          id: id,
          genre: genre,
          mediaType: mediaType,
          runTime:runTime,
         
        );

  factory Movie.fromJson(Map<String, dynamic> json) {

    return Movie(
      title: json["title"] ?? "",
      backDropPath: json["backdrop_path"] ?? '',
      originalTitle: json["original_title"] ?? '',
      overview: json["overview"] ?? '',
      posterPath: json["poster_path"] ?? '',
      releaseDate: json["release_date"] ?? '',
      voteAverage: json["vote_average"]?.toDouble() ?? 0.0,
      genre: ['genre_ids'],
      id: json["id"] ?? 0,
      mediaType: json["media_type"] ?? '',
      runTime:json["runtime"] ?? 0
    );
  }
}