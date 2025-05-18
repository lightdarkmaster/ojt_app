import 'package:flutter/material.dart';

class AboutApp extends StatefulWidget {
  const AboutApp({super.key});

  @override
  State<AboutApp> createState() => _AboutAppState();
}

class _AboutAppState extends State<AboutApp> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('About This App'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(225, 255, 82, 82),
        elevation: 1,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _modernCard(
              child: Column(
                children: [
                  const Icon(
                    Icons.school_rounded,
                    size: 72,
                    color: Color.fromARGB(255, 247, 103, 103),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'OJT Journey',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'A pocket-sized companion where each note, quote, and moment of your OJT journey blossoms into a page of growth, grit, and grace.',
                    style: TextStyle(
                      fontSize: 15,
                      height: 1.5,
                      color: Colors.black87,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            _modernCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  SectionTitle('Features'),
                  BulletPoint(text: 'Document daily OJT experiences.'),
                  BulletPoint(text: 'Get daily motivational quotes.'),
                  BulletPoint(text: 'Tag moods to your journal entries.'),
                  BulletPoint(text: 'Reflect, grow, and track your progress.'),
                ],
              ),
            ),
            const SizedBox(height: 16),
            _modernCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  SectionTitle('Technologies Used'),
                  BulletPoint(text: 'Flutter – for cross-platform development'),
                  BulletPoint(text: 'Dart – the main programming language'),
                  BulletPoint(text: 'SQLite – for offline data storage'),
                  BulletPoint(text: 'Material Design – for smooth UI'),
                ],
              ),
            ),
            const SizedBox(height: 16),
            _developerCard(),
            const SizedBox(height: 16),
            _modernCard(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Version 1.0.0',
                  style: TextStyle(color: Colors.grey.shade600),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _modernCard({required Widget child}) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: Colors.white,
      child: Padding(padding: const EdgeInsets.all(20.0), child: child),
    );
  }

Widget _developerCard() {
  return _modernCard(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: SizedBox(
            width: double.infinity,
            height: 350,
            child: Image.asset(
              'assets/images/img5.JPG',
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          'Developed by:',
          style: TextStyle(fontSize: 14, color: Colors.black54),
        ),
        const SizedBox(height: 6),
        const Text(
          'Christian Barbosa',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 6),
        const Text(
          'A passionate developer crafting purposeful apps with Flutter.',
          style: TextStyle(fontSize: 14, color: Colors.black87, height: 1.4),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
      ],
    ),
  );
}

}

class SectionTitle extends StatelessWidget {
  final String text;
  const SectionTitle(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        text,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.w600,
          color: Colors.black87,
        ),
      ),
    );
  }
}

class BulletPoint extends StatelessWidget {
  final String text;
  const BulletPoint({required this.text, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          const Icon(Icons.circle, size: 6, color: Colors.black45),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 14.5, color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }
}
