import 'package:flutter/material.dart';
import 'goalstat.dart';
import 'matchstat.dart';
import 'matchtile.dart';
import 'soccermodel.dart';

class PaginatedMatches extends StatefulWidget {
  final List<SoccerMatch> allMatches;

  const PaginatedMatches({Key? key, required this.allMatches}) : super(key: key);

  @override
  _PaginatedMatchesState createState() => _PaginatedMatchesState();
}

class _PaginatedMatchesState extends State<PaginatedMatches> {
  ScrollController _scrollController = ScrollController();
  List<SoccerMatch> currentMatches = [];
  int itemsPerPage = 10;
  int pageIndex = 0;
  bool isLoading = false;  // Track loading state

  @override
  void initState() {
    super.initState();
    // Charger les premiers éléments
    _loadMatches();
    _scrollController.addListener(() {
      // Vérifier si on a atteint le bas de la liste pour charger plus d'éléments
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        _loadMatches();
      }
    });
  }

  // Charger les matchs par pages
  void _loadMatches() {
    if (isLoading) return; // Prevent multiple loads at the same time

    setState(() {
      isLoading = true;
    });

    // Simulate network delay or load operation
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        int start = pageIndex * itemsPerPage;
        int end = start + itemsPerPage;

        // Limiter la liste pour ne pas dépasser le nombre total de matchs
        currentMatches.addAll(widget.allMatches.sublist(
            start,
            end > widget.allMatches.length ? widget.allMatches.length : end
        ));
        pageIndex++;
        isLoading = false;
      });
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 5,
      child: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Color(0xFF4373D9),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40.0),
            topRight: Radius.circular(40.0),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "MATCHES",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10.0),
              Expanded(
                child: Stack(
                  children: [
                    // List of matches
                    ListView.builder(
                      controller: _scrollController,
                      itemCount: currentMatches.length,
                      itemBuilder: (context, index) {
                        return matchTile(currentMatches[index]);
                      },
                    ),
                    // Show loading text when loading
                    if (isLoading)
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.black),

                            ),

                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget PageBody(List<SoccerMatch> allMatches) {
  // Vérification si la liste des matchs est vide
  if (allMatches.isEmpty) {
    return const Center(
      child: Text(
        "No matches available.",
        style: TextStyle(fontSize: 16.0, color: Colors.black54),
      ),
    );
  }

  return Column(
    children: [
      // Section supérieure avec les statistiques du premier match
      Expanded(
        flex: 2,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 24.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              teamStat(
                "Local Team",
                allMatches[0].home.logoUrl,
                allMatches[0].home.name,
              ),
              goalStat(
                allMatches[0].fixture.status.elapsedTime,
                allMatches[0].goal.home,
                allMatches[0].goal.away,
              ),
              teamStat(
                "Visitor Team",
                allMatches[0].away.logoUrl,
                allMatches[0].away.name,
              ),
            ],
          ),
        ),
      ),

      // Section inférieure avec la pagination
      PaginatedMatches(allMatches: allMatches),
    ],
  );
}
