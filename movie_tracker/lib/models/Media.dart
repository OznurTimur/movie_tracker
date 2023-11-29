class Media {
  String title;
  String backDropPath;
  String originalTitle;
  String overview;
  String posterPath;
  String releaseDate;
  double voteAverage;
  int id;
  List<dynamic> genre;
  String mediaType;
  int? runTime;

  

  Media({
    required this.title,
    required this.backDropPath,
    required this.originalTitle,
    required this.overview,
    required this.posterPath,
    required this.releaseDate,
    required this.voteAverage,
    required this.genre,
    required this.id,
    required this.mediaType,
    required this.runTime,
    
  });

  factory Media.fromJson(Map<String, dynamic> json) {
    return Media(
      title: json["title"] ?? "",
      backDropPath: json["backdrop_path"],
      originalTitle: json["original_title"],
      overview: json["overview"],
      posterPath: json["poster_path"],
      releaseDate: json["release_date"],
      voteAverage: json["vote_average"],
      genre: json["genre_ids"],
      id: json["id"],
      mediaType: json["media_type"],
      runTime: json["runtime"] ?? 0
      
      
    );
  }
}
