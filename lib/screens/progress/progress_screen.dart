import 'package:biomechanical_coach/data/mock_data.dart';
import 'package:biomechanical_coach/models/user_profile.dart';
import 'package:biomechanical_coach/providers/app_providers.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ProgressScreen extends ConsumerStatefulWidget {
  const ProgressScreen({super.key});

  @override
  ConsumerState<ProgressScreen> createState() => _ProgressScreenState();
}

class _ProgressScreenState extends ConsumerState<ProgressScreen> {
  Future<void> _editProfile(UserProfile profile) async {
    final name = TextEditingController(text: profile.name);
    double weight = profile.weightKg.toDouble();
    double height = profile.heightCm.toDouble();

    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (ctx) {
        return StatefulBuilder(
          builder: (ctx, setModalState) {
            return Padding(
              padding: EdgeInsets.only(
                left: 16,
                right: 16,
                top: 8,
                bottom: MediaQuery.of(ctx).viewInsets.bottom + 20,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Edit profile', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
                  const SizedBox(height: 12),
                  TextField(controller: name, decoration: const InputDecoration(labelText: 'Name')),
                  const SizedBox(height: 10),
                  Text('Weight: ${weight.round()} kg'),
                  Slider(
                    value: weight,
                    min: 40,
                    max: 150,
                    onChanged: (v) => setModalState(() => weight = v),
                  ),
                  Text('Height: ${height.round()} cm'),
                  Slider(
                    value: height,
                    min: 140,
                    max: 210,
                    onChanged: (v) => setModalState(() => height = v),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        ref.read(userProfileProvider.notifier).update(
                              profile.copyWith(
                                name: name.text.trim(),
                                weightKg: weight.round(),
                                heightCm: height.round(),
                              ),
                            );
                        Navigator.pop(ctx);
                      },
                      child: const Text('Save changes'),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final profile = ref.watch(userProfileProvider);
    final totalCalories = ref.watch(totalCaloriesProvider);
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 26,
                        backgroundImage:
                            profile.profileImageUrl != null ? NetworkImage(profile.profileImageUrl!) : null,
                        child: profile.profileImageUrl == null ? const Icon(Icons.person) : null,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(profile.name, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                            Text(profile.fitnessLevel),
                          ],
                        ),
                      ),
                      TextButton(
                        onPressed: () => _editProfile(profile),
                        child: const Text('Edit profile'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _MetricCard(label: 'Weight', value: '${profile.weightKg}kg'),
                      _MetricCard(label: 'Height', value: '${profile.heightCm}cm'),
                      _MetricCard(label: 'Calories', value: '$totalCalories'),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          const Text('Progress', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _MetricCard(label: 'Sessions', value: '24'),
              _MetricCard(label: 'Avg score', value: '84%'),
              _MetricCard(label: 'Total reps', value: '680'),
            ],
          ),
          const SizedBox(height: 16),
          const Text('Form score trend'),
          SizedBox(
            height: 180,
            child: LineChart(
              LineChartData(
                borderData: FlBorderData(show: false),
                titlesData: const FlTitlesData(show: false),
                lineBarsData: [
                  LineChartBarData(
                    spots: [
                      for (var i = 0; i < chartFormScores.length; i++) FlSpot(i.toDouble(), chartFormScores[i]),
                    ],
                    isCurved: true,
                    barWidth: 3,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          const Text('Reps per session'),
          SizedBox(
            height: 180,
            child: BarChart(
              BarChartData(
                borderData: FlBorderData(show: false),
                titlesData: const FlTitlesData(show: false),
                barGroups: [
                  for (var i = 0; i < chartReps.length; i++) BarChartGroupData(x: i, barRods: [BarChartRodData(toY: chartReps[i])]),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          const Text('Session history'),
          for (final s in mockRecentSessions)
            Card(
              child: ListTile(
                onTap: () => context.push('/feedback/${s.id}'),
                title: Text(s.exerciseName),
                subtitle: Text(s.dateLabel),
                trailing: Text('${s.formScore}%'),
              ),
            ),
        ],
      ),
    );
  }
}

class _MetricCard extends StatelessWidget {
  const _MetricCard({required this.label, required this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 110,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          child: Column(
            children: [
              Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
              Text(label),
            ],
          ),
        ),
      ),
    );
  }
}
