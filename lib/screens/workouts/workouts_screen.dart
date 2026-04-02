import 'package:biomechanical_coach/models/workout_plan.dart';
import 'package:biomechanical_coach/providers/app_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class WorkoutsScreen extends ConsumerWidget {
  const WorkoutsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final workouts = ref.watch(workoutPlansProvider);
    final regimes = ref.watch(workoutRegimesProvider);
    final recommended = ref.watch(recommendedWorkoutsProvider);
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Row(
            children: [
              const Expanded(
                child: Text(
                  'Workouts & Regimes',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              ElevatedButton(
                onPressed: () => context.push('/workouts/create'),
                child: const Text('Create'),
              ),
              const SizedBox(width: 8),
              OutlinedButton(
                onPressed: () => context.push('/workouts/create-regime'),
                child: const Text('Create regime'),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Text('Recommended for your goal'),
          const SizedBox(height: 8),
          ...recommended.map((w) => _WorkoutTile(workout: w, onStart: () => context.push('/workout-session/${w.id}'))),
          const SizedBox(height: 12),
          const Text('Preset workouts'),
          const SizedBox(height: 8),
          ...workouts.where((w) => !w.isCustom).map((w) => _WorkoutTile(workout: w, onStart: () => context.push('/workout-session/${w.id}'))),
          const SizedBox(height: 12),
          const Text('Your custom workouts'),
          const SizedBox(height: 8),
          ...workouts.where((w) => w.isCustom).map((w) => _WorkoutTile(workout: w, onStart: () => context.push('/workout-session/${w.id}'))),
          const SizedBox(height: 12),
          const Text('Regimes'),
          const SizedBox(height: 8),
          ...regimes.map(
            (r) => Card(
              child: ListTile(
                title: Text(r.name),
                subtitle: Text('${r.daysPerWeek} days/week · ${r.workoutIds.join(', ')}'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _WorkoutTile extends StatelessWidget {
  const _WorkoutTile({required this.workout, required this.onStart});
  final WorkoutPlan workout;
  final VoidCallback onStart;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ExpansionTile(
        title: Text(workout.name),
        subtitle: Text(workout.goalTags.join(' • ')),
        children: [
          for (final e in workout.exercises)
            ListTile(
              dense: true,
              title: Text(e.exerciseName),
              trailing: Text('${e.sets} x ${e.reps}'),
            ),
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
              child: ElevatedButton(onPressed: onStart, child: const Text('Start')),
            ),
          ),
        ],
      ),
    );
  }
}
