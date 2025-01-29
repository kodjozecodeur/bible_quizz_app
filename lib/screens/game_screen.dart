import 'package:flutter/material.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        constraints: BoxConstraints.expand(), //fills all the space(remember)
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
                      SizedBox(
                        height: 20,
                      ),
                      //scoretile and timer in game screen
                      _buildTopBar(),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Which book of the bible is this?",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      _buildScrambleBar(),
                      SizedBox(
                        height: 50,
                      ),

                      _buildWordInput(),
                      SizedBox(
                        height: 20,
                      ),
                      _buildHintbar(),
                      //bottom stats
                    ],
                  ),
                ),
              ),
              _buildBottomStats(),
            ],
          ),
        ),
      ),
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

  Padding _buildWordInput() {
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
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
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
            )
          ],
        ),
      ),
    );
  }

  Container _buildScrambleBar() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 24),
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        color: Color(0xFF4E58AB),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        textAlign: TextAlign.center,
        'SENSIGE',
        style: TextStyle(
          fontSize: 36,
          color: Colors.white,
          fontWeight: FontWeight.bold,
          letterSpacing: 8,
        ),
      ),
    );
  }

  Container _buildTopBar() {
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
                "100",
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
