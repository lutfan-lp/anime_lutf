import 'package:flutter/material.dart';
import '../models/anime.dart';
import '../services/anime_service.dart';
import 'anime_detail_page.dart';

class SearchPage extends StatefulWidget {
  final String query;
  const SearchPage({super.key, required this.query});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  int _page = 1;
  bool _isLoading = false;
  bool _hasMore = true;
  List<Anime> _results = [];

  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    _search();

    _controller.addListener(() {
      if (_controller.position.pixels >=
              _controller.position.maxScrollExtent - 200 &&
          !_isLoading &&
          _hasMore) {
        _search();
      }
    });
  }

  Future<void> _search() async {
    setState(() => _isLoading = true);

    final data = await AnimeService.searchAnime(widget.query, _page);

    setState(() {
      _page++;
      _isLoading = false;

      if (data.isEmpty) {
        _hasMore = false;
      } else {
        _results.addAll(data);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Search: "${widget.query}"')),
      body: ListView.builder(
        controller: _controller,
        itemCount: _results.length + (_hasMore ? 1 : 0),
        itemBuilder: (context, index) {
          if (index == _results.length) {
            return const Padding(
              padding: EdgeInsets.all(16),
              child: Center(child: CircularProgressIndicator()),
            );
          }

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
      ),
    );
  }
}
