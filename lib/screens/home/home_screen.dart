import 'package:biomechanical_coach/core/theme/app_theme.dart';
import 'package:biomechanical_coach/data/mock_data.dart';
import 'package:biomechanical_coach/providers/app_providers.dart';
import 'package:biomechanical_coach/widgets/calendar_heatmap.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  Future<void> _openWorkoutPicker(BuildContext context, WidgetRef ref) async {
    final workouts = ref.read(workoutPlansProvider);
    await showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (ctx) {
        return SafeArea(
          child: ListView(
            shrinkWrap: true,
            children: [
              const ListTile(
                title: Text(
                  'Select workout',
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
              ),
              for (final workout in workouts)
                ListTile(
                  title: Text(workout.name),
                  subtitle: Text('${workout.exercises.length} exercises'),
                  onTap: () {
                    Navigator.of(ctx).pop();
                    context.push('/workout-session/${workout.id}');
                  },
                ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProfileProvider);
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Row(
            children: [
              Expanded(
                child: Text('Good morning\n${user.name}', style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
              ),
              const CircleAvatar(radius: 20, child: Icon(Icons.person_outline)),
            ],
          ),
          const SizedBox(height: 14),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(16)),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _StatItem(title: 'sessions', value: '3'),
                _StatItem(title: 'form score', value: '87%'),
                _StatItem(title: 'reps', value: '42'),
              ],
            ),
          ),
          const SizedBox(height: 16),
          CalendarHeatmap(log: ref.watch(calorieLogProvider)),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () => _openWorkoutPicker(context, ref),
            child: const Text('Start workout'),
          ),
          TextButton(
            onPressed: () => context.go('/workouts'),
            child: const Text('See recommended workouts'),
          ),
          const SizedBox(height: 16),
          const Text('Recent exercises', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
          const SizedBox(height: 10),
          for (final s in mockRecentSessions)
            Card(
              child: ListTile(
                onTap: () => context.push('/feedback/${s.id}'),
                title: Text(s.exerciseName),
                subtitle: Text('${s.sets} sets · ${s.reps} reps'),
                trailing: Text('${s.formScore}%'),
              ),
            ),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  const _StatItem({required this.title, required this.value});
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w700)),
        Text(title, style: const TextStyle(color: AppColors.textSecondary)),
      ],
    );
  }
}
