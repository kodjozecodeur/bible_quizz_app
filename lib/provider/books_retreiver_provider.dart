import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BooksRetreiverProvider extends ChangeNotifier {
  List<Map<String, dynamic>> _books = [];
  List<Map<String, dynamic>> sessionBooks = [];
  int currentIndex = 0;
  String _currentScrambledWord = '';

  //score and streal
  int _score = 0;
  int _streak = 0;
  bool _isGameComplete = false;
  String _userName = '';

  // Add getter for scrambled word and streaks and score
  String get currentScrambledWord => _currentScrambledWord;
  int get score => _score;
  int get streak => _streak;
  bool get isGameComplete => _isGameComplete;
  String get userName => _userName;

  //for the progress indicator
  int get currentQuestionNumber => currentIndex;
  int get totalQuestions => sessionBooks.length;

  //stats
  int _gamesPlayed = 0;
  int _bestScore = 0;

  //getter to acces the stats in a read only
  int get gamesPlayed => _gamesPlayed;
  int get bestScore => _bestScore;

//constructor for load stat
  BooksRetreiverProvider() {
    _loadStatistics();
  }
  //loadstats
  Future<void> _loadStatistics() async {
    final prefs = await SharedPreferences.getInstance();
    _gamesPlayed = prefs.getInt('gamesPlayed') ?? 0;
    _bestScore = prefs.getInt('bestScore') ?? 0;
    _userName = prefs.getString('userName') ?? '';
    notifyListeners();
  }

  // Save statistics
  Future<void> _saveStatistics() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('gamesPlayed', _gamesPlayed);
    await prefs.setInt('bestScore', _bestScore);
    await prefs.setString('userName', _userName);
  }

  //update usernae
  // Method to update username
  Future<void> setUsername(String newUsername) async {
    _userName = newUsername;
    await _saveStatistics(); // Save immediately when username is set
    notifyListeners();
  }

  //retrieve books form json
  Future<void> readJson() async {
    try {
      final String response = await rootBundle.loadString('assets/books.json');
      final data = jsonDecode(response) as Map<String, dynamic>;

      _books = List<Map<String, dynamic>>.from(data["bibleBooks"]).map((book) {
        // Add null safety checks
        final bookName = book["name"]?.toString().toLowerCase() ?? 'unknown';
        return {
          "id": book["id"]?.toString() ?? '0',
          "name": bookName,
        };
      }).toList();

      // Ensure we have valid books before proceeding
      if (_books.isEmpty) {
        throw Exception("No books loaded from JSON");
      }

      // Initialize game state
      _books.shuffle();
      sessionBooks = _books.take(5).toList();

      // Debug print to verify content
      debugPrint("Loaded ${sessionBooks.length} books:");
      for (var book in sessionBooks) {
        debugPrint(" - ${book['name']}");
      }

      // Initialize first scrambled word
      if (sessionBooks.isNotEmpty) {
        currentIndex = 0;
        _currentScrambledWord = scramble(sessionBooks.first['name']);
        debugPrint("Initial scrambled word: $_currentScrambledWord");
      }

      notifyListeners();
    } catch (e) {
      debugPrint("Error loading data: ${e.toString()}");
      // Set default fallback values
      _currentScrambledWord = "ERROR";
      sessionBooks = [];
      notifyListeners();
      rethrow;
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
        _updateGameStatistics();
        notifyListeners();
      } else {
        moveToNextWord();
      }
    } else {
      _streak = 0; //reset streak
      _score -= 5; //decrease point if false;
    }
    notifyListeners();
    return isCorrect;
  }

  // New method to update game statistics
  Future<void> _updateGameStatistics() async {
    _gamesPlayed++;
    if (_score > _bestScore) {
      _bestScore = _score;
    }
    await _saveStatistics();
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
