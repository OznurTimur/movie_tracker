# Movie Tracker App Documentation

## Overview
"movie_tracker" is a Flutter-based application designed to track and explore information about movies, TV shows, actors, and actresses. It provides users with a seamless interface to discover trending media content, access details about movies and TV shows, explore actor/actress profiles, manage watchlists, and view rated movies/TV shows.

## API Integration

### TMDB API Class
The app integrates with The Movie Database (TMDB) API to fetch data regarding movies, TV shows, actors, and user-related information.

## Features

### Home Screen
- **Functionality**: Displays trending movies and TV shows.
- **Interaction**: Clicking on a poster opens the details screen for the selected movie/TV show.

### Details Screen
- **Displayed Information**: 
  - Movie/TV Show Name
  - Overview/Description
  - Release Date
  - Rating
  - Top 3 Actors/Actresses
- **Interaction**: Clicking on an actor/actress leads to their detailed profile page.

### Actor/Actress Profile
- **Displayed Information**:
  - Name
  - Age
  - Top 3 Movies They've Acted In
- **Interaction**: Clicking on a movie redirects to its details page.

### Side Bar
- **Sections**:
  - User Profile
  - Search Screens:
    - Movies
    - Actors/Actresses
  - Watchlists
  - Rated Movies/TV Shows

## Navigation Flow
1. **Home Screen**
   - Trending movies and TV shows.
   - Click on a poster to access details.
2. **Details Screen**
   - Details of the selected movie/TV show.
   - Click on an actor/actress for their profile.
3. **Actor/Actress Profile**
   - Information about the selected actor/actress.
   - Click on a movie to view its details.
4. **Side Bar**
   - Access various sections:
     - User Profile
     - Movie and Actor/Actress Search
     - Watchlists
     - Rated Movies/TV Shows

## User Profile Screen

### Functionality
- **Theme Selection**:
  - Allows users to choose between a dark and light theme for the app.
  - Offers a personalized visual experience based on user preference.

### Interaction
- Upon accessing the user profile screen, users can find the theme selection option.
- Toggling between dark and light themes immediately changes the app's appearance.

## Usage Instructions
1. Upon opening the app, the home screen displays trending movies and TV shows.
2. Click on a poster to view detailed information about the selected movie/TV show.
3. On the details screen, explore additional information about the movie/TV show and its top 3 actors/actresses.
4. Click on an actor/actress to view their profile, including their age and top 3 movies they've acted in.
5. Utilize the side bar for accessing user profile, search functionality, watchlists, and rated movies/TV shows.
6. Access the user profile screen through the side bar and choose between a dark or light theme for the app to personalize the visual experience.
