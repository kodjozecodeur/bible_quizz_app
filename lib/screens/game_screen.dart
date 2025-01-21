import 'package:bible_quizz_app/provider/books_retreiver_provider.dart';
import 'package:bible_quizz_app/widgets/stats_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final TextEditingController _answerController =
      TextEditingController(); // Add this controller

  @override
  void initState() {
    super.initState();
    // Initialize books when screen loads
    Future.microtask(() => context.read<BooksRetreiverProvider>().readJson());
  }

  @override
  void dispose() {
    _answerController.dispose(); // Dispose of the controller when done
    super.dispose();
  }

  Padding textInput() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          border: Border.all(width: 1, color: Color(0xFFF0F2F5)),
          color: Color(0xFFF0F2F5),
          borderRadius: BorderRadius.all(
            Radius.circular(12),
          ),
        ),
        child: TextField(
          controller: _answerController,
          decoration: InputDecoration(
              border: InputBorder.none,
              hintText: "Type your answer here",
              hintStyle: TextStyle(
                color: Color(0xFF637587),
                fontSize: 18,
              )),
        ),
      ),
    );
  }

  Container wordCase(BooksRetreiverProvider booksProvider) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.all(Radius.circular(12))),
      child: Text(
        booksProvider.currentScrambledWord,
        style: TextStyle(
          fontSize: 30,
          color: Color(0xFFFFFFFF),
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Padding scoreSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Consumer<BooksRetreiverProvider>(
        builder: (BuildContext context, booksProvider, child) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //score tile
              StatsTile(
                scoreNumber: "${booksProvider.score} \n",
                description: 'Points',
              ),
              StatsTile(
                scoreNumber: "${booksProvider.streak} \n",
                description: 'Streak',
              ),
            ],
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 25,
            ),
            //score and streak point
            scoreSection(),

            Spacer(),
            //scramble word case
            Consumer<BooksRetreiverProvider>(
              builder: (context, booksProvider, child) {
                if (booksProvider.sessionBooks.isEmpty ||
                    booksProvider.currentIndex >
                        booksProvider.sessionBooks.length) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return wordCase(booksProvider);
                }
              },
            ),
            //input for validation
            SizedBox(
              height: 25,
            ),
            //input for validation
            SizedBox(
              height: 25,
            ),
            textInput(),

            Spacer(),
            //validation button
            submitButton(),
          ],
        ),
      ),
    );
  }

  Widget submitButton() {
    return Consumer<BooksRetreiverProvider>(
      builder: (context, booksProvider, child) {
        if (booksProvider.isGameComplete) {
          return Container(
            width: double.infinity,
            padding: EdgeInsets.all(16),
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.all(Radius.circular(30))),
            child: Text(
              "Game Complete! Final Score: ${booksProvider.score}",
              style: TextStyle(
                fontSize: 20,
                color: Color(0xFFFFFFFF),
              ),
              textAlign: TextAlign.center,
            ),
          );
        }

        return GestureDetector(
          onTap: () {
            bool isCorrect = booksProvider.checkAnswer(_answerController.text);

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  isCorrect
                      ? booksProvider.isGameComplete
                          ? 'Game Complete!'
                          : 'Correct!'
                      : 'Try again!',
                  style: TextStyle(color: Colors.white),
                ),
                backgroundColor: isCorrect ? Colors.green : Colors.red,
                duration: Duration(seconds: 1),
              ),
            );

            _answerController.clear();

            // If game is complete, you might want to navigate or show a dialog
            if (booksProvider.isGameComplete) {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('Congratulations!'),
                  content: Text(
                      'You completed the game!\nFinal Score: ${booksProvider.score}'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context); // Close dialog
                        // You might want to navigate back or restart game
                        // Navigator.pop(context);  // Go back to previous screen
                        booksProvider.resetGame();
                      },
                      child: Text('OK'),
                    ),
                  ],
                ),
              );
            }
          },
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.all(16),
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
                color: Color(0xFF1A80E5),
                borderRadius: BorderRadius.all(Radius.circular(30))),
            child: Text(
              "Submit",
              style: TextStyle(
                fontSize: 20,
                color: Color(0xFFFFFFFF),
              ),
              textAlign: TextAlign.center,
            ),
          ),
        );
      },
    );
  }
}
