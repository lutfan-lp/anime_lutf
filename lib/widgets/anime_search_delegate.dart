import 'package:flutter/material.dart';
import '../models/anime.dart';
import '../services/anime_service.dart';
import '../ui/anime_detail_page.dart';

class AnimeSearchDelegate extends SearchDelegate {
  int _page = 1;
  bool _isLoading = false;
  bool _hasMore = true;
  final List<Anime> _results = [];

  @override
  String get searchFieldLabel => 'Cari anime...';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      if (query.isNotEmpty)
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            query = '';
            _results.clear();
            _page = 1;
            _hasMore = true;
          },
        ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.isEmpty) {
      return const Center(child: Text('Masukkan kata kunci'));
    }

    return _buildResultList();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return const Center(child: Text('Cari anime favoritmu'));
    }

    _page = 1;
    _results.clear();
    _hasMore = true;

    return _buildResultList();
  }

  Widget _buildResultList() {
    return FutureBuilder<List<Anime>>(
      future: AnimeService.searchAnime(query, _page),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting &&
            _results.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return const Center(child: Text('Gagal memuat data'));
        }

        if (snapshot.hasData) {
          final data = snapshot.data!;
          if (data.isEmpty) {
            _hasMore = false;
          } else {
            _results.addAll(data);
            _page++;
          }
        }

        return ListView.builder(
          itemCount: _results.length,
          itemBuilder: (context, index) {
            final anime = _results[index];
            return ListTile(
              leading: Image.network(anime.imageUrl, width: 50),
              title: Text(anime.title),
              subtitle: Text('⭐ ${anime.score}'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => AnimeDetailPage(anime: anime),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
