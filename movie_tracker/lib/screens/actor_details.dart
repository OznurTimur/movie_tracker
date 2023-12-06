import 'dart:convert';

import 'package:movie_tracker/models/Actor.dart';
import 'package:movie_tracker/models/Media.dart';
import 'package:flutter/material.dart';
import 'package:movie_tracker/shared/constants.dart';
import 'package:movie_tracker/api/api.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:movie_tracker/screens/media_details_screen.dart';

class ActorDetailsScreen extends StatefulWidget {
  final Actor actor;

  ActorDetailsScreen({super.key, required this.actor});

  @override
  // ignore: library_private_types_in_public_api
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
    fetchActorFilmography();
    fetchActorDetails(); // Fetch movies on screen initialization
  }

  Future<void> fetchActorDetails() async {
    try {
      final Actor actorDetails = await api.fetchActorDetails(actor.id);
      setState(() {
        actor = actorDetails;
      });
    } catch (e) {
      print('Error fetching actor details: $e');
    }
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

  int calculateAge(String birthday) {
  DateTime today = DateTime.now();
  DateTime birthDate = DateTime.parse(birthday);

  int age = today.year - birthDate.year;

  if (today.month < birthDate.month ||
      (today.month == birthDate.month && today.day < birthDate.day)) {
    age--;
  }

  return age;
}


  @override
  Widget build(BuildContext context) {
    int age = calculateAge(actor.birthday);
    Color textColor = Theme.of(context).textTheme.bodyText1!.color!;

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
            
             // Display the actor's age
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: RichText(
              text: TextSpan(
                style: TextStyle(
                  fontSize: 16,
                  color: textColor,
                ),
                children: [
                  const TextSpan(
                    text: 'Age: ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: '$age',
                    style: const TextStyle(
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
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

            SizedBox(
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
                      ),
                      onTap: () {
                        //Navigate to details screen
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailsScreen(media: media),
                          ),
                        );
                      });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
