class Anime {
  final int id;
  final String title;
  final String imageUrl;
  final double score;
  final int rank;
  final int episodes;
  final String status;
  final String duration;
  final String type;
  final String season;
  final int year;
  final List<String> genres;
  final List<String> studios;
  final String synopsis;

  Anime({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.score,
    required this.rank,
    required this.episodes,
    required this.status,
    required this.duration,
    required this.type,
    required this.season,
    required this.year,
    required this.genres,
    required this.studios,
    required this.synopsis,
  });

  factory Anime.fromJson(Map<String, dynamic> json) {
    return Anime(
      id: json['mal_id'],
      title: json['title'],
      imageUrl: json['images']['jpg']['image_url'],
      score: (json['score'] ?? 0).toDouble(),
      rank: json['rank'] ?? 0,
      episodes: json['episodes'] ?? 0,
      status: json['status'] ?? '-',
      duration: json['duration'] ?? '-',
      type: json['type'] ?? '-',
      season: json['season'] ?? '-',
      year: json['year'] ?? 0,
      genres: (json['genres'] as List).map((g) => g['name'] as String).toList(),
      studios: (json['studios'] as List)
          .map((s) => s['name'] as String)
          .toList(),
      synopsis: json['synopsis'] ?? 'No synopsis available.',
    );
  }
}
