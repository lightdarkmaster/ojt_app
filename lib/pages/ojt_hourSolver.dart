import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HourSolver extends StatefulWidget {
  const HourSolver({super.key});

  @override
  State<HourSolver> createState() => _HourSolverState();
}

class _HourSolverState extends State<HourSolver> {
  final TextEditingController _hoursController = TextEditingController();
  double _remainingHours = 0.0;
  double _remainingDays = 0.0;
  DateTime _estimatedDate = DateTime.now();

  void _calculateHours() {
    const totalHours = 486.0;
    double renderedhours = double.tryParse(_hoursController.text) ?? 0.0;
    if (renderedhours == 0) {
      _estimatedDate = DateTime.now();
    } else {
      _remainingHours = totalHours - renderedhours;
      _remainingDays = _remainingHours / 8;
      final remainingDays = _remainingHours / 8;
      _estimatedDate = DateTime.now().add(Duration(days: remainingDays.round()));
    }
    setState(() {});
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
        child: SingleChildScrollView(
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
              Center(
                child: ElevatedButton(
                  onPressed: _calculateHours,
                  child: const Text('Calculate'),
                ),
              ),
              Center(
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Note: Assuming You will render 8 hours per day',
                      style: const TextStyle(fontSize: 16.0, fontStyle: FontStyle.italic),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              Center(
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: Text(
                        'Remaining Hours: ${_remainingHours.toStringAsFixed(2)} hours\n'
                        'Remaining Days: ${_remainingDays.round()} Day/s\n'
                        'Estimated finish date: ${DateFormat('MMMM dd, yyyy').format(_estimatedDate)}',
                        style: const TextStyle(fontSize: 16.0, color: Colors.blue),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

