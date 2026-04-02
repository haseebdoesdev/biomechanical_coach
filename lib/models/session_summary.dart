class SessionSummary {
  const SessionSummary({
    required this.id,
    required this.exerciseName,
    required this.formScore,
    required this.reps,
    required this.sets,
    required this.duration,
    required this.dateLabel,
  });

  final String id;
  final String exerciseName;
  final int formScore;
  final int reps;
  final int sets;
  final String duration;
  final String dateLabel;
}
