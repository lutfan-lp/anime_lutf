class Character {
  final int id;
  final String name;
  final String imageUrl;
  final int favorites;
  final List<String> nicknames;
  final String about;

  Character({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.favorites,
    required this.nicknames,
    required this.about,
  });

  factory Character.fromJson(Map<String, dynamic> json) {
    return Character(
      id: json['mal_id'],
      name: json['name'],
      imageUrl: json['images']['jpg']['image_url'],
      favorites: json['favorites'] ?? 0,
      nicknames: List<String>.from(json['nicknames'] ?? []),
      about: json['about'] ?? 'Tidak ada deskripsi.',
    );
  }
}
