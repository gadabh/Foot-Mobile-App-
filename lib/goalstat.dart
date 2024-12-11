import 'package:flutter/material.dart';

Widget goalStat(int expandedTime, int homeGoal, int awayGoal) {
  // Display the elapsed time and the score
  return Expanded(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Display the elapsed time
        Text(
          "${expandedTime}'",
          style: TextStyle(
            fontSize: 30.0,
          ),
        ),
        SizedBox(height: 10.0), // Add some spacing between the texts
        // Display the score
        Text(
          "$homeGoal - $awayGoal",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 36.0,
          ),
        ),
      ],
    ),
  );
}
