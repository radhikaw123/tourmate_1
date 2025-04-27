// lib/views/home/gallery_page.dart
import 'package:flutter/material.dart';

class GalleryPage extends StatelessWidget {
  const GalleryPage({super.key});

  // Replace these with your actual asset paths or network URLs
  final List<String> _images = const [
    'assets/images/taj_mahal.jpg',
    'assets/images/india_gate.jpg',
    'assets/images/hawa_mahal.jpg',
    'assets/images/gateway_of_india.jpg',
    'assets/images/qutub_minar.jpg',
    'assets/images/char_minar.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Explore Destinations')),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: GridView.builder(
          itemCount: _images.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // two columns
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemBuilder: (context, idx) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(_images[idx], fit: BoxFit.cover),
            );
          },
        ),
      ),
    );
  }
}
