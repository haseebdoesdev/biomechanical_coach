import 'package:biomechanical_coach/data/mock_data.dart';
import 'package:biomechanical_coach/providers/app_providers.dart';
import 'package:biomechanical_coach/widgets/coaching_cue_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class WorkoutFeedbackScreen extends ConsumerWidget {
  const WorkoutFeedbackScreen({required this.workoutId, super.key});

  final String workoutId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final workouts = ref.watch(workoutPlansProvider);
    final workout = workouts.firstWhere(
      (w) => w.id == workoutId,
      orElse: () => workouts.first,
    );

    var totalReps = 0;
    var totalSets = 0;
    var sumScore = 0;

    for (final item in workout.exercises) {
      final stats = mockExerciseSessionStats[item.exerciseId]!;
      totalReps += stats['totalReps'] as int;
      totalSets += stats['sets'] as int;
      sumScore += stats['formScore'] as int;
    }
    final avgScore = (sumScore / workout.exercises.length).round();

    return Scaffold(
      appBar: AppBar(title: Text('${workout.name} analysis')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Overall workout summary'),
                  const SizedBox(height: 6),
                  Text('Avg form score: $avgScore%'),
                  Text('Total reps: $totalReps'),
                  Text('Total sets: $totalSets'),
                  const Text('Duration: 12:28'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          for (final item in workout.exercises) ...[
            Card(
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.exerciseName,
                      style: const TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Builder(
                      builder: (_) {
                        final stats = mockExerciseSessionStats[item.exerciseId]!;
                        return Text(
                          'Form ${stats['formScore']}% • Correct ${stats['correctReps']}/${stats['totalReps']} • ${stats['sets']} sets • ${stats['duration']}',
                        );
                      },
                    ),
                    const SizedBox(height: 10),
                    ...mockFeedbackCuesByExercise[item.exerciseId]!
                        .map((cue) => CoachingCueCard(cue: cue)),
                    Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
                        onPressed: () => context.push('/library/${item.exerciseId}'),
                        child: const Text('Fix this'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
          ],
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {},
                  child: const Text('Save session'),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: ElevatedButton(
                  onPressed: () => context.go('/home'),
                  child: const Text('Done'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
