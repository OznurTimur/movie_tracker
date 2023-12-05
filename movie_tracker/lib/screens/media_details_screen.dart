import 'dart:convert';

import 'package:movie_tracker/models/Media.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_tracker/shared/constants.dart';
import 'package:movie_tracker/widgets/back_button.dart';
import 'package:movie_tracker/api/api.dart';
import 'package:movie_tracker/screens/actor_details.dart';
import 'package:movie_tracker/models/Actor.dart';
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
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  double? userRating = 0; // To store the user's rating
  Api api = Api(); // Instance of Api class
  late Media media;
  List<Actor> actors = [];
  Map<int, String> genresMap = {};

  @override
  void initState() {
    super.initState();
    media = widget.media;
    fetchMovieCredits();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            leading: BackBtn(),
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
              padding: EdgeInsets.all(12),
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
      
          // SliverToBoxAdapter(
          //   child: Container(
          //       padding: const EdgeInsets.all(8),
          //       decoration: BoxDecoration(
          //         border: Border.all(color: Colors.grey),
          //         borderRadius: BorderRadius.circular(10),
          //       ),
          //       child: Row(
          //         children: [
          //           Text(
          //             'Genre: ',
          //             style: GoogleFonts.roboto(
          //                 fontSize: 17, fontWeight: FontWeight.bold),
          //           ),
          //           //genre text here
          //         ],
          //       )),
          // ),
          // SliverToBoxAdapter(
          //   child: Container(
          //       padding: const EdgeInsets.all(8),
          //       decoration: BoxDecoration(
          //         border: Border.all(color: Colors.grey),
          //         borderRadius: BorderRadius.circular(10),
          //       ),
          //       child: Row(
          //         children: [
          //           Text(
          //             'Director: ',
          //             style: GoogleFonts.roboto(
          //                 fontSize: 17, fontWeight: FontWeight.bold),
          //           ),
          //           //director text here
          //         ],
          //       )),
          // ),
          // SliverToBoxAdapter(
          //   child: FutureBuilder<Media>(
          //     future: api.fetchMediaDetails(media.id,
          //         media.mediaType), // Replace with your media ID and type
          //     builder: (context, snapshot) {
          //       if (snapshot.connectionState == ConnectionState.waiting) {
          //         return CircularProgressIndicator(); // or a loading indicator
          //       } else if (snapshot.hasError) {
          //         return Text('Error loading media details: ${snapshot.error}');
          //       } else if (!snapshot.hasData) {
          //         return Text('No data available.');
          //       } else {
          //         Media media123 = snapshot.data!;

          //         return Row(
          //           children: [
          //             Text(
          //               'Duration:  ',
          //               style: GoogleFonts.roboto(
          //                 fontSize: 17,
          //                 fontWeight: FontWeight.bold,
          //               ),
          //             ),
          //             SizedBox(
          //               width: 5,
          //             ),
          //             Text(
          //               '${media123.runTime} minutes', // Access runTime from fetched media
          //               style: GoogleFonts.roboto(
          //                 fontSize: 17,
          //                 fontWeight: FontWeight.normal,
          //               ),
          //             ),
          //           ],
          //         );
          //       }
          //     },
          //   ),
          // ),
          // SliverToBoxAdapter(
          //   child: Container(
          //       padding: const EdgeInsets.all(8),
          //       decoration: BoxDecoration(
          //         border: Border.all(color: Colors.grey),
          //         borderRadius: BorderRadius.circular(10),
          //       ),
          //       child: Row(
          //         children: [
          //           Text(
          //             'Year of release: ',
          //             style: GoogleFonts.roboto(
          //                 fontSize: 17, fontWeight: FontWeight.bold),
          //           ),
          //         ],
          //       )),
          // ),
          // SliverToBoxAdapter(
          //   child: Container(
          //       padding: const EdgeInsets.all(8),
          //       decoration: BoxDecoration(
          //         border: Border.all(color: Colors.grey),
          //         borderRadius: BorderRadius.circular(10),
          //       ),
          //       child: Row(
          //         children: [
          //           Text(
          //             'PEGI info: ',
          //             style: GoogleFonts.roboto(
          //                 fontSize: 17, fontWeight: FontWeight.bold),
          //           ),
          //           //pegi text here
          //         ],
          //       )),
          // ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
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
                  SizedBox(height: 8),
                  // Display actors' names
                  // Display actors' names and images
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: actors.map((actor) {
                        return Padding(
                          padding: EdgeInsets.all(8),
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
                              SizedBox(height: 8),
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
}
