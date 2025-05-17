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
    double renderedHours = double.tryParse(_hoursController.text) ?? 0.0;
    if (renderedHours == 0) {
      _estimatedDate = DateTime.now();
    } else {
      _remainingHours = totalHours - renderedHours;
      _remainingDays = _remainingHours / 8;
      _estimatedDate =
          DateTime.now().add(Duration(days: _remainingDays.round()));
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('OJT Progress Tracker'),
        backgroundColor:const Color.fromARGB(225, 255, 82, 82),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15.0),
        child: Center(
          child: Card(
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            color: theme.colorScheme.surface,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Rendered Hours',
                    style: theme.textTheme.titleMedium!
                        .copyWith(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _hoursController,
                    decoration: InputDecoration(
                      labelText: 'Enter your rendered hours',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      prefixIcon: const Icon(Icons.access_time),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton.icon(
                      icon: const Icon(Icons.calculate),
                      label: const Text('Calculate'),
                      onPressed: _calculateHours,
                      style: FilledButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        backgroundColor: const Color.fromARGB(225, 255, 82, 82),
                      ),
                    ),
                  ),
                  const SizedBox(height: 28),
                  Card(
                    color: theme.colorScheme.surface,
                    elevation: 1,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            'Note:',
                            style: theme.textTheme.titleSmall!
                                .copyWith(fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            'Assuming you have 8 working hours per day.',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black54,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  if (_hoursController.text.isNotEmpty)
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20.0),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade50,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _infoRow(
                            icon: Icons.timer_outlined,
                            label: 'Remaining Hours',
                            value:
                                '${_remainingHours.toStringAsFixed(2)} hour/s',
                          ),
                          const SizedBox(height: 8),
                          _infoRow(
                            icon: Icons.calendar_today,
                            label: 'Remaining Days',
                            value: '${_remainingDays.round()} day/s',
                          ),
                          const SizedBox(height: 8),
                          _infoRow(
                            icon: Icons.event_available,
                            label: 'End Date',
                            value: DateFormat('MMMM dd, yyyy')
                                .format(_estimatedDate),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _infoRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20, color: Colors.blue),
        const SizedBox(width: 8),
        Text(
          '$label: ',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(color: Colors.black87),
          ),
        ),
      ],
    );
  }
}
