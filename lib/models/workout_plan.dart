class WorkoutExerciseConfig {
  const WorkoutExerciseConfig({
    required this.exerciseId,
    required this.exerciseName,
    required this.sets,
    required this.reps,
  });

  final String exerciseId;
  final String exerciseName;
  final int sets;
  final int reps;
}

class WorkoutPlan {
  const WorkoutPlan({
    required this.id,
    required this.name,
    required this.goalTags,
    required this.exercises,
    this.isCustom = false,
  });

  final String id;
  final String name;
  final List<String> goalTags;
  final List<WorkoutExerciseConfig> exercises;
  final bool isCustom;
}

class WorkoutRegime {
  const WorkoutRegime({
    required this.id,
    required this.name,
    required this.daysPerWeek,
    required this.workoutIds,
  });

  final String id;
  final String name;
  final int daysPerWeek;
  final List<String> workoutIds;
}
