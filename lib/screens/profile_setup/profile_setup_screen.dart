import 'package:biomechanical_coach/models/user_profile.dart';
import 'package:biomechanical_coach/data/mock_data.dart';
import 'package:biomechanical_coach/providers/app_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ProfileSetupScreen extends ConsumerStatefulWidget {
  const ProfileSetupScreen({super.key});

  @override
  ConsumerState<ProfileSetupScreen> createState() => _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends ConsumerState<ProfileSetupScreen> {
  final name = TextEditingController(text: 'Ahmed');
  double age = 23;
  double height = 175;
  double weight = 74;
  String fitness = 'Intermediate';
  final goals = <String>{'Strength'};
  String primaryGoal = 'Gain muscle';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile setup')),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          TextField(controller: name, decoration: const InputDecoration(labelText: 'Name')),
          const SizedBox(height: 10),
          Text('Age: ${age.round()}'),
          Slider(value: age, min: 16, max: 60, onChanged: (v) => setState(() => age = v)),
          Text('Height: ${height.round()} cm'),
          Slider(value: height, min: 140, max: 210, onChanged: (v) => setState(() => height = v)),
          Text('Weight: ${weight.round()} kg'),
          Slider(value: weight, min: 40, max: 150, onChanged: (v) => setState(() => weight = v)),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            children: ['Beginner', 'Intermediate', 'Advanced']
                .map((e) => ChoiceChip(label: Text(e), selected: fitness == e, onSelected: (_) => setState(() => fitness = e)))
                .toList(),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            children: ['Strength', 'Flexibility', 'Rehab', 'General fitness']
                .map((e) => FilterChip(
                      label: Text(e),
                      selected: goals.contains(e),
                      onSelected: (selected) => setState(() => selected ? goals.add(e) : goals.remove(e)),
                    ))
                .toList(),
          ),
          const SizedBox(height: 14),
          const Text('Primary goal'),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: userGoals
                .map(
                  (g) => ChoiceChip(
                    label: Text(g),
                    selected: primaryGoal == g,
                    onSelected: (_) => setState(() => primaryGoal = g),
                  ),
                )
                .toList(),
          ),
          const SizedBox(height: 18),
          ElevatedButton(
            onPressed: () {
              ref.read(selectedPrimaryGoalProvider.notifier).state = primaryGoal;
              ref
                  .read(userProfileProvider.notifier)
                  .update(
                    UserProfile(
                      name: name.text,
                      age: age.round(),
                      heightCm: height.round(),
                      weightKg: weight.round(),
                      fitnessLevel: fitness,
                      goals: goals.toList(),
                    ),
                  );
              context.go('/workouts');
            },
            child: const Text('Continue'),
          ),
        ],
      ),
    );
  }
}
