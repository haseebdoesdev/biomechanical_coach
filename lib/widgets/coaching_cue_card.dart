import 'package:biomechanical_coach/core/theme/app_theme.dart';
import 'package:biomechanical_coach/models/coaching_cue.dart';
import 'package:flutter/material.dart';

class CoachingCueCard extends StatelessWidget {
  const CoachingCueCard({required this.cue, super.key});

  final CoachingCue cue;

  @override
  Widget build(BuildContext context) {
    final color = switch (cue.severity) {
      CueSeverity.high => AppColors.error,
      CueSeverity.medium => AppColors.warning,
      CueSeverity.good => AppColors.success,
    };
    final tag = switch (cue.severity) {
      CueSeverity.high => 'High priority',
      CueSeverity.medium => 'Medium',
      CueSeverity.good => 'Good',
    };

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border(left: BorderSide(color: color, width: 4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  cue.title,
                  style: TextStyle(color: color, fontWeight: FontWeight.w700),
                ),
              ),
              Chip(label: Text(tag), backgroundColor: color.withValues(alpha: 0.2)),
            ],
          ),
          const SizedBox(height: 6),
          Text(cue.message, style: const TextStyle(color: AppColors.textSecondary)),
        ],
      ),
    );
  }
}
