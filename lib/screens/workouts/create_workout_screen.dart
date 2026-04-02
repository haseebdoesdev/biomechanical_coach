import 'package:biomechanical_coach/data/mock_data.dart';
import 'package:biomechanical_coach/models/workout_plan.dart';
import 'package:biomechanical_coach/providers/app_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class CreateWorkoutScreen extends ConsumerStatefulWidget {
  const CreateWorkoutScreen({super.key});

  @override
  ConsumerState<CreateWorkoutScreen> createState() => _CreateWorkoutScreenState();
}

class _CreateWorkoutScreenState extends ConsumerState<CreateWorkoutScreen> {
  final nameController = TextEditingController();
  String selectedGoal = userGoals.first;
  final items = <WorkoutExerciseConfig>[];
  String selectedExerciseId = mockExercises.first.id;
  int sets = 3;
  int reps = 10;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create workout')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          TextField(
            controller: nameController,
            decoration: const InputDecoration(labelText: 'Workout name'),
          ),
          const SizedBox(height: 12),
          DropdownButtonFormField<String>(
            initialValue: selectedGoal,
            decoration: const InputDecoration(labelText: 'Goal'),
            items: userGoals.map((g) => DropdownMenuItem(value: g, child: Text(g))).toList(),
            onChanged: (v) => setState(() => selectedGoal = v!),
          ),
          const SizedBox(height: 12),
          DropdownButtonFormField<String>(
            initialValue: selectedExerciseId,
            decoration: const InputDecoration(labelText: 'Exercise'),
            items: mockExercises
                .map((e) => DropdownMenuItem(value: e.id, child: Text(e.name)))
                .toList(),
            onChanged: (v) => setState(() => selectedExerciseId = v!),
          ),
          const SizedBox(height: 10),
          Text('Sets: $sets'),
          Slider(
            value: sets.toDouble(),
            min: 1,
            max: 6,
            divisions: 5,
            onChanged: (v) => setState(() => sets = v.round()),
          ),
          Text('Reps: $reps'),
          Slider(
            value: reps.toDouble(),
            min: 4,
            max: 20,
            divisions: 16,
            onChanged: (v) => setState(() => reps = v.round()),
          ),
          ElevatedButton(
            onPressed: () {
              final ex = mockExercises.firstWhere((e) => e.id == selectedExerciseId);
              setState(() {
                items.add(
                  WorkoutExerciseConfig(
                    exerciseId: ex.id,
                    exerciseName: ex.name,
                    sets: sets,
                    reps: reps,
                  ),
                );
              });
            },
            child: const Text('Add exercise'),
          ),
          const SizedBox(height: 10),
          ...items.map((e) => ListTile(title: Text(e.exerciseName), trailing: Text('${e.sets} x ${e.reps}'))),
          const SizedBox(height: 14),
          ElevatedButton(
            onPressed: () {
              if (nameController.text.isEmpty || items.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Add name and exercises')),
                );
                return;
              }
              ref.read(workoutPlansProvider.notifier).addCustomWorkout(
                    WorkoutPlan(
                      id: 'custom_${DateTime.now().millisecondsSinceEpoch}',
                      name: nameController.text,
                      goalTags: [selectedGoal],
                      exercises: [...items],
                      isCustom: true,
                    ),
                  );
              context.pop();
            },
            child: const Text('Save workout'),
          ),
        ],
      ),
    );
  }
}
