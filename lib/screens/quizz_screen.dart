import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class QuizzScreen extends StatefulWidget {
  const QuizzScreen({super.key});

  @override
  State<QuizzScreen> createState() => _QuizzScreenState();
}

class _QuizzScreenState extends State<QuizzScreen> {
  final TextEditingController textController = TextEditingController();
  List<Map<String, dynamic>> _books = [];
  List<Map<String, dynamic>> _sessionBooks = [];
  //scoring
  int _score = 0;
  int _currentIndex = 0;
  int _incorrectAttempts = 0;

  @override
  void initState() {
    super.initState();
    readJson(); // Load books from the JSON file
  }

//clear the controller when the widget is dispose
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    textController.dispose();
    super.dispose();
  }

  //fetch from json file
  Future<void> readJson() async {
    try {
      // Load the JSON from the file
      final String response = await rootBundle.loadString('assets/books.json');
      // Decode the JSON to a Map
      final data = jsonDecode(response);

      setState(() {
        // Extract the books, convert names to lowercase, and shuffle them
        _books =
            List<Map<String, dynamic>>.from(data["bibleBooks"]).map((book) {
          return {
            "id": book["id"].toString(), // Ensure ID is a string
            "name": book["name"]!.toLowerCase(), // Convert name to lowercase
          };
        }).toList();

        // Shuffle the books
        _books.shuffle(Random());

        // Take the first 5 books for the session
        _sessionBooks = _books.take(5).toList();
        // print(_sessionBooks); // Debugging: Print the selected books
      });
    } catch (e) {
      print("Error loading JSON: $e");
    }
  }

  // //check the inout
  void checkWord() {
    // Prevent out-of-range errors
    if (_currentIndex >= _sessionBooks.length) return; //to prevent out of range
    //time to check the user input

    String userInput =
        textController.text.trim(); // to prevent any trailing space
    String originalWord = _sessionBooks[_currentIndex]["name"]!;

    if (userInput.toLowerCase() == originalWord.toLowerCase()) {
      setState(() {
        _score++;
        _currentIndex++;
        textController.clear();
      });
      if (_currentIndex >= _sessionBooks.length) {
        showCompletionDialog(); // End session
      } else {
        print("correct");
      }
    } else {
      setState(() {
        _incorrectAttempts++;
        print("incorrect answer");
        showIncorrectFeedback();
      });

      if (_incorrectAttempts >= 3) {
        showCompletionDialog();
      }
    }
  }

//completion dialog
  void showCompletionDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Session Complete"),
          // content: Text("Your score is $_score out of 5"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                resetGame(); // Reset for a new session
              },
              child: Text("Restart"),
            ),
          ],
        );
      },
    );
  }

  void showIncorrectFeedback() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Incorrect"),
          content:
              const Text("Oops! That’s not the correct answer. Try again."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                textController.clear(); // Clear the input for retry
              },
              child: const Text("Retry"),
            ),
          ],
        );
      },
    );
  }

  //reset game
  // Reset the game for a new session
  void resetGame() {
    setState(() {
      _currentIndex = 0;
      _score = 0;
      _sessionBooks = (_books..shuffle()).take(5).toList();
    });
  }

  //scramble the letters
  //Function to scramble letters in a string
  String scramble(String word) {
    List<String> characters = word.split(''); // Split the word into characters
    characters.shuffle(Random()); // Shuffle the characters randomly
    return characters.join(''); // Join them back into a string
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Quizz App"),
      ),
      body: _currentIndex < _sessionBooks.length
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16),
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.black,
                  ),
                  child: Text(
                    scramble(
                      _sessionBooks[_currentIndex]["name"],
                    ),
                    style: TextStyle(
                      fontSize: 30,
                      color: Color(0xFFFFFFFF),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                //input field
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.grey),
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                    child: TextField(
                      controller: textController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text("you scored $_score out of ${_sessionBooks.length}"),
                ElevatedButton(
                  onPressed: checkWord,
                  child: Text("submit"),
                )
              ],
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
