import 'package:biomechanical_coach/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class SkeletonPainter extends CustomPainter {
  SkeletonPainter({required this.points});

  final List<Offset> points;

  static const _connections = <List<int>>[
    [0, 2],
    [0, 5],
    [2, 7],
    [5, 8],
    [0, 11],
    [0, 12],
    [11, 13],
    [13, 15],
    [15, 17],
    [17, 19],
    [19, 21],
    [12, 14],
    [14, 16],
    [16, 18],
    [18, 20],
    [20, 22],
    [11, 12],
    [11, 23],
    [12, 24],
    [23, 24],
    [23, 25],
    [25, 27],
    [27, 29],
    [29, 31],
    [24, 26],
    [26, 28],
    [28, 30],
    [30, 32],
  ];

  @override
  void paint(Canvas canvas, Size size) {
    final linePaint = Paint()
      ..color = AppColors.primary
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;
    final goodPaint = Paint()..color = AppColors.success;
    final warningPaint = Paint()..color = AppColors.warning;
    final normalPaint = Paint()..color = AppColors.primary;

    for (final c in _connections) {
      if (c[0] < points.length && c[1] < points.length) {
        canvas.drawLine(points[c[0]], points[c[1]], linePaint);
      }
    }

    for (var i = 0; i < points.length; i++) {
      final paint = switch (i) {
        25 || 26 => warningPaint,
        27 || 28 => goodPaint,
        _ => normalPaint,
      };
      final radius = i == 0 ? 7.2 : 4.6;
      canvas.drawCircle(points[i], radius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant SkeletonPainter oldDelegate) {
    return oldDelegate.points != points;
  }
}
