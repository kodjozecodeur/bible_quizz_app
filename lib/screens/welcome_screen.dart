import 'package:bible_quizz_app/screens/username_screen.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    void navigateToUsernameScreen() {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const UserNameScreen(),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Image.asset(
            "assets/images/welcome.png",
            height: MediaQuery.sizeOf(context).height * 0.6,
            fit: BoxFit.cover,
            width: MediaQuery.sizeOf(context).width * 1,
            // errorBuilder: (context, error, stackTrace) {
            //   return Text('Image failed to load: $error');
            // },
          ),
          const SizedBox(
            height: 40,
          ),
          //app name
          Text(
            "BibleTwist",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            "Welcome to the ultimate quiz app where you \n can test your knowledge of biblical figures!",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          //get started button
          InkWell(
            onTap: navigateToUsernameScreen,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
        ],
      ),
    );
  }
}
