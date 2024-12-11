class SoccerMatch {
  final Fixture fixture;
  final Team home;
  final Team away;
  final Goal goal;

  SoccerMatch(this.fixture, this.home, this.away, this.goal);

  factory SoccerMatch.fromJson(Map<String, dynamic> json) {
    return SoccerMatch(
      Fixture.fromJson(json['fixture']),
      Team.fromJson(json['teams']['home']),
      Team.fromJson(json['teams']['away']),
      Goal.fromJson(json['goals']),
    );
  }
}

class Fixture {
  final int id;
  final String date;
  final Status status;

  Fixture(this.id, this.date, this.status);

  factory Fixture.fromJson(Map<String, dynamic> json) {
    return Fixture(
      json['id'] ?? 0,
      json['date'] ?? '',
      Status.fromJson(json['status']),
    );
  }
}

class Status {
  final int elapsedTime;
  final String description;

  Status(this.elapsedTime, this.description);

  factory Status.fromJson(Map<String, dynamic> json) {
    return Status(
      json['elapsed'] ?? 0,
      json['long'] ?? 'Unknown Status',
    );
  }
}

class Team {
  final int id;
  final String name;
  final String logoUrl;
  final bool winner;
  final int? score;

  Team(this.id, this.name, this.logoUrl, this.winner, this.score);

  factory Team.fromJson(Map<String, dynamic> json) {
    return Team(
      json['id'] ?? 0,
      json['name'] ?? 'Unknown Team',
      json['logo'] ?? '',
      json['winner'] ?? false,
      json['score'] as int?,
    );
  }
}

class Goal {
  final int home;
  final int away;

  Goal(this.home, this.away);

  factory Goal.fromJson(Map<String, dynamic> json) {
    return Goal(
      json['home'] ?? 0,
      json['away'] ?? 0,
    );
  }
}

class League {
  final String? name;
  final String? country;
  final String? logo;
  final int? season;
  final String? round;

  League({
    this.name,
    this.country,
    this.logo,
    this.season,
    this.round,
  });

  factory League.fromJson(Map<String, dynamic> json) {
    // Print json to debug
    print(json);  // This will help you inspect the response structure

    return League(
      name: json['league']['name'] as String?, // Access 'league' object and then 'name'
      country: json['country']['name']as String?, // Access 'league' object and then 'country'
      logo: json['league']['logo'] as String?, // Access 'league' object and then 'logo'
      season: json['league']['season'] as int?, // Access 'league' object and then 'season'
      round: json['league']['round'] as String?, // Access 'league' object and then 'round'
    );
  }
}
