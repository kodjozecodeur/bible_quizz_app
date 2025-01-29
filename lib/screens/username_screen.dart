import 'package:bible_quizz_app/screens/home_screen.dart';
import 'package:flutter/material.dart';

class UserNameScreen extends StatelessWidget {
  const UserNameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    void navigateToHomeScreen() {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const HomeScreen(),
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //image of username
            SizedBox(
              width: 200,
              height: 200,
              child: Image.asset("assets/images/username.png"),
            ),
            SizedBox(
              height: 20,
            ),

            //username
            Text(
              "Choose a username",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            //textfield
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 30,
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFF4E58AB),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Color(0xFF4E58AB),
                  ),
                ),
                child: TextField(
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 10,
                    ),
                    border: InputBorder.none,
                    fillColor: Color(0xFF4E58AB),
                    hintText: "Enter your username here",
                    hintStyle: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ),
            //button
            SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: navigateToHomeScreen,
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
                  "Continue",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
