import 'dart:convert';
import 'package:foot/pages/access.dart';
import 'package:foot/soccermodel.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart'; // Ajoute l'import pour intl

class SoccerApi {



  final String baseUrl = "https://v3.football.api-sports.io"; // Base URL
  final String apiKey = "b6092bfc723bac88cfe76465cf7b46e2"; // Replace with your API key

  // API headers
  static const Map<String, String> headers = {
    'x-rapidapi-host': "v3.football.api-sports.io",
    'x-rapidapi-key': "b6092bfc723bac88cfe76465cf7b46e2"
  };

  // Fonction pour obtenir l'URL avec la date actuelle
  String get apiUrl {
    DateTime now = DateTime.now();

    String formattedDate = DateFormat('yyyy-MM-dd').format(now);

    return "https://v3.football.api-sports.io/fixtures?date=$formattedDate";
  }

  // Fetch all matches from the API
  Future<List<SoccerMatch>> getAllMatches() async {
    try {
      final response = await http.get(Uri.parse(apiUrl), headers: headers);

      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);

        // Afficher toute la réponse brute pour déboguer
        print("Full Response: $body");

        if (body == null || body['response'] == null) {
          throw Exception("Invalid API response: 'response' key is null");
        }

        List<dynamic> matchesList = body['response'];
        print("Fetched matches: $matchesList");

        if (matchesList.isEmpty) {
          print("No matches found in response");
        }

        return matchesList.map((dynamic item) => SoccerMatch.fromJson(item)).toList();
      } else {
        print("Failed to load matches. Response: ${response.body}");
        throw Exception("Failed to load matches. Status Code: ${response.statusCode}");
      }
    } catch (error) {
      print("Error fetching matches: $error");
      return [];
    }
  }





  // Get today's matches
  Future<List<dynamic>> getTodayMatches() async {
  final String today = DateTime.now().toIso8601String().split('T')[0]; // Get today's date in YYYY-MM-DD format
  try {
  final response = await http.get(
  Uri.parse("$baseUrl/fixtures?date=$today"),
  headers: {
  "x-rapidapi-key": apiKey,
  "x-rapidapi-host": "v3.football.api-sports.io"
  },
  );

  if (response.statusCode == 200) {
  final data = jsonDecode(response.body);
  return data['response']; // List of today's matches
  } else {
  throw Exception("Failed to load today's matches");
  }
  } catch (e) {
  print('Error: $e');
  throw Exception("Error fetching today's matches");
  }
  }

  // Get list of leagues
  Future<List<dynamic>> getLeagues() async {
  try {
  final response = await http.get(
  Uri.parse("$baseUrl/leagues"),
  headers: {
  "x-rapidapi-key": apiKey,
  "x-rapidapi-host": "v3.football.api-sports.io"
  },
  );

  if (response.statusCode == 200) {
  final data = jsonDecode(response.body);
  return data['response']; // List of leagues
  } else {
  throw Exception("Failed to load leagues");
  }
  } catch (e) {
  print('Error: $e');
  throw Exception("Error fetching leagues");
  }
  }
  }



final String baseUrl = "https://v3.football.api-sports.io"; // Base URL
final String apiKey = "b6092bfc723bac88cfe76465cf7b46e2"; // Replace with your API key


// Récupérer les matchs du jour
  Future<List<dynamic>> getTodayMatches() async {
  final String today = DateTime.now().toIso8601String().split('T')[0]; // Date au format YYYY-MM-DD
  final response = await http.get(
  Uri.parse("$baseUrl/fixtures?date=$today"),
  headers: {"x-rapidapi-key": apiKey, "x-rapidapi-host": "v3.football.api-sports.io"},
  );

  if (response.statusCode == 200) {
  final data = jsonDecode(response.body);
  return data['response']; // Liste des matchs
  } else {
  throw Exception("Failed to load today's matches");
  }
  }

  // Récupérer les ligues
  Future<List<dynamic>> getLeagues() async {
  final response = await http.get(
  Uri.parse("$baseUrl/leagues"),
  headers: {"x-rapidapi-key": apiKey, "x-rapidapi-host": "v3.football.api-sports.io"},
  );

  if (response.statusCode == 200) {
  final data = jsonDecode(response.body);
  return data['response']; // Liste des ligues
  } else {
  throw Exception("Failed to load leagues");
  }
  }












