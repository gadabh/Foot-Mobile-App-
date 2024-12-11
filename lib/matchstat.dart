import 'package:flutter/material.dart';

Widget teamStat(String team, String logoUrl, String teamName) {
  return Expanded(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Display the team type (e.g., "Local Team" or "Visitor Team")
        Text(
          team,
          style: TextStyle(
            fontSize: 18.0,
          ),
        ),
        SizedBox(
          height: 10.0,
        ),
        // Display the team logo
        Image.network(
          logoUrl,
          width: 54.0,
          errorBuilder: (context, error, stackTrace) {
            return Icon(Icons.error, color: Colors.red);
          },
        ),
        SizedBox(
          height: 10.0,
        ),
        // Display the team name
        Text(
          teamName,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 18.0,
          ),
        ),
      ],
    ),
  );
}
