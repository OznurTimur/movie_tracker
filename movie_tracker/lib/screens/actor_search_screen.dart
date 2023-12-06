import 'package:flutter/material.dart';
import 'package:movie_tracker/models/Actor_model.dart';
import 'package:movie_tracker/api/api.dart';
import 'package:movie_tracker/screens/actor_details.dart';

class ActorSearchScreen extends StatefulWidget {
  const ActorSearchScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ActorSearchScreenState createState() => _ActorSearchScreenState();
}

class _ActorSearchScreenState extends State<ActorSearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  Api api = Api();
  List<dynamic> searched = [];
  List<String> recentSearches = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
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
                  List<Actor> results = await api.getActorSearch(query);
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
                  List<Actor> results = await api.getActorSearch(query);
                  setState(() {
                    searched = results;
                    recentSearches.insert(0,
                        query); 
                    if (recentSearches.length > 10) {
                      recentSearches
                          .removeLast(); 
                    }
                  });
                }
              },
              decoration: InputDecoration(
                hintText: 'Search for actors',
                suffixIcon: recentSearches.isEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          setState(() {
                            searched = [];
                          });
                        },
                      )
                    : DropdownButton<String>(
                        icon: const Icon(Icons.keyboard_arrow_down),
                        items: recentSearches.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? selectedQuery) async {
                          _searchController.text = selectedQuery ?? '';
                          // Trigger search when a recent query is selected
                           List<Actor> results = await api.getActorSearch(selectedQuery ?? '');
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
                ? const Center(
                    child: Text('Nothing found..'),
                  )
                : ListView.builder(
                    itemCount: searched.length,
                    itemBuilder: (context, index) {
                      final item = searched[index];
                      String displayText = item.name;                       
                      return ListTile(
                        title: Text(displayText),
                        onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ActorDetailsScreen(
                                  actor: searched[index],
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
