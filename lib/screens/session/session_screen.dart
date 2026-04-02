import 'package:biomechanical_coach/core/theme/app_theme.dart';
import 'package:biomechanical_coach/data/mock_data.dart';
import 'package:biomechanical_coach/providers/app_providers.dart';
import 'package:biomechanical_coach/widgets/skeleton_painter.dart';
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
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF090B18),
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(color: const Color(0xFF232347)),
                      ),
                    ),
                    const Positioned(
                      left: 16,
                      top: 16,
                      child: Row(
                        children: [
                          Icon(Icons.videocam, size: 18, color: AppColors.textSecondary),
                          SizedBox(width: 6),
                          Text('Camera preview (mock)', style: TextStyle(color: AppColors.textSecondary)),
                        ],
                      ),
                    ),
                    Positioned.fill(child: CustomPaint(painter: SkeletonPainter(points: mockSkeleton))),
                    Positioned(left: 90, bottom: 150, child: _Angle(angle: session.leftKneeAngle)),
                    Positioned(right: 90, bottom: 150, child: _Angle(angle: session.rightKneeAngle)),
                    Positioned(
                      right: 12,
                      top: 30,
                      child: Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(color: Colors.black54, borderRadius: BorderRadius.circular(14)),
                        child: Column(
                          children: [Text('${session.reps}', style: const TextStyle(fontSize: 34, fontWeight: FontWeight.bold)), Text('${session.sets} sets')],
                        ),
                      ),
                    ),
                    Positioned(
                      left: 10,
                      right: 10,
                      bottom: 76,
                      child: Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: AppColors.warning.withValues(alpha: 0.18),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: AppColors.warning.withValues(alpha: 0.5)),
                        ),
                        child: const Text('Drive left knee outward - 12deg valgus detected', style: TextStyle(color: AppColors.warning)),
                      ),
                    ),
                  ],
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

class _Angle extends StatelessWidget {
  const _Angle({required this.angle});
  final int angle;

  @override
  Widget build(BuildContext context) {
    return Text('$angle°', style: const TextStyle(color: AppColors.warning, fontWeight: FontWeight.w700));
  }
}
