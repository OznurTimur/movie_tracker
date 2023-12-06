import 'package:flutter/material.dart';
import 'package:movie_tracker/api/api.dart';
import 'package:movie_tracker/models/Movie_model.dart';
import 'package:movie_tracker/models/TVShow_model.dart';
import 'package:movie_tracker/widgets/back_button.dart';
import 'package:movie_tracker/screens/media_details_screen.dart';

class Ratings extends StatefulWidget {
  const Ratings({super.key});

  @override
  _RatingsState createState() => _RatingsState();
}

class _RatingsState extends State<Ratings> {
  final Api api = Api();
  List<Map<String, dynamic>> ratedMovies = [];
  List<Map<String, dynamic>> ratedTVShows = [];

  @override
  void initState() {
    super.initState();
    fetchRatedMovies();
    fetchRatedTVShows();
  }

  Future<void> fetchRatedMovies() async {
    final Map<String, dynamic>? data = await api.fetchUserRatedMovies();
    if (data != null) {
      setState(() {
        ratedMovies = List<Map<String, dynamic>>.from(data['results']);
      });
    }
  }

  Future<void> fetchRatedTVShows() async {
    final Map<String, dynamic>? data = await api.fetchUserRatedTVShows();
    if (data != null) {
      setState(() {
        ratedTVShows = List<Map<String, dynamic>>.from(data['results']);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Ratings'),
          leading: const BackBtn(),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Movies'),
              Tab(text: 'TV Shows'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildRatedListMovie(ratedMovies),
            _buildRatedListTV(ratedTVShows),
          ],
        ),
      ),
    );
  }

  Widget _buildRatedListTV(List<Map<String, dynamic>> ratedList) {
    return ratedList.isEmpty
        ? const Center(child: CircularProgressIndicator())
        : ListView.builder(
            itemCount: ratedList.length,
            itemBuilder: (context, index) {
              String posterPath = ratedList[index]['poster_path'];
              double rating = ratedList[index]['rating']?.toDouble() ?? 0.0;
              String name = ratedList[index]['name'];

              return GestureDetector(
             
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
  

  Widget _buildRatedListMovie(List<Map<String, dynamic>> ratedList) {
    return ratedList.isEmpty
        ? const Center(child: CircularProgressIndicator())
        : ListView.builder(
            itemCount: ratedList.length,
            itemBuilder: (context, index) {
              String posterPath = ratedList[index]['poster_path'];
              double rating = ratedList[index]['rating']?.toDouble() ?? 0.0;
              String name = ratedList[index]['title'];

              return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailsScreen(
                      media: Movie.fromJson(ratedList[index]),
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
}}