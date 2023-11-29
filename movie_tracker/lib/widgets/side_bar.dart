import 'package:flutter/material.dart';
import 'package:movie_tracker/screens/user_profile_screen.dart';
import 'package:movie_tracker/screens/movie_search_screen.dart';
import 'package:movie_tracker/screens/tvshow_search_screen.dart';
import 'package:movie_tracker/screens/actor_search_screen.dart';
import 'package:movie_tracker/screens/watchlist_screen.dart';
import 'package:movie_tracker/screens/ratings.dart';

class Sidebar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
            ),
            child: Text('Menu'),
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('User Profile'),
            onTap: () {
              Navigator.pop(context); // Close the drawer
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => UserProfileScreen()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.search),
            title: Text('Search Movie'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SearchScreen()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.search),
            title: Text('Search TV Show'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TVSearchScreen()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.search),
            title: Text('Search Actor/Actress'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ActorSearchScreen()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.list_alt_sharp),
            title: Text('Watchlists'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Watchlists()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.score_sharp),
            title: Text('Ratings'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Ratings()),
              );
            },
          ),
        ],
      ),
    );
  }
}
