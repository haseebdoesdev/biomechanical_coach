import 'package:biomechanical_coach/core/theme/app_theme.dart';
import 'package:biomechanical_coach/data/mock_data.dart';
import 'package:biomechanical_coach/providers/app_providers.dart';
import 'package:biomechanical_coach/widgets/record_camera_panel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SessionScreen extends ConsumerWidget {
  const SessionScreen({required this.exerciseId, super.key});

  final String exerciseId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final session = ref.watch(sessionStateProvider);
    final exercise = mockExercises.firstWhere(
      (e) => e.id == exerciseId,
      orElse: () => mockExercises.first,
    );

    return Scaffold(
      backgroundColor: const Color(0xFF080915),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                children: [
                  const Chip(label: Text('REC 00:32')),
                  const Spacer(),
                  Chip(label: Text(exercise.name)),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                '${session.sets} sets x ${session.reps} reps',
                style: const TextStyle(color: AppColors.textSecondary),
              ),
              const SizedBox(height: 12),
              Expanded(
                child: RecordCameraPanel(
                  reps: session.reps,
                  sets: session.sets,
                  leftKneeAngle: session.leftKneeAngle,
                  rightKneeAngle: session.rightKneeAngle,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  _Metric(label: 'Form score', value: '${session.formScore}%'),
                  const SizedBox(width: 8),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        ref
                            .read(calorieLogProvider.notifier)
                            .addCaloriesForToday(exercise.caloriesPerRep * session.reps);
                        context.push('/feedback/s1');
                      },
                      child: const Text('Finish'),
                    ),
                  ),
                  const SizedBox(width: 8),
                  _Metric(label: 'Depth', value: '${session.depthAngle}deg'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Metric extends StatelessWidget {
  const _Metric({required this.label, required this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(color: Colors.black87, borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: [Text(label), Text(value, style: const TextStyle(fontSize: 26, color: AppColors.success, fontWeight: FontWeight.w700))],
      ),
    );
  }
}

