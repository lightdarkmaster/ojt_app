import 'package:flutter/material.dart';
import 'package:ojt_app/pages/my_notes.dart';
import 'package:ojt_app/pages/ojt_hourSolver.dart';
import 'package:ojt_app/pages/ojt_introduction.dart';
import 'package:ojt_app/pages/ojt_motivation.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void _onTileTap(int index) {
    Widget page;

    switch (index) {
      case 0:
        page = const Introduction();
        break;
      case 1:
        page = const NotesPage();
        break;
      case 2:
        page = const HourSolver();
      case 3:
        page = const Motivation();
        break;
      default:
        return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => page),
    );
  }

  @override
  Widget build(BuildContext context) {
    final items = [
      {
        'icon': Icons.school,
        'title': 'OJT',
        'subtitle': 'My tapestry of first steps and silent triumphs, where learning meets life in the poetry of experience.',
      },
      {
        'icon': Icons.notes,
        'title': 'My Diaries',
        'subtitle': 'My whispered echoes of the soul, where silent ink cradles the loudest truths of the heart.',
      },
      {
        'icon': Icons.calculate,
        'title': 'Hour Solver',
        'subtitle': 'Estimate remaining hours and days',
      },
      {
        'icon': Icons.book_outlined,
        'title': 'Daily Motivation',
        'subtitle': 'Each day is a blank page — rise, write boldly, and let your actions be the ink of your ambition.',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('InternDiaries'),
        backgroundColor: const Color.fromARGB(225, 255, 82, 82),
        foregroundColor: Colors.white,
        elevation: 2,
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('About InternDiaries'),
                    content: const Text(
                      'InternDiaries is a personal digital journal for OJT students. It is a space to record your thoughts, feelings, and experiences throughout your internship. Feel free to add notes, track your hours, and stay motivated!',
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('OK'),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: items.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final item = items[index];

          return Card(
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: InkWell(
              onTap: () => _onTileTap(index),
              borderRadius: BorderRadius.circular(16),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(40, 255, 82, 82),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        item['icon'] as IconData,
                        size: 28,
                        color: const Color.fromARGB(225, 255, 82, 82),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item['title'] as String,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            item['subtitle'] as String,
                            style: const TextStyle(
                              fontSize: 13,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Icon(Icons.chevron_right),
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
