import 'package:bible_quizz_app/provider/books_retreiver_provider.dart';
import 'package:bible_quizz_app/screens/home_screen.dart';
import 'package:bible_quizz_app/screens/username_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => BooksRetreiverProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: FutureBuilder<String?>(
          future: _getStoredUsername(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.data?.isNotEmpty == true) {
              return HomeScreen(); // Skip username screen
            } else {
              return UserNameScreen();
            }
          },
        ),
      ),
    );
  }

  Future<String?> _getStoredUsername() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('userName');
  }
}
