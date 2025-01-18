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
  int _currentIndex = 0;

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
      //load the json from the file
      final String response = await rootBundle.loadString('assets/books.json');
      //decode the json to map
      final data = jsonDecode(response);
      //extractthe books and shuffle them
      setState(() {
        _books = List<Map<String, dynamic>>.from(data["bibleBooks"]);
        //shuffle the books
        _books.shuffle(Random());
        _sessionBooks = _books.take(5).toList();
        print(_sessionBooks);
      });
    } catch (e) {
      print("error loading json: $e");
    }
  }

  // //check the inout
  void checkWord() {
    // Prevent out-of-range errors
    if (_currentIndex >= _sessionBooks.length) {
      showCompletionDialog(); // Show completion dialog if the session is finished
      return;
    } //to prevent out of range
    //time to check the user input

    String userInput =
        textController.text.trim(); // to prevent any trailing space
    String originalWord = _sessionBooks[_currentIndex]["name"]!;

    if (userInput.toLowerCase() == originalWord.toLowerCase()) {
      setState(() {
        _currentIndex++;
        textController.clear();
      });
      if (_currentIndex >= _sessionBooks.length) {
        showCompletionDialog(); // End session
      }
      print("correct");
    } else {
      print("incorrect answer");
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

  //reset game
  // Reset the game for a new session
  void resetGame() {
    setState(() {
      _currentIndex = 0;
      // _score = 0;
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
      body: Column(
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
          ElevatedButton(
            onPressed: checkWord,
            child: Text("submit"),
          )
        ],
      ),
    );
  }
}
