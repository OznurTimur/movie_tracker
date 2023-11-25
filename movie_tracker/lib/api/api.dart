import 'dart:convert';
import 'package:movie_tracker/models/Movie.dart';
import 'package:http/http.dart' as http;

class Api{
  static const apiKey="6049c47350887cca020dd26ddd5f1ad2";
  static const trendingUrl="https://api.themoviedb.org/3/trending/movie/day?api_key=6049c47350887cca020dd26ddd5f1ad2";
  static const searchMovies= "https://api.themoviedb.org/3/search/movie?api_key=$apiKey";
   

Future<List<Movie>> getTrendingMovies() async {
    final response = await http.get(Uri.parse(trendingUrl)); // Use Uri.parse to create Uri from a String
    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body)['results'] as List;
      return decodedData.map((movie)=>Movie.fromJson(movie)).toList();
    } else {
      // If the response status code is not 200, you might want to handle the error case.
      throw Exception('Failed to load trending movies');
    }
  }

  Future<List<Movie>> getSearchedMovies(String query) async {

  String searchUrl = '$searchMovies&query=$query';

  final response = await http.get(Uri.parse(searchUrl as String));

  if (response.statusCode == 200) {
     final decodedData = json.decode(response.body)['results'] as List;
      return decodedData.map((movie)=>Movie.fromJson(movie)).toList();
    } else {
      // If the response status code is not 200, you might want to handle the error case.
      throw Exception('Failed to load searched movie');
  }
}

}