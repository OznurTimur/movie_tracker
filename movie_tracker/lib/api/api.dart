import 'dart:convert';
import 'package:movie_tracker/models/Movie_model.dart';
import 'package:movie_tracker/models/Media_model.dart';
import 'package:movie_tracker/models/Actor_model.dart';
import 'package:movie_tracker/models/TVShow_model.dart';
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

  static const baseUrl = "https://api.themoviedb.org/3/";
  static const creditsEndpoint = "movie";
  static const filmographyEndpoint = "person";
  static const userId = "20705651";

  String getCreditsUrl(int movieId) {
    return "$baseUrl$creditsEndpoint/$movieId/credits?api_key=$apiKey";
  }

  String getFilmographyUrl(int actorId) {
    return "$baseUrl$filmographyEndpoint/$actorId/combined_credits?api_key=$apiKey&language=en-US";
  }

  Future<Map<String, dynamic>?> fetchUserRatedTVShows() async {
    final String url =
        'https://api.themoviedb.org/3/account/$accountId/rated/tv?language=en-US&page=1&sort_by=created_at.asc';

    final Map<String, String> headers = {
      'Authorization':
          'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI2MDQ5YzQ3MzUwODg3Y2NhMDIwZGQyNmRkZDVmMWFkMiIsInN1YiI6IjY1NTNhYWNkNTM4NjZlMDBmZjA1ZjNmMiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.hy8Nz4pWPueNlz0-C0qYYB_aDFO12hMfqQuDMVljTh4',
      'accept': 'application/json',
    };

    final response = await http.get(Uri.parse(url), headers: headers);

    if (response.statusCode == 200) {
      // If the request is successful, parse the JSON response
      Map<String, dynamic> data = json.decode(response.body);
      return data;
    } else {
      // If the request fails, print the error and return null
      print('Request failed with status: ${response.statusCode}');
      return null;
    }
  }

  Future<Map<String, dynamic>?> fetchUserRatedMovies() async {
    final String url =
        'https://api.themoviedb.org/3/account/$accountId/rated/movies?language=en-US&page=1&sort_by=created_at.asc';

    final Map<String, String> headers = {
      'Authorization':
          'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI2MDQ5YzQ3MzUwODg3Y2NhMDIwZGQyNmRkZDVmMWFkMiIsInN1YiI6IjY1NTNhYWNkNTM4NjZlMDBmZjA1ZjNmMiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.hy8Nz4pWPueNlz0-C0qYYB_aDFO12hMfqQuDMVljTh4',
      'accept': 'application/json',
    };

    final response = await http.get(Uri.parse(url), headers: headers);

    if (response.statusCode == 200) {
      // If the request is successful, parse the JSON response
      Map<String, dynamic> data = json.decode(response.body);
      return data;
    } else {
      // If the request fails, print the error and return null
      print('Request failed with status: ${response.statusCode}');
      return null;
    }
  }

  Future<Map<String, dynamic>?> fetchWatchlistedMovies() async {
    final String accessToken =
        'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI2MDQ5YzQ3MzUwODg3Y2NhMDIwZGQyNmRkZDVmMWFkMiIsInN1YiI6IjY1NTNhYWNkNTM4NjZlMDBmZjA1ZjNmMiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.hy8Nz4pWPueNlz0-C0qYYB_aDFO12hMfqQuDMVljTh4';

    final String url =
        'https://api.themoviedb.org/3/account/20705651/watchlist/movies?language=en-US&page=1&sort_by=created_at.asc';

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $accessToken',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load watchlisted movies');
      }
    } catch (e) {
      throw Exception('Failed to fetch watchlisted movies: $e');
    }
  }

  Future<Map<String, dynamic>?> fetchWatchlistedTVShows() async {
    final String accessToken =
        'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI2MDQ5YzQ3MzUwODg3Y2NhMDIwZGQyNmRkZDVmMWFkMiIsInN1YiI6IjY1NTNhYWNkNTM4NjZlMDBmZjA1ZjNmMiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.hy8Nz4pWPueNlz0-C0qYYB_aDFO12hMfqQuDMVljTh4';

    final String url =
        'https://api.themoviedb.org/3/account/20705651/watchlist/tv?language=en-US&page=1&sort_by=created_at.asc';

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $accessToken',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load watchlisted tv shows');
      }
    } catch (e) {
      throw Exception('Failed to fetch watchlisted tv shows: $e');
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

  Future<Actor> fetchActorDetails(int actorId) async {
    // Construct the URL to fetch actor details
    String actorDetailsUrl =
        'https://api.themoviedb.org/3/person/$actorId?api_key=$apiKey';

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
    String mediaDetailsUrl =
        'https://api.themoviedb.org/3/$mediaType/$mediaId?api_key=$apiKey';

    try {
      final response = await http.get(Uri.parse(mediaDetailsUrl));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return Media.fromJson(data);
      } else {
        throw Exception(
            'Failed to load media details. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching media details: $e');
      throw Exception('Failed to load media details. Error: $e');
    }
  }

  Future<String> createGuestSession() async {
    final String url =
        'https://api.themoviedb.org/3/authentication/guest_session/new?api_key=$apiKey';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      final String guestSessionId = result['guest_session_id'];
      print('Guest Session ID: $guestSessionId');
      return guestSessionId;
    } else {
      throw Exception('Failed to create guest session');
    }
  }

  Future<List<Map<String, String>>> fetchAvailableLanguages() async {
    final response = await http.get(Uri.parse(
        'https://api.themoviedb.org/3/configuration/languages?api_key=6049c47350887cca020dd26ddd5f1ad2'));

    if (response.statusCode == 200) {
      List<dynamic> languages = json.decode(response.body);
      List<String> targetLanguages = [
        'en',
        'es',
        'fr'
      ]; // English, Spanish, French
      List<Map<String, String>> selectedLanguages = [];

      languages.forEach((language) {
        if (targetLanguages.contains(language['iso_639_1'])) {
          selectedLanguages.add({
            'name': language['english_name'],
            'iso_639_1': language['iso_639_1'],
          });
        }
      });

      return selectedLanguages;
    } else {
      throw Exception('Failed to load languages');
    }
  }
}
