// Should have a search box
// user can search for movies/tv shows / actors
// app shows at least 10 latest searches
// when user submits a search at least 10 items appear.
// The user can navigate to a page of the result

import 'package:flutter/material.dart';
import 'package:movie_tracker/models/TVShow.dart';
import 'package:movie_tracker/api/api.dart';
import 'package:movie_tracker/screens/media_details_screen.dart';


class TVSearchScreen extends StatefulWidget {
  @override
  _TVSearchScreenState createState() => _TVSearchScreenState();
}

class _TVSearchScreenState extends State<TVSearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  Api api = Api();
  List<TVShow> searched = [];
  List<String> recentSearches = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              onChanged: (value) async {
                String query = value;
                print('Search text changed: $value');
                if (query.isNotEmpty) {
                  List<TVShow> results = await api.getTVSearch(query);
                   print('API Results: $results');
                  setState(() {
                    searched = results;
                  });
                } else {
                  setState(() {
                    searched = [];
                  });
                }
              },
              onSubmitted: (value) async {
                String query = value;
                if (query.isNotEmpty) {
                  List<TVShow> results = await api.getTVSearch(query);
                  setState(() {
                    searched = results;
                    recentSearches.insert(0,
                        query); // Add the query to recent searches at the beginning
                    if (recentSearches.length > 10) {
                      recentSearches
                          .removeLast(); // Keep only the last 10 searches
                    }
                  });
                }
              },
              decoration: InputDecoration(
                hintText: 'Search for TV shows',
                suffixIcon: recentSearches.isEmpty
                    ? IconButton(
                        icon: Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          setState(() {
                            searched = [];
                          });
                        },
                      )
                    : DropdownButton<String>(
                        icon: Icon(Icons.keyboard_arrow_down),
                        items: recentSearches.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? selectedQuery) async {
                          _searchController.text = selectedQuery ?? '';
                          // Trigger search when a recent query is selected
                           List<TVShow> results = await api.getTVSearch(selectedQuery ?? '');
                           setState(() {
                           searched = results;
                          });
                        },
                      ),
              ),
            ),
          ),
          Expanded(
            child: searched.isEmpty
                ? Center(
                    child: Text('Nothing found..'),
                  )
                : ListView.builder(
                    itemCount: searched.length,
                    itemBuilder: (context, index) {
                      final item = searched[index];
                      String displayText = item.title;                       
                      return ListTile(
                        title: Text(displayText),
                        onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailsScreen(
                                  media: searched[index],
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
