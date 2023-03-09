class Character {
  final String name;
  final int id;
  final String status;
  final String species;
  final String gender;
  final String image;

  const Character({
    required this.name,
    required this.id,
    required this.status,
    required this.species,
    required this.gender,
    required this.image,
  });

  factory Character.fromJson(Map<String, dynamic> json) {
    return Character(
      name: json['name'] as String,
      id: json['id'] as int,
      status: json['status'] as String,
      gender: json['gender'] as String,
      image: json['image'] as String,
      species: json['species'] as String,
    );
  }
}