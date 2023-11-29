import 'dart:convert';

import 'package:movie_tracker/models/Actor.dart';
import 'package:movie_tracker/models/Media.dart';
import 'package:movie_tracker/models/Movie.dart';
import 'package:flutter/material.dart';
import 'package:movie_tracker/shared/constants.dart';
import 'package:movie_tracker/api/api.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:movie_tracker/screens/movie_details_screen.dart';


class ActorDetailsScreen extends StatefulWidget {
  final Actor actor;

  ActorDetailsScreen({super.key, required this.actor});

  @override
  _ActorDetailsScreenState createState() => _ActorDetailsScreenState();
}

class _ActorDetailsScreenState extends State<ActorDetailsScreen> {
  late List<Media> movies_and_shows = [];
  late Actor actor; // Updated list of movies
  Api api = Api();

  @override
  void initState() {
    super.initState();
    actor = widget.actor; // Initialize the actor field
    fetchActorFilmography(); // Fetch movies on screen initialization
  }

  Future<void> fetchActorFilmography() async {
    int actorId = widget.actor.id;
    String filmographyUrl = api.getFilmographyUrl(actorId);

    try {
      final response = await http.get(Uri.parse(filmographyUrl));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        final List<dynamic> moviesData = data['cast'].take(3).toList();
        print('Movies data: $moviesData');

        setState(() {
          movies_and_shows = moviesData.map((movieJson) {
            return Media.fromJson(movieJson);
          }).toList();
        });
      } else {
        throw Exception("Failed to load data");
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  int calculateAge(String? birthDate) {
    if (birthDate == null) {
      return 0; // Handle null birthdate gracefully
    }

    // Split the birthdate string into year, month, and day
    List<String> dateParts = birthDate.split('-');
    if (dateParts.length != 3) {
      return 0; // Invalid date format, return 0 or handle error
    }

    // Parse year, month, and day from the birthdate string
    int year = int.parse(dateParts[0]);
    int month = int.parse(dateParts[1]);
    int day = int.parse(dateParts[2]);

    // Create a DateTime object from the parsed values
    DateTime birthDateTime = DateTime(year, month, day);

    // Calculate the age
    DateTime now = DateTime.now();
    int age = now.year - birthDateTime.year;

    // Adjust age if the birthday hasn't occurred yet this year
    if (now.month < birthDateTime.month ||
        (now.month == birthDateTime.month && now.day < birthDateTime.day)) {
      age--;
    }

    return age;
  }

  @override
  Widget build(BuildContext context) {
    //int age = calculateAge(actor.birthday);
    return Scaffold(
      appBar: AppBar(
        title: Text(actor.name),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Actor's picture
            Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                    '${Constants.imagePath}${actor.profilePath}',
                    height: 200,
                    width: 200,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            // Actor's age
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Birthday: ${actor.birthday}',
                style: GoogleFonts.roboto(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),

            // Movies the actor has appeared in
            // Display a ListView of movies here

            Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Filmography: ',
                  style: GoogleFonts.roboto(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                )),

            Container(
              height: 300,
              child: ListView.builder(
                itemCount: movies_and_shows.length,
                itemBuilder: (context, index) {
                  final media = movies_and_shows[index];
                  return ListTile(
                    title: Text(media.title),
                    leading: Image.network(
                      '${Constants.imagePath}${media.posterPath}',
                      height: 80,
                      width: 80,
                      fit: BoxFit.cover,
                    ),
                    onTap:(){
                      //Navigate to details screen
                      Navigator.push(context,
                       MaterialPageRoute(builder: 
                       (context) => DetailsScreen(media: media),
                       ),
                      );
                    }
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
