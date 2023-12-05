// User name
// Switch between dark light theme
// Switch between country / language
// User can select / unselect services the user is subscribed (i.e. Netflix, etc.)

import 'package:flutter/material.dart';
import 'package:movie_tracker/api/api.dart';
import 'package:movie_tracker/theme_notifier.dart';
import 'package:provider/provider.dart';

class UserProfileScreen extends StatefulWidget {
  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  Map<String, dynamic>? accountData;
  Api api = Api();
  bool isDarkTheme = true;

  String selectedCountryLanguage = 'English';
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
      selectedCountryLanguage = language;
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    return MaterialApp(
      theme: isDarkTheme ? ThemeData.dark() : ThemeData.light(),
      home: Scaffold(
        appBar: AppBar(
          title: Text('User Profile'),
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
                        const Color.fromARGB(255, 113, 110, 110),
                  ),
                  SizedBox(height: 20),
                  DropdownButton<String>(
                    value: selectedCountryLanguage,
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        changeLanguage(newValue);
                      }
                    },
                    items: <String>[
                      'English',
                      'French',
                      'Spanish',
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
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
      ),
    );
  }
}
