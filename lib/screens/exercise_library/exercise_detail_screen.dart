import 'package:biomechanical_coach/data/mock_data.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ExerciseDetailScreen extends StatelessWidget {
  const ExerciseDetailScreen({required this.exerciseId, super.key});

  final String exerciseId;

  @override
  Widget build(BuildContext context) {
    final exercise = mockExercises.firstWhere((e) => e.id == exerciseId, orElse: () => mockExercises.first);
    return Scaffold(
      appBar: AppBar(title: Text(exercise.name)),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text(exercise.description),
          const SizedBox(height: 16),
          const Text('Reference angles', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          ...exercise.referenceAngles.entries.map((e) => ListTile(title: Text(e.key), trailing: Text('${e.value}deg'))),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => context.push('/session/${exercise.id}'),
            child: const Text('Start session'),
          ),
        ],
      ),
    );
  }
}
