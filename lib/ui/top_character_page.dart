import 'package:anime_trending_app/models/character.dart';
import 'package:flutter/material.dart';
import 'character_detail_page.dart';
import '../services/character_service.dart';
import '../widgets/app_drawer.dart';

class TopCharacterPage extends StatefulWidget {
  const TopCharacterPage({super.key});

  @override
  State<TopCharacterPage> createState() => _TopCharacterPageState();
}

class _TopCharacterPageState extends State<TopCharacterPage> {
  final ScrollController _scrollController = ScrollController();

  List<Character> _characterList = [];
  int _page = 1;
  bool _isLoading = false;
  bool _hasMore = true;

  @override
  void initState() {
    super.initState();
    _fetchCharacters();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent - 200 &&
          !_isLoading &&
          _hasMore) {
        _fetchCharacters();
      }
    });
  }

  Future<void> _fetchCharacters() async {
    setState(() => _isLoading = true);

    final newCharacters = await CharacterService.fetchTopCharacters(_page);

    setState(() {
      _page++;
      _isLoading = false;

      if (newCharacters.isEmpty) {
        _hasMore = false;
      } else {
        _characterList.addAll(newCharacters);
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
      appBar: AppBar(title: const Text('Top Characters')),
      drawer: const AppDrawer(),

      body: ListView.builder(
        controller: _scrollController,
        itemCount: _characterList.length + (_hasMore ? 1 : 0),
        itemBuilder: (context, index) {
          if (index == _characterList.length) {
            return const Padding(
              padding: EdgeInsets.all(16),
              child: Center(child: CircularProgressIndicator()),
            );
          }

          final character = _characterList[index];

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
                      builder: (_) => CharacterDetailPage(character: character),
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
                        character.imageUrl,
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
                              character.name,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              '⭐ ${character.favorites}',
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
