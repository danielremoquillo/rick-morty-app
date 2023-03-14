class Episode {
  final String name;
  final int id;
  final String episode;
  // ignore: non_constant_identifier_names
  final DateTime air_date;

  const Episode({
    required this.name,
    required this.id,
    required this.episode,
    required this.air_date,
  });

  factory Episode.fromJson(Map<String, String> json) {
    return Episode(
      name: json['name'] as String,
      episode: json['episode'] as String,
      air_date: json['air_date'] as DateTime,
      id: json['id'] as int,
    );
  }
}
