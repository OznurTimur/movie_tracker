import 'Media.dart';


class TVShow extends Media {
  TVShow({
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
    required int? runTime
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

  factory TVShow.fromJson(Map<String, dynamic> json) {
    return TVShow(
      title: json["name"] ?? " ", 
      backDropPath: json["backdrop_path"],
      originalTitle: json["original_name"],
      overview: json["overview"],
      posterPath: json["poster_path"],
      releaseDate: json["first_air_date"],
      voteAverage: json["vote_average"],
      genre: json["genre_ids"],
      id: json["id"],
      mediaType: json["media_type"],
      runTime: json["episode_run_time"] ?? 0
    );
  }
}
