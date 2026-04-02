import 'package:biomechanical_coach/core/theme/app_theme.dart';
import 'package:biomechanical_coach/data/mock_data.dart';
import 'package:biomechanical_coach/providers/app_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class WorkoutSessionScreen extends ConsumerStatefulWidget {
  const WorkoutSessionScreen({required this.workoutId, super.key});

  final String workoutId;

  @override
  ConsumerState<WorkoutSessionScreen> createState() => _WorkoutSessionScreenState();
}

class _WorkoutSessionScreenState extends ConsumerState<WorkoutSessionScreen> {
  int exerciseIndex = 0;

  @override
  Widget build(BuildContext context) {
    final workouts = ref.watch(workoutPlansProvider);
    final workout = workouts.firstWhere(
      (w) => w.id == widget.workoutId,
      orElse: () => workouts.first,
    );
    final currentExercise = workout.exercises[exerciseIndex];
    final isLast = exerciseIndex == workout.exercises.length - 1;

    return Scaffold(
      appBar: AppBar(title: Text('${workout.name} session')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Exercise ${exerciseIndex + 1}/${workout.exercises.length}',
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            Text(
              currentExercise.exerciseName,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
            ),
            Text('${currentExercise.sets} sets x ${currentExercise.reps} reps'),
            const SizedBox(height: 16),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xFF090B18),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xFF25284A)),
                ),
                child: const Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.videocam, size: 52, color: AppColors.textSecondary),
                      SizedBox(height: 10),
                      Text('Camera preview (mock)', style: TextStyle(color: AppColors.textSecondary)),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 14),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (isLast) {
                    final totalCalories = workout.exercises.fold<int>(0, (sum, item) {
                      final exercise = mockExercises.firstWhere(
                        (e) => e.id == item.exerciseId,
                        orElse: () => mockExercises.first,
                      );
                      return sum + exercise.caloriesPerRep * item.reps;
                    });
                    ref
                        .read(calorieLogProvider.notifier)
                        .addCaloriesForToday(totalCalories);
                    context.go('/workout-feedback/${workout.id}');
                    return;
                  }
                  setState(() => exerciseIndex++);
                },
                child: Text(isLast ? 'Finish workout' : 'Next exercise'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
