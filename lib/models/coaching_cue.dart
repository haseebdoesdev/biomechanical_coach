enum CueSeverity { high, medium, good }

class CoachingCue {
  const CoachingCue({
    required this.title,
    required this.message,
    required this.severity,
  });

  final String title;
  final String message;
  final CueSeverity severity;
}
