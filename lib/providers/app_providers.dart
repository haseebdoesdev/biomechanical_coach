import 'package:biomechanical_coach/data/mock_data.dart';
import 'package:biomechanical_coach/models/exercise.dart';
import 'package:biomechanical_coach/models/user_profile.dart';
import 'package:biomechanical_coach/models/workout_plan.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserProfileNotifier extends StateNotifier<UserProfile> {
  UserProfileNotifier() : super(mockUser);

  void update(UserProfile profile) {
    state = profile;
  }
}

class SessionState {
  const SessionState({
    this.timerLabel = '00:32',
    this.reps = 6,
    this.sets = 3,
    this.formScore = 78,
    this.depthAngle = 78,
    this.leftKneeAngle = 78,
    this.rightKneeAngle = 82,
  });

  final String timerLabel;
  final int reps;
  final int sets;
  final int formScore;
  final int depthAngle;
  final int leftKneeAngle;
  final int rightKneeAngle;
}

final userProfileProvider =
    StateNotifierProvider<UserProfileNotifier, UserProfile>((ref) {
      return UserProfileNotifier();
    });

final themeModeProvider = StateProvider<ThemeMode>((ref) => ThemeMode.dark);
final searchQueryProvider = StateProvider<String>((ref) => '');
final selectedCategoryProvider = StateProvider<String>((ref) => 'All');
final selectedExerciseIdProvider = StateProvider<String?>((ref) => null);
final sessionStateProvider = StateProvider<SessionState>((ref) => const SessionState());
final selectedPrimaryGoalProvider = StateProvider<String>((ref) => 'Gain muscle');

class WorkoutPlansNotifier extends StateNotifier<List<WorkoutPlan>> {
  WorkoutPlansNotifier() : super(presetWorkouts);

  void addCustomWorkout(WorkoutPlan workout) {
    state = [...state, workout];
  }
}

class WorkoutRegimesNotifier extends StateNotifier<List<WorkoutRegime>> {
  WorkoutRegimesNotifier() : super(presetRegimes);

  void addRegime(WorkoutRegime regime) {
    state = [...state, regime];
  }
}

class CalorieLogNotifier extends StateNotifier<Map<String, int>> {
  CalorieLogNotifier() : super({...seededCalorieLog});

  void addCaloriesForToday(int calories) {
    final key = DateTime.now().toIso8601String().split('T').first;
    state = {
      ...state,
      key: (state[key] ?? 0) + calories,
    };
  }
}

final workoutPlansProvider =
    StateNotifierProvider<WorkoutPlansNotifier, List<WorkoutPlan>>((ref) {
      return WorkoutPlansNotifier();
    });

final workoutRegimesProvider =
    StateNotifierProvider<WorkoutRegimesNotifier, List<WorkoutRegime>>((ref) {
  return WorkoutRegimesNotifier();
});

final recommendedWorkoutsProvider = Provider<List<WorkoutPlan>>((ref) {
  final goal = ref.watch(selectedPrimaryGoalProvider);
  return ref.watch(workoutPlansProvider).where((w) => w.goalTags.contains(goal)).toList();
});

final calorieLogProvider =
    StateNotifierProvider<CalorieLogNotifier, Map<String, int>>((ref) {
  return CalorieLogNotifier();
});

final totalCaloriesProvider = Provider<int>((ref) {
  return ref.watch(calorieLogProvider).values.fold(0, (a, b) => a + b);
});

final exercisesProvider = Provider<List<Exercise>>((ref) {
  final query = ref.watch(searchQueryProvider).toLowerCase().trim();
  final category = ref.watch(selectedCategoryProvider);
  return mockExercises.where((exercise) {
    final matchesCategory = category == 'All' || exercise.category == category;
    final matchesQuery =
        query.isEmpty ||
        exercise.name.toLowerCase().contains(query) ||
        exercise.muscleGroup.toLowerCase().contains(query);
    return matchesCategory && matchesQuery;
  }).toList();
});
