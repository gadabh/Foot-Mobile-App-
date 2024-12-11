import 'package:flutter/material.dart';
import 'soccermodel.dart';

Widget matchTile(SoccerMatch match) {
  // Extract home and away goals
  var homeGoal = match.goal.home;
  var awayGoal = match.goal.away;

  return Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Home team name
        Expanded(
          child: Text(
            match.home.name,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.0,
            ),
          ),
        ),
        // Home team logo
        Image.network(
          match.home.logoUrl,
          width: 36.0,
          errorBuilder: (context, error, stackTrace) {
            return Icon(Icons.error, color: Colors.red);
          },
        ),
        // Match score
        Expanded(
          child: Text(
            "$homeGoal - $awayGoal",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.0,
            ),
          ),
        ),
        // Away team logo
        Image.network(
          match.away.logoUrl,
          width: 36.0,
          errorBuilder: (context, error, stackTrace) {
            return Icon(Icons.error, color: Colors.red);
          },
        ),
        // Away team name
        Expanded(
          child: Text(
            match.away.name,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.0,
            ),
          ),
        ),
      ],
    ),
  );
}