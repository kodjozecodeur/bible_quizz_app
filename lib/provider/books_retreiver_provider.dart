import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BooksRetreiverProvider extends ChangeNotifier {
  List<Map<String, dynamic>> _books = [];
  List<Map<String, dynamic>> sessionBooks = [];
  int currentIndex = 0;
  String _currentScrambledWord = '';

  //score and streal
  int _score = 0;
  int _streak = 0;
  bool _isGameComplete = false;

  // Add getter for scrambled word and streaks and score
  String get currentScrambledWord => _currentScrambledWord;
  int get score => _score;
  int get streak => _streak;
  bool get isGameComplete => _isGameComplete;

  //retrieve books form json
  Future<void> readJson() async {
    try {
      //load json
      // Load the JSON from the file
      final String response = await rootBundle.loadString('assets/books.json');
      // Decode the JSON to a Map
      final data = jsonDecode(response);
      //map and normalize data(to bring all of them to lower case, remark that we dont't need to use set state here)
      _books = List<Map<String, dynamic>>.from(data["bibleBooks"]).map((book) {
        return {
          "id": book["id"].toString(), // Ensure ID is a string
          "name": book["name"]!.toLowerCase()!, // Convert name to lowercase
        };
      }).toList();
      //suffle books and prepare session
      _books.shuffle();
      sessionBooks = _books.take(5).toList(); // Take 5 random books
      debugPrint("$sessionBooks");
      _currentScrambledWord = scramble(sessionBooks[currentIndex]['name']);
      notifyListeners(); //update the ui
    } catch (e) {
      debugPrint("Error while loading data $e");
    }
  }

  // Method to scramble current word
  String scramble(String word) {
    List<String> characters = word.split('');
    characters.shuffle(Random());
    return characters.join('');
  }

  //check answer funtion

  bool checkAnswer(String userInput) {
    //get current book name
    String correctAnswer = sessionBooks[currentIndex]["name"].toLowerCase();
    //clean and lowerCase input
    String cleanedInput = userInput.trim().toLowerCase();
    //check if answer is correct
    bool isCorrect = cleanedInput == correctAnswer;

    //control
    if (isCorrect) {
      _score += 10; //increase point if true
      _streak += 1; //increase streak
      //move to next word
      if (currentIndex == sessionBooks.length - 1) {
        _isGameComplete = true;
      } else {
        moveToNextWord();
      }
    } else {
      _streak = 0; //reset streak
      _score = 0;
    }
    notifyListeners();
    return isCorrect;
  }

  // Add method to move to next word
  void moveToNextWord() {
    if (currentIndex < sessionBooks.length - 1) {
      currentIndex++;
      _currentScrambledWord = scramble(sessionBooks[currentIndex]['name']);
      notifyListeners();
    }
  }

  //resetgame
  void resetGame() {
    currentIndex = 0;
    _score = 0;
    _streak = 0;
    _isGameComplete = false;
    _books.shuffle();
    sessionBooks = _books.take(5).toList();
    _currentScrambledWord = scramble(sessionBooks[currentIndex]['name']);
    notifyListeners();
  }
}
