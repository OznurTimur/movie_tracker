// Should have a search box
// user can search for movies/tv shows / actors
// app shows at least 10 latest searches
// when user submits a search at least 10 items appear.
// The user can navigate to a page of the result

import 'package:flutter/material.dart';
import 'package:movie_tracker/models/Movie.dart'; 
import 'package:movie_tracker/api/api.dart'; 
import 'package:movie_tracker/screens/movie_details.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}


class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  Api api = Api();
  List<Movie> searchedMovies = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Movies'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              onChanged: (value) async {
                String query = value;
                if (query.isNotEmpty) {
                  List<Movie> movies = await api.getSearchedMovies(query);
                  setState(() {
                    searchedMovies = movies;
                  });
                } else {
                  setState(() {
                    searchedMovies = [];
                  });
                }
              },
              onSubmitted: (value) async {
                String query = value;
                if (query.isNotEmpty) {
                  List<Movie> movies = await api.getSearchedMovies(query);
                  setState(() {
                    searchedMovies = movies;
                  });
                }
              },
              decoration: InputDecoration(
                hintText: 'Search for movies',
                suffixIcon: IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: () {
                    _searchController.clear();
                    setState(() {
                      searchedMovies = [];
                    });
                  },
                ),
              ),
            ),
          ),
          Expanded(
            child: searchedMovies.isEmpty
                ? Center(
                    child: Text('No movies found'),
                  )
                : ListView.builder(
                    itemCount: searchedMovies.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(searchedMovies[index].title),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailsScreen(
                                media: searchedMovies[index],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

