import 'package:bible_quizz_app/screens/game_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    void navigateToGameScreen() {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const GameScreen(),
        ),
      );
    }

    return Scaffold(
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
              SizedBox(
                height: 100,
              ),
              //logo
              SizedBox(
                width: 50,
                height: 50,
                child: Image.asset(
                  "assets/images/logo.png",
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "BibleTwist",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              //welcome back message
              Text(
                "Welcome back, Madara",
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
              //score tile
              SizedBox(
                height: 30,
              ),
              Container(
                height: 50,
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
                        Image.asset(
                          "assets/images/trophy.png",
                          width: 30,
                          height: 30,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "High Score",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    //score value
                    Text(
                      "12000000000000",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    //button
                  ],
                ),
              ),
              //button
              SizedBox(
                height: 30,
              ),
              InkWell(
                onTap: navigateToGameScreen,
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  width: double.infinity,
                  constraints: const BoxConstraints(minHeight: 48),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFC700),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Text(
                    "Start Playing",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              //stats
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    width: 150,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Color(0xFF4E58AB),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Games Played",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "24",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  //streak case
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    width: 150,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Color(0xFF4E58AB),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Best Streak",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "24",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
