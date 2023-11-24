import 'Media.dart';

class TVShow extends Media{

    TVShow({
 required super.title,
     required super.backDropPath,
      required super.originalTitle,
       required super.overview, 
       required super.posterPath, 
       required super.releaseDate,
        required super.voteAverage,
        required super.genre});


        
factory TVShow.fromJson(Map<String, dynamic> json){
 return TVShow(
  title: json["title"] ?? "some title", 
  backDropPath: json["backdrop_path"] ,
   originalTitle: json["original_title"],
    overview: json["overview"], 
    posterPath: json["poster_path"],
      releaseDate: json["release_date"],
       voteAverage: json["vote_average"],
        genre :json["genre_ids"]
       );
}

   
        
    }

