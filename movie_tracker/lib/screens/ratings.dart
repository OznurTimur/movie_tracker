// My rated movies
// Movies / TV series that you’ve seen and rated
// You should include the poster for each item
// You should show your movie rating

import 'package:flutter/material.dart';
import 'package:movie_tracker/widgets/back_button.dart';


class Ratings extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
         appBar: AppBar(
         title: Text('Ratings'),
         leading: BackBtn(),
      
      ),
    );
    
  }
}




