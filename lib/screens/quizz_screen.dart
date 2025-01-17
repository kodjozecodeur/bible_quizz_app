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
  List _books = []; //to store the elements from the json
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
    final String response = await rootBundle.loadString(
        'assets/books.json'); //load the json as a string form the json file
    final data = await jsonDecode(response);
    setState(() {
      _books = data["bibleBooks"];
      // print("...number of books ${_books.length}");
    });
  }

  //check the inout
  void checkWord() {
    String userInput = textController.text.trim();
    String originalWord = _books[_currentIndex]["name"];

    if (userInput.toLowerCase() == originalWord.toLowerCase()) {
      print("correct");
      setState(() {
        _currentIndex++;
        textController.clear();
      });
    } else {
      print("incorrect answer");
    }
  }

  //nscramble the letters
  // Function to scramble letters in a string
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
              scramble(_books[_currentIndex]["name"]),
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
