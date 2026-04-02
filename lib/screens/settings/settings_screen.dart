import 'package:biomechanical_coach/providers/app_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(userProfileProvider);
    final mode = ref.watch(themeModeProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          ListTile(title: const Text('Name'), subtitle: Text(profile.name)),
          ListTile(title: const Text('Fitness level'), subtitle: Text(profile.fitnessLevel)),
          SwitchListTile(value: true, onChanged: (_) {}, title: const Text('Push notifications')),
          SwitchListTile(
            value: mode == ThemeMode.dark,
            onChanged: (v) => ref.read(themeModeProvider.notifier).state = v ? ThemeMode.dark : ThemeMode.light,
            title: const Text('Dark mode'),
          ),
          const ListTile(title: Text('Version'), subtitle: Text('1.0.0-midterm')),
        ],
      ),
    );
  }
}
