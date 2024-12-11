import 'package:flutter/material.dart';
import '../api_manager.dart'; // Assuming this handles API fetching logic
import '../soccermodel.dart'; // Assuming this contains your model classes

class LeagueSummaryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFAFAFA),
        elevation: 0.0,
        title: const Text(
          "League Summary",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: SoccerApi().getLeagues(), // Ensure this returns a list of leagues
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text("Error: ${snapshot.error ?? 'Unknown error'}"),
            );
          } else if (snapshot.hasData) {
            List<League> leagues = (snapshot.data as List)
                .map((data) => League.fromJson(data))
                .toList();
            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: leagues.length,
              itemBuilder: (context, index) {
                League league = leagues[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    leading: league.logo != null
                        ? Image.network(
                      league.logo!,
                      width: 40,
                      height: 40,
                    )
                        : const Icon(Icons.sports_soccer),
                    title: Text(
                      league.name ?? "Unknown League", // Safe handling for null name
                      style: Theme.of(context).textTheme.titleLarge, // Updated property for large title
                    ),
                    subtitle: Text(
                      league.country ?? "Unknown Country", // Safe handling for null country
                      style: Theme.of(context).textTheme.bodyLarge, // Updated property for body text
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center(
              child: Text("No league data available."),
            );
          }
        },
      ),
    );
  }
}
