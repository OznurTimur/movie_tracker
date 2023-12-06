import 'package:flutter/material.dart';
import 'package:movie_tracker/screens/user_profile_screen.dart';
import 'package:movie_tracker/screens/movie_search_screen.dart';
import 'package:movie_tracker/screens/actor_search_screen.dart';
import 'package:movie_tracker/screens/watchlist_screen.dart';
import 'package:movie_tracker/screens/ratings.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
            ),
            child: Text('Menu'),
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('User Profile'),
            onTap: () {
              Navigator.pop(context); // Close the drawer
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const UserProfileScreen()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.search),
            title: const Text('Search Movie'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SearchScreen()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.search),
            title: const Text('Search Actor/Actress'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ActorSearchScreen()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.list_alt_sharp),
            title: const Text('Watchlists'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Watchlists()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.score_sharp),
            title: const Text('Ratings'),
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
