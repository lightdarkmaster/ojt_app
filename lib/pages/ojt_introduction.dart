import 'package:flutter/material.dart';

class Introduction extends StatefulWidget {
  const Introduction({super.key});

  @override
  State<Introduction> createState() => _IntroductionState();
}

class _IntroductionState extends State<Introduction> {
  final List<Map<String, String>> ojtCards = [
    {
      'title': 'Getting Started',
      'image': 'assets/images/img2.gif',
      'description': 'The journey begins with curiosity, nervous smiles, and orientation to the real world of work.',
    },
    {
      'title': 'Learning the Ropes',
      'image': 'assets/images/img1.gif',
      'description': 'From new software to unfamiliar systems, every task was a new adventure.',
    },
    {
      'title': 'Teamwork & Growth',
      'image': 'assets/images/img3.gif',
      'description': 'Collaborating with mentors and peers made challenges easier and fun moments unforgettable.',
    },
    {
      'title': 'Unforgettable Memories',
      'image': 'assets/images/img4.gif',
      'description': 'Snapshots of laughter, deadlines, and that first real taste of achievement.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My OJT Journey'),
        backgroundColor: Colors.deepOrangeAccent,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: ojtCards.length,
        itemBuilder: (context, index) {
          final card = ojtCards[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 20),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            elevation: 4,
            clipBehavior: Clip.antiAlias,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  card['image']!,
                  width: double.infinity,
                  height: 180,
                  fit: BoxFit.cover,
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        card['title']!,
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.deepOrange,
                            ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        card['description']!,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Colors.grey[700],
                            ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
