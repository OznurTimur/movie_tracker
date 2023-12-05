import 'package:flutter/material.dart';
import 'package:movie_tracker/models/Media.dart';
import 'package:movie_tracker/screens/media_details_screen.dart';
import 'package:movie_tracker/api/api.dart';
import 'package:movie_tracker/widgets/back_button.dart';


class Ratings extends StatefulWidget {
  @override
  _RatingsState createState() => _RatingsState();
}

class _RatingsState extends State<Ratings> {
  final Api apiService = Api();
  List<Map<String, dynamic>> ratedMovies = [];
  List<Map<String, dynamic>> ratedTVShows = [];

  @override
  void initState() {
    super.initState();
    fetchRatedMovies();
    fetchRatedTVShows();
  }

  Future<void> fetchRatedMovies() async {
    final Map<String, dynamic>? data = await apiService.fetchUserRatedMovies();
    if (data != null) {
      setState(() {
        ratedMovies = List<Map<String, dynamic>>.from(data['results']);
      });
    }
  }

  Future<void> fetchRatedTVShows() async {
    final Map<String, dynamic>? data = await apiService.fetchUserRatedTVShows();
    if (data != null) {
      setState(() {
        ratedTVShows = List<Map<String, dynamic>>.from(data['results']);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
   return DefaultTabController(
      length: 2, // Number of tabs (Movies and TV Shows)
      child: Scaffold(
        appBar: AppBar(
          title: Text('Ratings'),
          leading: BackBtn(),
          bottom: TabBar(
            tabs: [
              Tab(text: 'Movies'),
              Tab(text: 'TV Shows'),
            ],
          ),
        ),
      body: TabBarView(
        children: [
          _buildRatedList(ratedMovies),
          _buildRatedList(ratedTVShows),
        ],
        ),
      ),
    );
  }
  Widget _buildRatedList(List<Map<String, dynamic>> ratedList) {
    return ratedList.isEmpty
        ? Center(child: CircularProgressIndicator())
        : ListView.builder(
            itemCount: ratedList.length,
            itemBuilder: (context, index) {
              String posterPath = ratedList[index]['poster_path'];
              double rating = ratedList[index]['rating']?.toDouble() ?? 0.0;
               String name = ratedList[index]['media_type'] == 'movie'
                ? ratedList[index]['title']
                : ratedList[index]['name'];

             return GestureDetector(
              onTap: () {
                // Navigate to movie or TV show details screen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailsScreen(
                      media: Media.fromJson(ratedList[index]),
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
                subtitle: Text('Rating: $rating'),
              ),
            );
          },
        );
     }
  }

