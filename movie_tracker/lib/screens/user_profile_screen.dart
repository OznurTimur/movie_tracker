import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:movie_tracker/api/api.dart';
import 'package:movie_tracker/widgets/back_button.dart';
import 'package:movie_tracker/theme_notifier.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class UserProfileScreen extends StatefulWidget {
  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  Map<String, dynamic>? accountData;
  Api api = Api();
  bool isDarkTheme = true;

  List<Map<String, String>> availableLanguages = [];
  String selectedLanguage = 'en'; // Default language code


  List<String> subscribedServices =
      []; // Initialize an empty list for subscribed services
  List<String> availableServices = [
    'Netflix',
    'Amazon Prime',
    'Disney+'
  ]; // List of available services

  void toggleSubscription(String service) {
    setState(() {
      if (subscribedServices.contains(service)) {
        subscribedServices
            .remove(service); // Unselect service if already subscribed
      } else {
        subscribedServices.add(service); // Select service if not subscribed
      }
    });
  }

  @override
  void initState() {
    super.initState();
    api.fetchAvailableLanguages().then((languages) {
      setState(() {
        availableLanguages = languages;
      });
    });
    fetchAccountDetails();
  }

  Future<void> fetchAccountDetails() async {
    final data = await api.fetchAccountDetails();
    setState(() {
      accountData = data;
    });
  }

  void toggleTheme(bool value) {
    setState(() {
      isDarkTheme = value;
    });
  }

  void changeLanguage(String language) {
    setState(() {
      selectedLanguage = language;
    });
  }

 @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('User Profile'),
        leading: BackBtn(),
      ),
        body: Center(
          child: accountData == null
              ? CircularProgressIndicator()
              : Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text(
                    'Account Details:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  if (accountData != null) ...[
                    if (accountData!['avatar'] != null &&
                        accountData!['avatar']['tmdb'] != null &&
                        accountData!['avatar']['tmdb']['avatar_path'] != null)
                      Image.network(
                        'https://image.tmdb.org/t/p/w200${accountData!['avatar']['tmdb']['avatar_path']}',
                        width: 100,
                        height: 100,
                      ),
                  ],
                  SizedBox(height: 20),
                  Text('Username: ${accountData!['username']}'),
                  Text('ID: ${accountData!['id']}'),
                  SizedBox(height: 20),
                  Switch(
                    value: themeNotifier.isDarkMode,
                    onChanged: (value) {
                      themeNotifier.toggleTheme();
                    },
                    activeColor: Colors.greenAccent,
                    inactiveTrackColor:
                        Color.fromARGB(255, 59, 58, 58),
                  ),
                  SizedBox(height: 20),
                  DropdownButton<String>(
              value: selectedLanguage,
              onChanged: (String? newValue) {
                if (newValue != null) {
                  setState(() {
                    selectedLanguage = newValue;
                  });
                  updateLanguagePreference(newValue);
                }
              },
              items: availableLanguages.map((language) {
                return DropdownMenuItem<String>(
                  value: language['iso_639_1']!,
                  child: Text(language['name']!),
                );
              }).toList(),
            ),
         
                  SizedBox(height: 20),
                  Text(
                    'Subscribed Services:',
                    style: TextStyle( fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 8.0,
                    children: availableServices.map((service) {
                      bool isSelected = subscribedServices.contains(service);
                      return FilterChip(
                        label: Text(service),
                        selected: isSelected,
                        onSelected: (isSelected) {
                          toggleSubscription(service);
                        },
                        selectedColor: Colors.green,
                        backgroundColor: Colors.grey[300],
                        checkmarkColor: Colors.black,
                      );
                    }).toList(),
                  ),
                ]),
        ),
      );
  }


Future<void> updateLanguagePreference(String languageCode) async {
  String sessionId = api.createGuestSession().toString(); 
  String accountId = Api.accountId ; 

  final Map<String, dynamic> requestBody = {
    'language': languageCode,
  };

  final String apiUrl = 'https://api.themoviedb.org/3/account/$accountId/settings?api_key=6049c47350887cca020dd26ddd5f1ad2&session_id=$sessionId';

  try {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json;charset=utf-8',
      },
      body: jsonEncode(requestBody),
    );

    if (response.statusCode == 200) {
      print('Language preference updated successfully');
    } else {
      throw Exception('Failed to update language preference');
    }
  } catch (e) {
    print('Error updating language preference: $e');
    throw Exception('Failed to update language preference');
  }
}
}
