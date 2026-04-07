import 'package:biomechanical_coach/core/theme/app_theme.dart';
import 'package:biomechanical_coach/data/mock_data.dart';
import 'package:biomechanical_coach/widgets/skeleton_painter.dart';
import 'package:flutter/material.dart';

class RecordCameraPanel extends StatelessWidget {
  const RecordCameraPanel({
    required this.reps,
    required this.sets,
    required this.leftKneeAngle,
    required this.rightKneeAngle,
    super.key,
  });

  final int reps;
  final int sets;
  final int leftKneeAngle;
  final int rightKneeAngle;

  @override
  Widget build(BuildContext context) {
    return Stack(
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
              Text(
                'Camera preview (mock)',
                style: TextStyle(color: AppColors.textSecondary),
              ),
            ],
          ),
        ),
        Positioned.fill(child: CustomPaint(painter: SkeletonPainter(points: mockSkeleton))),
        Positioned(left: 90, bottom: 150, child: _Angle(angle: leftKneeAngle)),
        Positioned(right: 90, bottom: 150, child: _Angle(angle: rightKneeAngle)),
        Positioned(
          right: 12,
          top: 30,
          child: Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.black54,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Column(
              children: [
                Text(
                  '$reps',
                  style: const TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
                ),
                Text('$sets sets'),
              ],
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
            child: const Text(
              'Drive left knee outward - 12deg valgus detected',
              style: TextStyle(color: AppColors.warning),
            ),
          ),
        ),
      ],
    );
  }
}

class _Angle extends StatelessWidget {
  const _Angle({required this.angle});
  final int angle;

  @override
  Widget build(BuildContext context) {
    return Text(
      '$angle°',
      style: const TextStyle(color: AppColors.warning, fontWeight: FontWeight.w700),
    );
  }
}
