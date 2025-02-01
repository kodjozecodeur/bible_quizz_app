import 'package:bible_quizz_app/provider/books_retreiver_provider.dart';
import 'package:bible_quizz_app/screens/game_complete_screen.dart';
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

  @override
  Widget build(BuildContext context) {
    return Consumer<BooksRetreiverProvider>(
      builder: (BuildContext context, booksProvider, Widget? child) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (booksProvider.isGameComplete) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => GameCompleteScreen(
                  finalScore: booksProvider.score,
                ),
              ),
            );
          }
        });
        return Scaffold(
          resizeToAvoidBottomInset: true,
          body: Container(
            constraints:
                BoxConstraints.expand(), //fills all the space(remember)
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF283595),
                  Color(0xFF6A4F9F),
                ],
              ),
            ),
            child: SafeArea(
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(height: 10),
                          //scoretile and timer in game screen
                          _buildTopBar(booksProvider),
                          SizedBox(height: 10),
                          AnimatedSwitcher(
                              duration: Duration(milliseconds: 500),
                              child: _buildProgressBar(booksProvider)),
                          Text(
                            "Which book of the bible is this?",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w400),
                          ),
                          SizedBox(height: 10),
                          _buildScrambleBar(booksProvider),
                          SizedBox(height: 20),
                          _buildWordInput(context, booksProvider),
                          SizedBox(height: 10),
                          _buildHintbar(),
                          //bottom stats
                        ],
                      ),
                    ),
                  ),
                  // trigger when game is complete

                  // _buildBottomStats(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Container _buildBottomStats() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: Color(0xFF4E58AB),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          //statsTile
          _buildStatItem("level", "1/5"),
          _buildStatItem("Correct words", "12"),
          _buildStatItem("Streak", "🔥 4"),
        ],
      ),
    );
  }

  Container _buildHintbar() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: Color(0xFF4E58AB),
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //icons
          Row(
            children: [
              Text(
                "Need a hint?",
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(
                width: 10,
              ),
            ],
          ),
          //score value
          Row(
            children: [
              ElevatedButton.icon(
                onPressed: () {},
                icon: Icon(Icons.lightbulb_outline),
                label: Text('Get Hint'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
          )
          //button
        ],
      ),
    );
  }

  Padding _buildWordInput(
    BuildContext context,
    BooksRetreiverProvider booksProvider,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            TextField(
              onSubmitted: (value) => _checkAnswer(context, booksProvider),
              controller: _answerController,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              decoration: InputDecoration(
                hintText: 'Enter Answer',
                hintStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xFF283595),
                  ),
                ),
                filled: true,
                fillColor: Colors.grey[100],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            _buildSubmitWord(booksProvider),
          ],
        ),
      ),
    );
  }

  SizedBox _buildSubmitWord(BooksRetreiverProvider booksProvider) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () => _checkAnswer(context, booksProvider),
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFF1A237E),
          padding: EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        child: Text(
          'Submit',
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Container _buildScrambleBar(BooksRetreiverProvider booksProvider) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 24),
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        color: Color(0xFF4E58AB),
        borderRadius: BorderRadius.circular(20),
      ),
      child: booksProvider.sessionBooks.isEmpty
          ? CircularProgressIndicator(
              color: Colors.white,
            )
          : Text(
              booksProvider.currentScrambledWord,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 36,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                letterSpacing: 8,
              ),
            ),
    );
  }

  Container _buildTopBar(BooksRetreiverProvider booksProvider) {
    return Container(
      height: 50,
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: Color(0xFF4E58AB),
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //icons
          Row(
            children: [
              Icon(
                Icons.timer,
                color: Colors.white,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                "0:45",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          //score value
          Row(
            children: [
              Icon(
                Icons.star_rounded,
                color: Color(0xFFFFC700),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                "${booksProvider.score}",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              )
            ],
          )
          //button
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: Colors.white70,
          ),
        ),
        SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

//control on submit
  void _checkAnswer(
      BuildContext context, BooksRetreiverProvider booksProvider) {
    final answer = _answerController.text.trim();
    if (answer.isEmpty) return;

    final isCorrect = booksProvider.checkAnswer(answer);
    _answerController.clear();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(isCorrect ? 'Correct! 🎉' : 'Try Again! ❌'),
        backgroundColor: isCorrect ? Colors.green : Colors.red,
      ),
    );
  }

  Widget _buildProgressBar(BooksRetreiverProvider booksProvider) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        children: [
          // Text progress
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Question ${booksProvider.currentQuestionNumber}",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              Text(
                "${booksProvider.currentQuestionNumber}/${booksProvider.totalQuestions}",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          // Visual progress bar
          LinearProgressIndicator(
            value: booksProvider.currentQuestionNumber /
                booksProvider.totalQuestions,
            backgroundColor: Colors.grey[300],
            valueColor: AlwaysStoppedAnimation<Color>(Colors.amber),
            minHeight: 12,
            borderRadius: BorderRadius.circular(10),
          ),
        ],
      ),
    );
  }
}
