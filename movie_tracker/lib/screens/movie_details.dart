import 'package:movie_tracker/models/Media.dart';
import 'package:flutter/material.dart';
import 'package:movie_tracker/shared/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_tracker/shared/constants.dart';
import 'package:movie_tracker/widgets/back_button.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({
    super.key,
    required this.media,
    
  });

  final Media media;

  @override
  Widget build(BuildContext context){
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
              title: Text(media.title,style: GoogleFonts.belleza (
                fontSize:17,
                fontWeight: FontWeight.w600,
                ),
            ),
        
            background: Image.network(
              '${Constants.imagePath}${media.backDropPath}',
              filterQuality:FilterQuality.high,
              fit:BoxFit.cover,
            ),
          ),
          ),
          SliverToBoxAdapter(
            child:Padding(
              padding: EdgeInsets.all(12),
              child: Column(children: [
                Text(
                'Overview',
                 style: GoogleFonts.openSans(
                fontSize:30,
                fontWeight: FontWeight.w800,)
                ),
                const SizedBox(height: 16),
                Text(
                media.overview, 
                style: GoogleFonts.roboto(
                fontSize:25,
                fontWeight: FontWeight.w400,)
                ),
                const SizedBox(height:16),
                SizedBox(
                  child:Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(children: [
                          Text(
                            'Release date: ',
                            style: GoogleFonts.roboto(
                            fontSize:17,
                            fontWeight: FontWeight.bold),
                          ),
                          Text(media.releaseDate, 
                          style: GoogleFonts.roboto(
                            fontSize:17,
                            fontWeight: FontWeight.bold),
                          )
                        ],
                        )
                      ),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10),
                        ),
                         child: Row(children: [
                          Text(
                            'Rating: ',
                            style: GoogleFonts.roboto(
                            fontSize:17,
                            fontWeight: FontWeight.bold),
                          ),
                          const Icon(
                            Icons.star,
                            color:Colors.amber,
                          ),
                          Text('${media.voteAverage.toStringAsFixed(1)}/10', 
                          )
                        ],
                        ),
                      ), 
                  ]
                ),
                ),
              ],
              )
            )
          )
        ],
        )
    );
  }
}