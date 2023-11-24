import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_tracker/models/Movie.dart';
import '../api/api.dart';
import '../widgets/trending_slider.dart';
import 'package:movie_tracker/screens/user_profile_screen.dart';


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
      backgroundColor: Color.fromARGB(255, 113, 189, 113),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 5, 67, 27),
        elevation: 0,
        title: Image.asset(
          'assets./blutv2417.jpg',
          fit:BoxFit.cover,
          height: 60,
          filterQuality: FilterQuality.high,
        ),
        centerTitle: true,
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