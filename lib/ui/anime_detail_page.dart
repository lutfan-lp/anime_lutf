import 'package:flutter/material.dart';
import '../models/anime.dart';
import '../widgets/app_drawer.dart';

class AnimeDetailPage extends StatelessWidget {
  final Anime anime;

  const AnimeDetailPage({super.key, required this.anime});

  Widget infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text('$label: ', style: const TextStyle(fontWeight: FontWeight.bold)),
          Expanded(
            child: Text(value, style: const TextStyle(color: Colors.white70)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(anime.title)),
      drawer: const AppDrawer(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Poster
            Image.network(
              anime.imageUrl,
              width: double.infinity,
              height: 320,
              fit: BoxFit.cover,
            ),

            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    anime.title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  // Score & Rank
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber),
                      const SizedBox(width: 4),
                      Text('${anime.score}'),
                      const SizedBox(width: 12),
                      Text('Rank #${anime.rank}'),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // Info
                  infoRow('Type', anime.type),
                  infoRow('Episodes', anime.episodes.toString()),
                  infoRow('Status', anime.status),
                  infoRow('Duration', anime.duration),
                  infoRow(
                    'Season',
                    '${anime.season.toUpperCase()} ${anime.year}',
                  ),

                  const SizedBox(height: 16),

                  // Studios
                  const Text(
                    'Studios',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.purpleAccent,
                    ),
                  ),
                  Wrap(
                    spacing: 8,
                    children: anime.studios
                        .map((s) => Chip(label: Text(s)))
                        .toList(),
                  ),

                  const SizedBox(height: 16),

                  // Genres
                  const Text(
                    'Genres',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.purpleAccent,
                    ),
                  ),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: anime.genres
                        .map(
                          (g) => Chip(
                            label: Text(g),
                            backgroundColor: Colors.deepPurple.shade700,
                          ),
                        )
                        .toList(),
                  ),

                  const SizedBox(height: 16),

                  // Synopsis
                  const Text(
                    'Synopsis',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.purpleAccent,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    anime.synopsis,
                    style: const TextStyle(
                      fontSize: 14,
                      height: 1.5,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
