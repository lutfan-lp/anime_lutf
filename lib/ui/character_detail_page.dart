import 'package:flutter/material.dart';
import '../models/character.dart';

class CharacterDetailPage extends StatelessWidget {
  final Character character;

  const CharacterDetailPage({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Menggunakan extendBodyBehindAppBar agar gambar bisa full ke atas status bar jika diinginkan
      // atau tetap standar seperti sebelumnya. Di sini saya pertahankan standar.
      appBar: AppBar(
        title: Text(character.name),
        backgroundColor: Colors.transparent, // Opsional: jika ingin terlihat lebih menyatu
        elevation: 0,
      ),
      extendBodyBehindAppBar: true, // Agar gambar header terlihat di belakang Appbar
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeaderImage(),
            Padding(
              padding: const EdgeInsets.all(20.0), // Padding sedikit diperbesar agar lebih lega
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTitleAndStats(),
                  const SizedBox(height: 24),
                  _buildNicknamesSection(),
                  if (character.nicknames.isNotEmpty) const SizedBox(height: 24),
                  _buildAboutSection(),
                  const SizedBox(height: 30), // Extra space di bawah
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- WIDGET COMPONENTS ---

  Widget _buildHeaderImage() {
    return Stack(
      children: [
        Image.network(
          character.imageUrl,
          width: double.infinity,
          height: 350, // Sedikit dipertinggi agar lebih dramatis
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) =>
              Container(height: 350, color: Colors.grey), // Fallback jika gambar error
        ),
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black.withOpacity(0.0),
                  Colors.black.withOpacity(0.8), // Gradasi lebih halus
                ],
                stops: const [0.0, 0.6, 1.0],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTitleAndStats() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          character.name,
          style: const TextStyle(
            fontSize: 28, // Font lebih besar untuk judul utama
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            const Icon(Icons.favorite, color: Colors.pinkAccent, size: 20),
            const SizedBox(width: 8),
            Text(
              '${character.favorites} Favorites',
              style: const TextStyle(
                fontSize: 16,
                color: Colors.grey, // Warna teks sekunder agar tidak tabrakan dengan judul
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildNicknamesSection() {
    if (character.nicknames.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle('Nicknames'),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: character.nicknames.map((nick) {
            return Chip(
              label: Text(
                nick,
                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
              ),
              backgroundColor: Colors.deepPurple.shade800,
              padding: const EdgeInsets.symmetric(horizontal: 4),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildAboutSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle('About'),
        Text(
          character.about,
          style: const TextStyle(
            fontSize: 15, // Ukuran font yang nyaman dibaca
            height: 1.6, // Line height (spasi antar baris) penting untuk paragraf panjang
            color: Colors.white70,
          ),
          textAlign: TextAlign.justify,
        ),
      ],
    );
  }

  // Helper Widget untuk Judul Bagian
  Widget _sectionTitle(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        text.toUpperCase(), // Uppercase agar terlihat seperti header section
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.purpleAccent,
          letterSpacing: 1.2,
        ),
      ),
    );
  }
}