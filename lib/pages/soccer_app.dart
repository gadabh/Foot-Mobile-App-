import 'package:flutter/material.dart';
import '../api_manager.dart';
import '../soccermodel.dart';

class SoccerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFAFAFA),
        elevation: 0.0,
        title: const Text(
          "SOCCERBOARD",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: SoccerApi().getTodayMatches(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(
              child: Text("Could not load data. Please try again later."),
            );
          } else if (snapshot.hasData) {
            List<SoccerMatch> matches = (snapshot.data as List)
                .map((data) => SoccerMatch.fromJson(data))
                .toList();
            return ListView(
              padding: const EdgeInsets.all(16),
              children: [
                const Text(
                  "Today's Matches",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 10),
                matches.isEmpty
                    ? const Text("No matches scheduled for today.")
                    : Column(
                  children: matches
                      .map((match) => ListTile(
                    leading: Text(match.home.name),
                    trailing: Text(match.away.name),
                    title: Text(
                      "${match.home.score ?? 0} - ${match.away.score ?? 0}",
                      textAlign: TextAlign.center,
                    ),
                  ))
                      .toList(),
                ),
              ],
            );
          } else {
            return const Center(
              child: Text("No data available."),
            );
          }
        },
      ),
    );
  }
}
