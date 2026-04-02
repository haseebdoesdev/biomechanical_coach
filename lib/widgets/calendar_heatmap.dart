import 'package:flutter/material.dart';

class CalendarHeatmap extends StatelessWidget {
  const CalendarHeatmap({required this.log, super.key});

  final Map<String, int> log;

  Color _colorFor(int value) {
    if (value <= 0) return const Color(0xFF171A2D);
    if (value < 80) return const Color(0xFF17422C);
    if (value < 160) return const Color(0xFF1F6D45);
    if (value < 240) return const Color(0xFF2BAE66);
    return const Color(0xFF52E58F);
  }

  @override
  Widget build(BuildContext context) {
    const rows = 7;
    const cols = 15;
    final start = DateTime.now().subtract(const Duration(days: rows * cols - 1));
    final days = List<DateTime>.generate(
      rows * cols,
      (i) => start.add(Duration(days: i)),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Calorie heatmap', style: TextStyle(fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        SizedBox(
          height: 96,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(cols, (c) {
              return Padding(
                padding: const EdgeInsets.only(right: 3),
                child: Column(
                  children: List.generate(rows, (r) {
                    final day = days[c * rows + r];
                    final key = day.toIso8601String().split('T').first;
                    final value = log[key] ?? 0;
                    return Container(
                      width: 10,
                      height: 10,
                      margin: const EdgeInsets.only(bottom: 3),
                      decoration: BoxDecoration(
                        color: _colorFor(value),
                        borderRadius: BorderRadius.circular(3),
                      ),
                    );
                  }),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}
