import 'package:flutter/material.dart';
import 'package:movie_tracker/api/api.dart';
import 'package:movie_tracker/widgets/back_button.dart';
import 'package:movie_tracker/models/Movie_model.dart';
import 'package:movie_tracker/models/Media_model.dart';
import 'package:movie_tracker/screens/media_details_screen.dart';

class Watchlists extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _WatchlistsState createState() => _WatchlistsState();
}

class _WatchlistsState extends State<Watchlists> {
  final Api api = Api();
  // ignore: non_constant_identifier_names
  List<Map<String, dynamic>> TVlist = [];
  // ignore: non_constant_identifier_names
  List<Map<String, dynamic>> MovieList = [];

  @override
  void initState() {
    super.initState();
    fetchWatchlistedMovies();
    fetchWatchlistedTVShows();
  }

  Future<void> fetchWatchlistedMovies() async {
    final Map<String, dynamic>? data = await api.fetchWatchlistedMovies();
    if (data != null) {
      setState(() {
        MovieList = List<Map<String, dynamic>>.from(data['results']);
      });
    }
  }

  Future<void> fetchWatchlistedTVShows() async {
    final Map<String, dynamic>? data = await api.fetchWatchlistedTVShows();
    if (data != null) {
      setState(() {
        TVlist = List<Map<String, dynamic>>.from(data['results']);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Number of tabs (Movies and TV Shows)
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Watchlists'),
          leading: const BackBtn(),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'TV Shows'),
              Tab(text: 'Movies'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildWatchlistTV(TVlist),
            _buildWatchlistMovie(MovieList),
          ],
        ),
      ),
    );
  }

  Widget _buildWatchlistMovie(List<Map<String, dynamic>> userWatchlist) {
    return userWatchlist.isEmpty
        ? const Center(child: CircularProgressIndicator())
        : ListView.builder(
            itemCount: userWatchlist.length,
            itemBuilder: (context, index) {
              String posterPath = userWatchlist[index]['poster_path'];
              String name = userWatchlist[index]['title'];

              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailsScreen(
                        media: Movie.fromJson(userWatchlist[index]),
                      ),
                    ),
                  );
                },
                child: ListTile(
                  leading: Image.network(
                    'https://image.tmdb.org/t/p/w200/$posterPath',
                    width: 50,
                    height: 50,
                  ),
                  title: Text(name),
                ),
              );
            },
          );
  }

  Widget _buildWatchlistTV(List<Map<String, dynamic>> userWatchlist) {
    return userWatchlist.isEmpty
        ? const Center(child: CircularProgressIndicator())
        : ListView.builder(
            itemCount: userWatchlist.length,
            itemBuilder: (context, index) {
              String posterPath = userWatchlist[index]['poster_path'];
              String name = userWatchlist[index]['name'];

              return GestureDetector(
                
                child: ListTile(
                  leading: Image.network(
                    'https://image.tmdb.org/t/p/w200/$posterPath',
                    width: 50,
                    height: 50,
                  ),
                  title: Text(name),
                ),
              );
            },
          );
  }
}
