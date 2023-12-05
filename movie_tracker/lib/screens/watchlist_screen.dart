import 'package:flutter/material.dart';
import 'package:movie_tracker/models/Movie.dart';
import 'package:movie_tracker/screens/media_details_screen.dart';
import 'package:movie_tracker/api/api.dart';
import 'package:movie_tracker/shared/constants.dart';
import 'package:movie_tracker/widgets/back_button.dart';

class Watchlists extends StatefulWidget {
  @override
  _WatchlistsState createState() => _WatchlistsState();
}

class _WatchlistsState extends State<Watchlists> {
  final Api api = Api();
  List<Map<String, dynamic>>TVlist= [];
  List<Map<String, dynamic>>MovieList = [];

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
    if(data != null){
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
          title: Text('Watchlists'),
          leading: BackBtn(),
          bottom: TabBar(
            tabs: [
              Tab(text: 'TV Shows'),
              Tab(text: 'Movies'),
            ],
          ),
        ),
      body: TabBarView(
        children: [
          _buildWatchlist(TVlist),
          _buildWatchlist(MovieList),
        ],
        ),
      ),
    );
  }

Widget _buildWatchlist(List<Map<String, dynamic>> userWatchlist) {
    return userWatchlist.isEmpty
        ? Center(child: CircularProgressIndicator())
        : ListView.builder(
            itemCount: userWatchlist.length,
            itemBuilder: (context, index) {
              String posterPath = userWatchlist[index]['poster_path'];
               String name = userWatchlist[index]['media_type'] == 'movie'
                ? userWatchlist[index]['title']
                : userWatchlist[index]['name'];

             return GestureDetector(
              onTap: () {
                // Navigate to movie or TV show details screen
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
  }


