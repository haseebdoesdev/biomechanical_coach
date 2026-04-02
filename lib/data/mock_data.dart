import 'package:biomechanical_coach/models/coaching_cue.dart';
import 'package:biomechanical_coach/models/exercise.dart';
import 'package:biomechanical_coach/models/session_summary.dart';
import 'package:biomechanical_coach/models/user_profile.dart';
import 'package:biomechanical_coach/models/workout_plan.dart';
import 'package:flutter/material.dart';

const mockUser = UserProfile(
  name: 'Ahmed',
  age: 23,
  heightCm: 175,
  weightKg: 74,
  fitnessLevel: 'Intermediate',
  goals: ['Strength', 'Form'],
  profileImageUrl: null,
);

const categories = ['All', 'Squat', 'Deadlift', 'Press', 'Lunge', 'Pull', 'Core'];

final mockExercises = <Exercise>[
  const Exercise(
    id: 'back_squat',
    name: 'Back squat',
    category: 'Squat',
    muscleGroup: 'Legs',
    difficulty: 'Intermediate',
    description: 'Compound lower-body movement focusing on depth and knee tracking.',
    referenceAngles: {'Knee depth': 90, 'Torso lean': 45},
    imageUrl: 'https://images.unsplash.com/photo-1517838277536-f5f99be501cd?w=600',
    caloriesPerRep: 10,
  ),
  const Exercise(
    id: 'deadlift',
    name: 'Deadlift',
    category: 'Deadlift',
    muscleGroup: 'Posterior chain',
    difficulty: 'Intermediate',
    description: 'Hip hinge dominant lift for glutes, hamstrings, and back.',
    referenceAngles: {'Hip hinge': 70, 'Spine neutral': 0},
    imageUrl: 'https://images.unsplash.com/photo-1599058917765-a780eda07a3e?w=600',
    caloriesPerRep: 11,
  ),
  const Exercise(
    id: 'overhead_press',
    name: 'Overhead press',
    category: 'Press',
    muscleGroup: 'Shoulders',
    difficulty: 'Beginner',
    description: 'Vertical pressing movement emphasizing shoulder alignment.',
    referenceAngles: {'Elbow lockout': 170, 'Shoulder line': 180},
    imageUrl: 'https://images.unsplash.com/photo-1579758629938-03607ccdbaba?w=600',
    caloriesPerRep: 7,
  ),
  ..._generateExercises(
    category: 'Squat',
    prefix: 'Squat',
    muscle: 'Legs',
    caloriesPerRep: 9,
    referenceAngles: {'Knee depth': 90, 'Torso lean': 45},
    count: 8,
  ),
  ..._generateExercises(
    category: 'Deadlift',
    prefix: 'Deadlift',
    muscle: 'Posterior chain',
    caloriesPerRep: 10,
    referenceAngles: {'Hip hinge': 70, 'Spine neutral': 0},
    count: 7,
  ),
  ..._generateExercises(
    category: 'Press',
    prefix: 'Press',
    muscle: 'Shoulders',
    caloriesPerRep: 7,
    referenceAngles: {'Elbow lockout': 170, 'Shoulder line': 180},
    count: 7,
  ),
  ..._generateExercises(
    category: 'Lunge',
    prefix: 'Lunge',
    muscle: 'Legs',
    caloriesPerRep: 8,
    referenceAngles: {'Knee depth': 95, 'Hip control': 60},
    count: 8,
  ),
  ..._generateExercises(
    category: 'Pull',
    prefix: 'Pull',
    muscle: 'Back',
    caloriesPerRep: 6,
    referenceAngles: {'Shoulder alignment': 180, 'Spine neutral': 0},
    count: 8,
  ),
  ..._generateExercises(
    category: 'Core',
    prefix: 'Core',
    muscle: 'Core',
    caloriesPerRep: 5,
    referenceAngles: {'Pelvis control': 0, 'Spine neutral': 0},
    count: 9,
  ),
];

const mockRecentSessions = <SessionSummary>[
  SessionSummary(
    id: 's1',
    exerciseName: 'Back squat',
    formScore: 92,
    reps: 8,
    sets: 3,
    duration: '04:12',
    dateLabel: 'Today',
  ),
  SessionSummary(
    id: 's2',
    exerciseName: 'Deadlift',
    formScore: 78,
    reps: 5,
    sets: 4,
    duration: '03:40',
    dateLabel: 'Yesterday',
  ),
  SessionSummary(
    id: 's3',
    exerciseName: 'Overhead press',
    formScore: 61,
    reps: 10,
    sets: 3,
    duration: '02:55',
    dateLabel: 'Mon',
  ),
];

const mockFeedbackCues = <CoachingCue>[
  CoachingCue(
    title: 'Knee valgus',
    message:
        'Left knee collapsed inward on most reps. Focus on driving knees out over your pinky toe.',
    severity: CueSeverity.high,
  ),
  CoachingCue(
    title: 'Squat depth',
    message: 'Average hip crease is 78deg. Aim for 90deg by controlling your descent.',
    severity: CueSeverity.medium,
  ),
  CoachingCue(
    title: 'Bar path',
    message: 'Bar path is mostly vertical with minimal forward drift.',
    severity: CueSeverity.good,
  ),
];

const chartFormScores = [74.0, 81.0, 79.0, 85.0, 82.0, 88.0, 87.0];
const chartReps = [22.0, 24.0, 18.0, 28.0, 26.0, 32.0, 30.0];

final mockSkeleton = <Offset>[
  const Offset(180, 65),
  const Offset(176, 62),
  const Offset(184, 62),
  const Offset(170, 64),
  const Offset(190, 64),
  const Offset(166, 66),
  const Offset(194, 66),
  const Offset(165, 74),
  const Offset(195, 74),
  const Offset(172, 82),
  const Offset(188, 82),
  const Offset(150, 110),
  const Offset(210, 110),
  const Offset(135, 145),
  const Offset(225, 145),
  const Offset(126, 185),
  const Offset(234, 185),
  const Offset(120, 195),
  const Offset(240, 195),
  const Offset(116, 204),
  const Offset(244, 204),
  const Offset(112, 210),
  const Offset(248, 210),
  const Offset(162, 182),
  const Offset(198, 182),
  const Offset(154, 248),
  const Offset(206, 248),
  const Offset(146, 316),
  const Offset(214, 316),
  const Offset(143, 350),
  const Offset(217, 350),
  const Offset(136, 355),
  const Offset(224, 355),
];

const userGoals = ['Lose weight', 'Gain muscle', 'Both'];

const presetWorkouts = <WorkoutPlan>[
  WorkoutPlan(
    id: 'push_day',
    name: 'Push Day',
    goalTags: ['Gain muscle', 'Both'],
    exercises: [
      WorkoutExerciseConfig(
        exerciseId: 'overhead_press',
        exerciseName: 'Overhead press',
        sets: 4,
        reps: 8,
      ),
      WorkoutExerciseConfig(
        exerciseId: 'back_squat',
        exerciseName: 'Back squat',
        sets: 3,
        reps: 10,
      ),
    ],
  ),
  WorkoutPlan(
    id: 'pull_day',
    name: 'Pull Day',
    goalTags: ['Gain muscle', 'Both'],
    exercises: [
      WorkoutExerciseConfig(
        exerciseId: 'deadlift',
        exerciseName: 'Deadlift',
        sets: 4,
        reps: 5,
      ),
      WorkoutExerciseConfig(
        exerciseId: 'back_squat',
        exerciseName: 'Back squat',
        sets: 3,
        reps: 8,
      ),
    ],
  ),
  WorkoutPlan(
    id: 'legs_day',
    name: 'Leg Day',
    goalTags: ['Lose weight', 'Both', 'Gain muscle'],
    exercises: [
      WorkoutExerciseConfig(
        exerciseId: 'back_squat',
        exerciseName: 'Back squat',
        sets: 4,
        reps: 10,
      ),
      WorkoutExerciseConfig(
        exerciseId: 'deadlift',
        exerciseName: 'Deadlift',
        sets: 3,
        reps: 6,
      ),
    ],
  ),
];

const presetRegimes = <WorkoutRegime>[
  WorkoutRegime(
    id: 'ppl_6',
    name: 'Push Pull Legs',
    daysPerWeek: 6,
    workoutIds: ['push_day', 'pull_day', 'legs_day'],
  ),
  WorkoutRegime(
    id: 'recomp_4',
    name: 'Body Recomp 4-Day',
    daysPerWeek: 4,
    workoutIds: ['push_day', 'pull_day', 'legs_day'],
  ),
];

final mockExerciseSessionStats = <String, Map<String, dynamic>>{
  for (var i = 0; i < mockExercises.length; i++)
    mockExercises[i].id: {
      'formScore': 70 + (i % 26),
      'correctReps': 8 + (i % 10),
      'totalReps': 12 + (i % 14),
      'sets': 3 + (i % 3),
      'duration': '0${3 + (i % 4)}:${(12 + i) % 60}'.padLeft(2, '0'),
    },
};

const _genericCuePool = <CoachingCue>[
  CoachingCue(
    title: 'Joint alignment',
    message: 'Alignment drifted on some reps. Slow the eccentric phase.',
    severity: CueSeverity.medium,
  ),
  CoachingCue(
    title: 'Range of motion',
    message: 'Depth consistency can improve in the final reps.',
    severity: CueSeverity.medium,
  ),
  CoachingCue(
    title: 'Control',
    message: 'Good rep tempo and solid posture in most sets.',
    severity: CueSeverity.good,
  ),
];

final mockFeedbackCuesByExercise = <String, List<CoachingCue>>{
  for (var i = 0; i < mockExercises.length; i++)
    mockExercises[i].id: [
      if (i % 4 == 0)
        const CoachingCue(
          title: 'Stability',
          message: 'Knee and trunk stability dropped under fatigue.',
          severity: CueSeverity.high,
        ),
      _genericCuePool[i % _genericCuePool.length],
      _genericCuePool[(i + 1) % _genericCuePool.length],
    ],
};

final seededCalorieLog = <String, int>{
  for (var i = 0; i < 30; i++)
    DateTime.now()
        .subtract(Duration(days: 29 - i))
        .toIso8601String()
        .split('T')
        .first: (i % 5) * 45 + (i % 3) * 20,
};

List<Exercise> _generateExercises({
  required String category,
  required String prefix,
  required String muscle,
  required int caloriesPerRep,
  required Map<String, int> referenceAngles,
  required int count,
}) {
  return List<Exercise>.generate(count, (index) {
    final n = index + 1;
    return Exercise(
      id: '${category.toLowerCase()}_$n',
      name: '$prefix Exercise $n',
      category: category,
      muscleGroup: muscle,
      difficulty: n % 3 == 0 ? 'Advanced' : (n % 2 == 0 ? 'Intermediate' : 'Beginner'),
      description: '$prefix focused movement for consistent technique and control.',
      referenceAngles: referenceAngles,
      imageUrl: 'https://images.unsplash.com/photo-1517838277536-f5f99be501cd?w=600',
      caloriesPerRep: caloriesPerRep + (n % 3),
    );
  });
}
