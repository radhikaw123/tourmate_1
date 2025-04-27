import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'routes/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyC3ELkfUIbZo-WnKkdQlNC2iCtLjCX1dn8",
      authDomain: "tourmate-040.firebaseapp.com",
      projectId: "tourmate-040",
      storageBucket: "tourmate-040.appspot.com",
      messagingSenderId: "24090768597",
      appId: "1:24090768597:web:5b2b3b1f3a5e665e491e5c",
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tourmate',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Poppins', primarySwatch: Colors.orange),
      initialRoute: AppRoutes.initial,
      routes: AppRoutes.routes,
      onGenerateRoute: AppRoutes.onGenerateRoute, // ✅ Added this back!
    );
  }
}
