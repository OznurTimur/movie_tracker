// My watchlist
// Movies / TV series that you want to see
// You should include the poster for each item

import 'package:flutter/material.dart';
import 'package:movie_tracker/models/Media.dart';
import 'package:movie_tracker/api/api.dart';

// ignore: must_be_immutable
class Watchlists extends StatelessWidget {
  final Api api = Api();
  List<Media> userWatchlist = [];

  Watchlists({super.key}); 

  void addToWatchlist(Media movie) {
    // Add the movie to the user's watchlist
    userWatchlist.add(movie);
  }

 
  
 @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Watchlist'),
      ),
      body: ListView.builder(
        
        itemCount: userWatchlist.length,
        itemBuilder: (context, index) {
          return ListTile(
            //leading: Image.network(userWatchlist[index].posterUrl),
            title: Text(userWatchlist[index].title),
            
          );
        },
      ),
    );
   
         
      
    }

}