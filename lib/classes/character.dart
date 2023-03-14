class Character {
  final String name;
  final int id;
  final String status;
  final String species;
  final String gender;
  final String image;
  final Map<String, dynamic> location;
  final Map<String, dynamic> origin;
  final List<dynamic> episode;

  const Character({
    required this.name,
    required this.id,
    required this.status,
    required this.species,
    required this.gender,
    required this.image,
    required this.location,
    required this.origin,
    required this.episode,
  });

  factory Character.fromJson(Map<String, dynamic> json) {
    return Character(
      name: json['name'] as String,
      id: json['id'] as int,
      status: json['status'] as String,
      gender: json['gender'] as String,
      image: json['image'] as String,
      species: json['species'] as String,
      location: json['location'] as Map<String, dynamic>,
      origin: json['origin'] as Map<String, dynamic>,
      episode: json['episode'],
    );
  }
}
