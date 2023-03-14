class Episode {
  final String name;
  final int id;
  final String episode;
  // ignore: non_constant_identifier_names

  const Episode({
    required this.name,
    required this.id,
    required this.episode,
  });

  factory Episode.fromJson(Map<String, String> json) {
    return Episode(
      name: json['name'] as String,
      episode: json['episode'] as String,
      id: json['id'] as int,
    );
  }
}
