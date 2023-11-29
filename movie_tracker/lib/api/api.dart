import 'dart:convert';

import 'package:movie_tracker/models/Movie.dart';
import 'package:movie_tracker/models/Media.dart';
import 'package:movie_tracker/models/Actor.dart';
import 'package:movie_tracker/models/TVShow.dart';
import 'package:http/http.dart' as http;

class Api {
  static const apiKey = "6049c47350887cca020dd26ddd5f1ad2";
  static const accountId = "20705651";
  static const trendingUrl =
      "https://api.themoviedb.org/3/trending/movie/day?api_key=$apiKey";
  static const trendingTVShowUrl =
      "https://api.themoviedb.org/3/trending/tv/day?api_key=$apiKey";
  static const searchMovie =
      "https://api.themoviedb.org/3/search/movie?api_key=$apiKey";
  static const searchTVShow =
      "https://api.themoviedb.org/3/search/tv?api_key=$apiKey";
  static const searchActor = 
      "https://api.themoviedb.org/3/search/person?api_key=$apiKey";
  static const rateMovieUrl =
      "https://api.themoviedb.org/3/movie?api_key=$apiKey";
  static const addToWatchlistUrl =
      "https://api.themoviedb.org/3/account/20705651/watchlist?api_key=$apiKey";
  static const baseUrl = "https://api.themoviedb.org/3/";
  static const creditsEndpoint = "movie";
  static const filmographyEndpoint = "person";
  static const userId = "20705651";
  static const sessionId="";
  static const token ="a9b326c5ed5716135dbc4e7ca3dde90d593b932d";

  String getCreditsUrl(int movieId) {
    return "$baseUrl$creditsEndpoint/$movieId/credits?api_key=$apiKey";
  }

  String getFilmographyUrl(int actorId) {
    return "$baseUrl$filmographyEndpoint/$actorId/combined_credits?api_key=$apiKey&language=en-US";
  }

  Future<Map<int, String>> fetchGenresMap() async {

  final String url = 'https://api.themoviedb.org/3/genre/movie/list?api_key=$apiKey';

  try {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      Map<String, dynamic> genreData = json.decode(response.body);
      Map<int, String> genresMap = {};

      // Extract genre information and populate the genresMap
      List<dynamic> genres = genreData['genres'] ?? [];
      for (final genre in genres) {
        genresMap[genre['id']] = genre['name'];
      }

      return genresMap;
    } else {
      // Handle API call error, throw an exception, or return a default value
      throw Exception('Failed to fetch genre data');
    }
  } catch (e) {
    // Handle other errors that might occur during the process
    throw Exception('Error: $e');
  }
}

  Future<Map<String, dynamic>?> fetchAccountDetails() async {
    final url = Uri.parse('$baseUrl/account/$userId');
    final token =
        'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI2MDQ5YzQ3MzUwODg3Y2NhMDIwZGQyNmRkZDVmMWFkMiIsInN1YiI6IjY1NTNhYWNkNTM4NjZlMDBmZjA1ZjNmMiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.hy8Nz4pWPueNlz0-C0qYYB_aDFO12hMfqQuDMVljTh4'; // Replace with your actual Bearer token
    final headers = {
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
    };

    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      print('Failed to fetch account details');
      return null;
    }
  }

  Future<List<Movie>> getTrendingMovies() async {
    final response = await http.get(
        Uri.parse(trendingUrl)); // Use Uri.parse to create Uri from a String
    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body)['results'] as List;
      return decodedData.map((movie) => Movie.fromJson(movie)).toList();
    } else {
      // If the response status code is not 200, you might want to handle the error case.
      throw Exception('Failed to load trending movies');
    }
  }

  Future<List<TVShow>> getTrendingTVShows() async {
    final response = await http.get(Uri.parse(
        trendingTVShowUrl)); // Use Uri.parse to create Uri from a String
    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body)['results'] as List;
      return decodedData.map((tvshow) => TVShow.fromJson(tvshow)).toList();
    } else {
      // If the response status code is not 200, you might want to handle the error case.
      throw Exception('Failed to load trending tv series');
    }
  }

  Future<List<Movie>> getMovieSearch(String query) async {
    String searchUrl = '$searchMovie&query=$query';

    final response = await http.get(Uri.parse(searchUrl));

    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body)['results'] as List;
      return decodedData.map((item) => Movie.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load movies');
    }
  }

   Future<List<TVShow>> getTVSearch(String query) async {
    String searchUrl = '$searchTVShow&query=$query';

    final response = await http.get(Uri.parse(searchUrl));

    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body)['results'] as List;
      return decodedData.map((item) => TVShow.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load TV shows');
    }
  }

   Future<List<Actor>> getActorSearch(String query) async {
    String searchUrl = '$searchActor&query=$query';

    final response = await http.get(Uri.parse(searchUrl));

    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body)['results'] as List;
      return decodedData.map((item) => Actor.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load actors');
    }
  }



  Future<void> rateMovie(int movieId, double rating) async {
    Map<String, dynamic> requestBody = {
      'value': rating,
    };
    final response = await http.post(
      Uri.parse(rateMovieUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(requestBody),
    );
    if (response.statusCode == 200) {
      print('Movie rated successfully');
    } else {
      throw Exception('Failed to rate the movie');
    }
  }

  Future<Actor> fetchActorDetails(int actorId) async {
    // Construct the URL to fetch actor details
    String actorDetailsUrl =
        'https://api.themoviedb.org/3/person/$actorId?api_key=$apiKey&language=en-US';

    try {
      final response = await http.get(Uri.parse(actorDetailsUrl));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return Actor.fromJson(data);
      } else {
        throw Exception('Failed to load actor details');
      }
    } catch (e) {
      print('Error fetching actor details: $e');
      throw Exception('Failed to load actor details');
    }
  }

  Future<Media> fetchMediaDetails(int mediaId, String mediaType) async {

   String mediaDetailsUrl = 'https://api.themoviedb.org/3/$mediaType/$mediaId?api_key=$apiKey';

   try {
      final response = await http.get(Uri.parse(mediaDetailsUrl));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return Media.fromJson(data);
      } else {
        throw Exception('Failed to load media details');
      }
    } catch (e) {
      print('Error fetching actor details: $e');
      throw Exception('Failed to load media details');
    } 

  }


Future<String> createSession() async {
  final response = await http.post(
    Uri.https('api.themoviedb.org', '/3/authentication/session/new', {
      'api_key': apiKey,
    }),
    headers: {
      'Content-Type': 'application/json;charset=utf-8',
    },
    body: '{"request_token":"$token"}',
  );

  if (response.statusCode == 200) {
    final sessionId = response.body;
    print('Session ID: $sessionId');
    return sessionId;
  } else {
    throw Exception('Failed to create session');
  }
}

Future<void> addToWatchlist(int id, String mediatype, String sessionId) async {
  final url = Uri.https(
    'api.themoviedb.org',
    '/3/account/$accountId/watchlist',
    {
      'api_key': apiKey,
      'session_id': sessionId,
    },
  );

  final response = await http.post(
    url,
    headers: {
      'Content-Type': 'application/json;charset=utf-8',
    },
    body: '{"media_type":$mediatype,"media_id":$id,"watchlist":true}',
  );

  if (response.statusCode == 201) {
    print('Movie added to watchlist successfully!');
  } else {
    print('Failed to add movie to watchlist: ${response.body}');
  }
}

}
