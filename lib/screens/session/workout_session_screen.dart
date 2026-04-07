import 'package:biomechanical_coach/core/theme/app_theme.dart';
import 'package:biomechanical_coach/data/mock_data.dart';
import 'package:biomechanical_coach/providers/app_providers.dart';
import 'package:biomechanical_coach/widgets/record_camera_panel.dart';
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
    final session = ref.watch(sessionStateProvider);

    return Scaffold(
      backgroundColor: const Color(0xFF080915),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SafeArea(child: SizedBox.shrink()),
            Row(
              children: [
                const Chip(label: Text('REC 00:32')),
                const Spacer(),
                Chip(label: Text(currentExercise.exerciseName)),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Exercise ${exerciseIndex + 1}/${workout.exercises.length}',
              style: const TextStyle(color: AppColors.textSecondary),
            ),
            Text('${currentExercise.sets} sets x ${currentExercise.reps} reps'),
            const SizedBox(height: 12),
            Expanded(
              child: RecordCameraPanel(
                reps: currentExercise.reps,
                sets: currentExercise.sets,
                leftKneeAngle: session.leftKneeAngle,
                rightKneeAngle: session.rightKneeAngle,
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
