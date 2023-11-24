import 'package:flutter/material.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  bool isDarkTheme = false; // Placeholder for dark theme toggle
  bool isSubscribedToNetflix = false; // Placeholder for Netflix subscription
  // Add more subscription bools for other services
  String selectedLanguage = 'English'; // Default selected language

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'User Name', // Display user name here
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              'Theme', // Theme selection
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SwitchListTile(
              title: Text('Dark Mode'),
              value: isDarkTheme,
              onChanged: (value) {
                setState(() {
                  isDarkTheme = value;
                  // Implement theme switching logic here
                });
              },
            ),
            SizedBox(height: 20),
            DropdownButton<String>(
              value: selectedLanguage,
              onChanged: (newValue) {
                setState(() {
                  selectedLanguage = newValue!;
                  // Implement logic to change the language
                });
              },
              items: <String>['English', 'Turkish', 'Spanish']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            // Implement language/country selection widgets here
            SizedBox(height: 20),
            Text(
              'Subscription',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            CheckboxListTile(
              title: Text('Netflix'), // Example subscription
              value: isSubscribedToNetflix,
              onChanged: (value) {
                setState(() {
                  isSubscribedToNetflix = value!;
                  // Implement subscription logic here
                });
              },
            ),
            // Add more CheckboxListTile widgets for other services
          ],
        ),
      ),
    );
  }
}
