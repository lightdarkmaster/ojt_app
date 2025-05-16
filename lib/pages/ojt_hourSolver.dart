import 'package:flutter/material.dart';

class HourSolver extends StatefulWidget {
  const HourSolver({super.key});

  @override
  State<HourSolver> createState() => _HourSolverState();
}

class _HourSolverState extends State<HourSolver> {
  final TextEditingController _hoursController = TextEditingController();

  void _calculateHours() {
    const totalHours = 486.0;
    double hours = double.tryParse(_hoursController.text) ?? 0.0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () => Scaffold.of(context).openDrawer(),
            );
          },
        ),
        title: const Text('OJT App'),
        backgroundColor: const Color.fromARGB(225, 255, 82, 82),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: const Text(
                'Rendered Hours',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
            ),
            TextField(
              controller: _hoursController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter hours',
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _calculateHours,
              child: const Text('Calculate'),
            ),
          ],
        ),
      ),
    );
  }
}

