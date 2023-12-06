import 'dart:convert';

import 'package:movie_tracker/models/Media_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_tracker/shared/constants.dart';
import 'package:movie_tracker/widgets/back_button.dart';
import 'package:movie_tracker/api/api.dart';
import 'package:movie_tracker/screens/actor_details.dart';
import 'package:movie_tracker/models/Actor_model.dart';
import 'package:movie_tracker/shared/colors.dart';
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class DetailsScreen extends StatefulWidget {
  final Media media;
  
  // ignore: prefer_const_constructors_in_immutables
  DetailsScreen({
    super.key,
    required this.media,
  });

  @override
  // ignore: library_private_types_in_public_api
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  double? userRating = 0; // To store the user's rating
  Api api = Api(); // Instance of Api class
  late Media media;
  List<Actor> actors = [];
  

  String getYearFromDate(String releaseDate) {
    // Split the date string by "-" to get the parts
    List<String> dateParts = releaseDate.split('-');

    // Extract the year (first part of the split)
    String year = dateParts.isNotEmpty ? dateParts[0] : 'Unknown';

    return year;
  }

  @override
  void initState() {
    super.initState();
    media = widget.media;
    fetchMovieCredits();
    fetchMediaDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            leading: const BackBtn(),
            backgroundColor: Colours.scaffoldBgColor,
            expandedHeight: 500,
            pinned: true,
            floating: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                media.title,
                style: GoogleFonts.belleza(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                ),
              ),
              background: Image.network(
                '${Constants.imagePath}${media.backDropPath}',
                filterQuality: FilterQuality.high,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  Text('Overview',
                      style: GoogleFonts.openSans(
                        fontSize: 30,
                        fontWeight: FontWeight.w800,
                      )),
                  const SizedBox(height: 16),
                  Text(media.overview,
                      style: GoogleFonts.roboto(
                        fontSize: 25,
                        fontWeight: FontWeight.w400,
                      )),
                  const SizedBox(height: 16),
                  SizedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              children: [
                                Text(
                                  'Release date: ',
                                  style: GoogleFonts.roboto(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  media.releaseDate,
                                  style: GoogleFonts.roboto(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            )),
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              Text(
                                'Rating: ',
                                style: GoogleFonts.roboto(
                                    fontSize: 17, fontWeight: FontWeight.bold),
                              ),
                              const Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              Text(
                                '${media.voteAverage.toStringAsFixed(1)}/10',
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Text(
                      'Year of release: ',
                      style: GoogleFonts.roboto(
                          fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      getYearFromDate(
                          media.releaseDate), // Pass the release date string
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                )),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Actors',
                    style: GoogleFonts.openSans(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Display actors' names
                  // Display actors' names and images
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: actors.map((actor) {
                        return Padding(
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          ActorDetailsScreen(actor: actor),
                                    ),
                                  );
                                },
                                child: CircleAvatar(
                                  backgroundImage: NetworkImage(
                                    '${Constants.imagePath}${actor.profilePath}',
                                  ),
                                  radius: 40,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                actor.name,
                                style: GoogleFonts.roboto(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> fetchMovieCredits() async {
    int movieId = widget.media.id;
    String creditsUrl = api.getCreditsUrl(movieId);

    try {
      final response = await http.get(Uri.parse(creditsUrl));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        // Extract the first three actors
        final List<dynamic> actorsData = data['cast'].take(3).toList();

        setState(() {
          // Update the UI with the retrieved actors' information
          actors = actorsData.map((actorJson) {
            return Actor.fromJson(actorJson);
          }).toList();
        });
      } else {
        throw Exception('Failed to load credits');
      }
    } catch (e) {
      print('Error fetching movie credits: $e');
      // Handle error case, show a message to the user, etc.
    }
  }

  Future<void> fetchMediaDetails() async {
    try {
      // Fetch movie details using the movieId
      Media details = await api.fetchMediaDetails(media.id, media.mediaType);
      setState(() {
        media = details;
      });
    } catch (e) {
      // Handle any errors that might occur during fetching details
      print('Error fetching movie details: $e');
      // Show an error message to the user or handle accordingly
    }
  }
}
