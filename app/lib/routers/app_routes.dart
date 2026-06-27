import 'package:flutter/material.dart';

import '../screens/auth/login_page.dart';
import '../screens/auth/register_page.dart';
import '../screens/auth/forgot_password_page.dart';
import '../screens/onboarding/onboarding_page.dart';
import '../screens/home/home_page.dart';
import '../screens/map/full_map_page.dart';
import '../screens/favorites/favorites_page.dart';
import '../screens/profile/profile_page.dart';
import '../screens/settings_page.dart';
import '../screens/place/place_details_page.dart';
import '../screens/event/event_details_page.dart';
import '../screens/category/categories_page.dart';
import '../screens/category/category_places_page.dart';
import '../screens/review/reviews_page.dart';
import '../screens/review/add_review_page.dart';
import '../screens/search/search_page.dart';
import '../screens/itinerary/itineraries_page.dart';
import '../screens/itinerary/itinerary_details_page.dart';
import '../screens/itinerary/create_itinerary_page.dart';
import '../screens/notification/notifications_page.dart';
import '../screens/profile/history_page.dart';

class AppRoutes {
  AppRoutes._();

  static const String login = '/login';
  static const String register = '/register';
  static const String forgotPassword = '/forgot-password';
  static const String onboarding = '/onboarding';
  static const String home = '/home';
  static const String fullMap = '/full-map';
  static const String favorites = '/favorites';
  static const String profile = '/profile';
  static const String settings = '/settings';
  static const String placeDetails = '/place-details';
  static const String eventDetails = '/event-details';
  static const String categories = '/categories';
  static const String categoryPlaces = '/category-places';
  static const String reviews = '/reviews';
  static const String addReview = '/add-review';
  static const String search = '/search';
  static const String itineraries = '/itineraries';
  static const String itineraryDetails = '/itinerary-details';
  static const String createItinerary = '/create-itinerary';
  static const String notifications = '/notifications';
  static const String history = '/history';

  static Map<String, WidgetBuilder> routes = {
    login: (context) => const LoginPage(),
    register: (context) => const RegisterPage(),
    forgotPassword: (context) => const ForgotPasswordPage(),
    onboarding: (context) => const OnboardingPage(),
    home: (context) => const HomePage(),
    fullMap: (context) => const FullMapPage(),
    favorites: (context) => const FavoritesPage(),
    profile: (context) => const ProfilePage(),
    settings: (context) => const SettingsPage(),
    placeDetails: (context) => const PlaceDetailsPage(),
    eventDetails: (context) => const EventDetailsPage(),
    categories: (context) => const CategoriesPage(),
    categoryPlaces: (context) => const CategoryPlacesPage(),
    reviews: (context) => const ReviewsPage(),
    addReview: (context) => const AddReviewPage(),
    search: (context) => const SearchPage(),
    itineraries: (context) => const ItinerariesPage(),
    itineraryDetails: (context) => const ItineraryDetailsPage(),
    createItinerary: (context) => const CreateItineraryPage(),
    notifications: (context) => const NotificationsPage(),
    history: (context) => const HistoryPage(),
        
  };
}