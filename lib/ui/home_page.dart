import 'package:anime_trending_app/ui/top_character_page.dart';
import 'package:flutter/material.dart';

import '../models/anime.dart';
import '../models/character.dart';
import '../services/anime_service.dart';
import 'anime_detail_page.dart';
import 'character_detail_page.dart';
import 'top_anime_page.dart';
import '../widgets/app_drawer.dart';
import '../widgets/anime_search_delegate.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int animePage = 1;
  int characterPage = 1;

  late Future<List<Anime>> topAnime;
  late Future<List<Character>> topCharacters;

  @override
  void initState() {
    super.initState();
    topAnime = AnimeService.getTopAnime(animePage);
    topCharacters = AnimeService.getTopCharacters(characterPage);
  }

  // ---------- UI HELPER ----------
  Widget sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.purpleAccent,
        ),
      ),
    );
  }

  // ---------- ANIME CARD ----------
  Widget animeGridCard(Anime anime) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => AnimeDetailPage(anime: anime)),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                anime.imageUrl,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            anime.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 2),
          Text(
            '⭐ ${anime.score}',
            style: const TextStyle(fontSize: 12, color: Colors.white70),
          ),
        ],
      ),
    );
  }

  // ---------- CHARACTER CARD ----------
  Widget characterGridCard(Character character) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => CharacterDetailPage(character: character),
          ),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                character.imageUrl,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            character.name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 2),
          Text(
            '❤️ ${character.favorites}',
            style: const TextStyle(fontSize: 12, color: Colors.white70),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Anime Lutf'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () async {
              final query = await showSearch(
                context: context,
                delegate: AnimeSearchDelegate(),
              );
            },
          ),
        ],
      ),
      drawer: const AppDrawer(),

      body: ListView(
        children: [
          // ===== TOP ANIME =====
          sectionTitle('🔥 Top Anime'),

          FutureBuilder<List<Anime>>(
            future: topAnime,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }

              final animeList = snapshot.data!;
              return Column(
                children: [
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    itemCount: animeList.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 12,
                          childAspectRatio: 0.55,
                        ),
                    itemBuilder: (_, index) => animeGridCard(animeList[index]),
                  ),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const TopAnimePage(),
                          ),
                        );
                      },
                      child: const Text('View More'),
                    ),
                  ),
                ],
              );
            },
          ),

          // ===== TOP CHARACTERS =====
          sectionTitle('🌟 Top Characters'),

          FutureBuilder<List<Character>>(
            future: topCharacters,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }

              final characters = snapshot.data!;
              return Column(
                children: [
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    itemCount: characters.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 12,
                          childAspectRatio: 0.55,
                        ),
                    itemBuilder: (_, index) =>
                        characterGridCard(characters[index]),
                  ),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const TopCharacterPage(),
                          ),
                        );
                      },
                      child: const Text('View More'),
                    ),
                  ),
                ],
              );
            },
          ),

          // ===== FOOTER =====
          const SizedBox(height: 24),
          const Divider(),
          const Padding(
            padding: EdgeInsets.all(12),
            child: Center(
              child: Text(
                '© 2025 Anime Lutf • Universitas Annuqayah',
                style: TextStyle(fontSize: 12, color: Colors.white54),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
