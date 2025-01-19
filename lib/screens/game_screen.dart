import 'package:bible_quizz_app/widgets/stats_tile.dart';
import 'package:flutter/material.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

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
            wordCase(),
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
            Container(
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
            )
          ],
        ),
      ),
    );
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
          // controller: textController,
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

  Container wordCase() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.all(Radius.circular(12))),
      child: Text(
        "Genesis",
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //score tile
          StatsTile(
            scoreNumber: "1230 \n",
            description: 'Points',
          ),
          StatsTile(
            scoreNumber: "12 \n",
            description: 'Game',
          ),
        ],
      ),
    );
  }
}
