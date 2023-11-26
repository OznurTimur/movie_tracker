import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_tracker/models/Movie.dart';
import '../api/api.dart';
import '../widgets/trending_slider.dart';
import 'package:movie_tracker/screens/user_profile_screen.dart';
import 'package:movie_tracker/shared/colors.dart';
import 'package:movie_tracker/screens/search_screen.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

late Future<List<Movie>> trendingMovies;

  @override
  void initState(){
    super.initState();
    trendingMovies=Api().getTrendingMovies();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colours.light_g,
      appBar: AppBar(
        backgroundColor: Colours.dark_g,
        elevation: 0,
        title: Image.asset(
          'assets/blutv2417.jpg',
          fit:BoxFit.cover,
          height: 60,
          filterQuality: FilterQuality.high,
        ),
        centerTitle: true,
      ),

      drawer: Drawer(
        child: ListView(
        padding: EdgeInsets.zero,
        children: [
        const DrawerHeader(
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 5, 67, 27),
        ),
        child: Text('Menu'),
      ),
      ListTile(
         leading: Icon(Icons.person), // Icon for the profile
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
         leading: Icon(Icons.settings),
        title: const Text('Settings'),
        onTap: () {
          
        },
      ),
      ListTile(
            leading: Icon(Icons.search),
            title: Text('Search'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SearchScreen()),
              );
            },
          ),
    ],
  ),
),


      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Text ('Trending Movies',
          style: GoogleFonts.aBeeZee(fontSize:25)),
          const SizedBox(height:16),
           SizedBox(
            child: FutureBuilder(
              future: trendingMovies,
              builder: (context,snapshot){
                if(snapshot.hasError){
                  return Center(
                    child: Text(snapshot.error.toString()),
                    );
                } else if (snapshot.hasData) {
                  return TrendingSlider(snapshot:snapshot);
                } else{
                  return const Center(child:CircularProgressIndicator());
                }
              }),
            )
          ]
        )
        )
        )
    );
  }
}