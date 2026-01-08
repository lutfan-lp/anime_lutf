import 'package:flutter/material.dart';
import '../models/anime.dart';
import '../services/anime_service.dart';
import 'anime_detail_page.dart';
import '../widgets/app_drawer.dart';

class TopAnimePage extends StatefulWidget {
  const TopAnimePage({super.key});

  @override
  State<TopAnimePage> createState() => _TopAnimePageState();
}

class _TopAnimePageState extends State<TopAnimePage> {
  final ScrollController _scrollController = ScrollController();

  List<Anime> _animeList = [];
  int _page = 1;
  bool _isLoading = false;
  bool _hasMore = true;

  @override
  void initState() {
    super.initState();
    _fetchAnime();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent - 200 &&
          !_isLoading &&
          _hasMore) {
        _fetchAnime();
      }
    });
  }

  Future<void> _fetchAnime() async {
    setState(() => _isLoading = true);

    final newAnime = await AnimeService.getTopAnime(_page);

    setState(() {
      _page++;
      _isLoading = false;

      if (newAnime.isEmpty) {
        _hasMore = false;
      } else {
        _animeList.addAll(newAnime);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Top Anime')),
      drawer: const AppDrawer(),

      body: ListView.builder(
        controller: _scrollController,
        itemCount: _animeList.length + (_hasMore ? 1 : 0),
        itemBuilder: (context, index) {
          if (index == _animeList.length) {
            return const Padding(
              padding: EdgeInsets.all(16),
              child: Center(child: CircularProgressIndicator()),
            );
          }

          final anime = _animeList[index];

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 4,
              child: InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => AnimeDetailPage(anime: anime),
                    ),
                  );
                },
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(12),
                        bottomLeft: Radius.circular(12),
                      ),
                      child: Image.network(
                        anime.imageUrl,
                        width: 90,
                        height: 120,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              anime.title,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              '⭐ ${anime.score} | Rank #${anime.rank}',
                              style: const TextStyle(
                                fontSize: 13,
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
