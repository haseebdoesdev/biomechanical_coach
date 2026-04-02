import 'package:biomechanical_coach/models/workout_plan.dart';
import 'package:biomechanical_coach/providers/app_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class CreateRegimeScreen extends ConsumerStatefulWidget {
  const CreateRegimeScreen({super.key});

  @override
  ConsumerState<CreateRegimeScreen> createState() => _CreateRegimeScreenState();
}

class _CreateRegimeScreenState extends ConsumerState<CreateRegimeScreen> {
  final nameController = TextEditingController();
  double daysPerWeek = 4;
  final selectedWorkoutIds = <String>{};

  @override
  Widget build(BuildContext context) {
    final workouts = ref.watch(workoutPlansProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Create regime')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          TextField(
            controller: nameController,
            decoration: const InputDecoration(labelText: 'Regime name'),
          ),
          const SizedBox(height: 14),
          Text('Days per week: ${daysPerWeek.round()}'),
          Slider(
            value: daysPerWeek,
            min: 2,
            max: 7,
            divisions: 5,
            onChanged: (value) => setState(() => daysPerWeek = value),
          ),
          const SizedBox(height: 6),
          const Text('Select workouts'),
          const SizedBox(height: 8),
          for (final workout in workouts)
            CheckboxListTile(
              value: selectedWorkoutIds.contains(workout.id),
              title: Text(workout.name),
              subtitle: Text('${workout.exercises.length} exercises'),
              onChanged: (checked) {
                setState(() {
                  if (checked == true) {
                    selectedWorkoutIds.add(workout.id);
                  } else {
                    selectedWorkoutIds.remove(workout.id);
                  }
                });
              },
            ),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: () {
              if (nameController.text.trim().isEmpty || selectedWorkoutIds.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Add name and at least one workout')),
                );
                return;
              }
              ref.read(workoutRegimesProvider.notifier).addRegime(
                    WorkoutRegime(
                      id: 'reg_${DateTime.now().millisecondsSinceEpoch}',
                      name: nameController.text.trim(),
                      daysPerWeek: daysPerWeek.round(),
                      workoutIds: selectedWorkoutIds.toList(),
                    ),
                  );
              context.pop();
            },
            child: const Text('Save regime'),
          ),
        ],
      ),
    );
  }
}
