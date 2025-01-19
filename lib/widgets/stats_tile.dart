import 'package:flutter/material.dart';

class StatsTile extends StatelessWidget {
  final String scoreNumber;
  final String description;
  const StatsTile(
      {super.key, required this.scoreNumber, required this.description});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      width: 150,
      height: 100,
      decoration: BoxDecoration(
        border: Border.all(
          color: Color(0xFFDBE0E5),
        ),
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      child: RichText(
        textAlign: TextAlign.center, // Center-align the text
        text: TextSpan(
          children: [
            TextSpan(
              text: scoreNumber, // Formatted number
              style: TextStyle(
                fontSize: 40, // Adjust font size
                fontWeight: FontWeight.bold,
                color: Colors.black, // Text color
              ),
            ),
            TextSpan(
              text: description, // Label
              style: TextStyle(
                fontSize: 18, // Adjust font size for the label
                color: Colors.grey, // Label color
              ),
            ),
          ],
        ),
      ),
    );
  }
}
