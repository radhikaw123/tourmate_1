import 'package:flutter/material.dart';
import 'package:tourmate_app/views/home/blog_page.dart';
import '../views/auth/login_page.dart';
import '../views/auth/signup_page.dart';
import '../views/home/starting_page.dart';
import '../views/home/home_page.dart';
import '../views/home/gallery_page.dart';
import '../views/home/destinations_page.dart'; // ✅ Import this
import '../views/home/display_page.dart';
import '../views/home/profile_page.dart'; // ✅ Import this too
import '../views/home/settings_page.dart';

class AppRoutes {
  static const String initial = '/';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String home = '/home';
  static const String destinations = '/destinations'; // ✅ still needed
  static const String gallery = '/gallery'; // ✅ new
  static const String display = '/display';
  static const String profile = '/profile'; // ✅ new
  static const String settings = '/settings';
  static const String blog = '/blog';

  static final Map<String, WidgetBuilder> routes = {
    initial: (_) => const StartingPage(),
    login: (_) => const LoginPage(),
    signup: (_) => const SignupPage(),
    home: (_) => const HomePage(),
    destinations: (_) => const DestinationPage(), // ✅ mapping for /destinations
    gallery: (_) => const GalleryPage(), // ✅ mapping for /gallery
    profile: (_) => const ProfilePage(), // ✅ mapping for /profile
    settings: (_) => const SettingsPage(),
    blog: (_) => const BlogPage(),
  };

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    if (settings.name == display) {
      final args = settings.arguments as List<Map<String, dynamic>>;
      return MaterialPageRoute(builder: (_) => DisplayPage(destinations: args));
    }
    return null;
  }
}
