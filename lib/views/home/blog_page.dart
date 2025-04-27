import 'package:flutter/material.dart';

class BlogPage extends StatelessWidget {
  const BlogPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Blog',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: const [
            BlogTile(
              title: 'Taj Mahal',
              description:
                  'An ivory-white marble mausoleum in Agra, built by Shah Jahan in memory of his wife.',
              imagePath: 'assets/images/taj_mahal.jpg',
            ),
            SizedBox(height: 16),
            BlogTile(
              title: 'Qutub Minar',
              description:
                  'A 73-meter tall Indo-Islamic architectural tower built in the 13th century in Delhi.',
              imagePath: 'assets/images/qutub_minar.jpg',
            ),
            SizedBox(height: 16),
            BlogTile(
              title: 'Gateway Of India',
              description:
                  'An arch-monument built in Mumbai to commemorate King George V and Queen Mary\'s visit.',
              imagePath: 'assets/images/gateway_of_india.jpg',
            ),
            SizedBox(height: 16),
            BlogTile(
              title: 'Charminar',
              description:
                  'A 16th-century mosque and landmark located in Hyderabad, famous for its four grand arches.',
              imagePath: 'assets/images/char_minar.jpg',
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // No action for now
        },
        backgroundColor: Colors.orange,
        child: const Icon(Icons.add),
      ),
    );
  }
}

class BlogTile extends StatelessWidget {
  final String title;
  final String description;
  final String imagePath;

  const BlogTile({
    super.key,
    required this.title,
    required this.description,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      color: Colors.white,
      child: Row(
        children: [
          // Image Section
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(15),
              bottomLeft: Radius.circular(15),
            ),
            child: Image.asset(
              imagePath,
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
          ),

          // Text Section
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    description,
                    style: const TextStyle(fontSize: 14, color: Colors.black54),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
