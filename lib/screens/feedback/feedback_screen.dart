import 'package:biomechanical_coach/data/mock_data.dart';
import 'package:biomechanical_coach/widgets/coaching_cue_card.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class FeedbackScreen extends StatelessWidget {
  const FeedbackScreen({required this.sessionId, super.key});

  final String sessionId;

  @override
  Widget build(BuildContext context) {
    final session = mockRecentSessions.firstWhere((s) => s.id == sessionId, orElse: () => mockRecentSessions.first);
    final exercise = mockExercises.firstWhere(
      (e) => e.name.toLowerCase() == session.exerciseName.toLowerCase(),
      orElse: () => mockExercises.first,
    );
    return Scaffold(
      appBar: AppBar(title: const Text('Session complete')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text('${session.exerciseName} analysis', style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          LinearProgressIndicator(value: session.formScore / 100),
          const SizedBox(height: 6),
          Text('Overall form score ${session.formScore}%'),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _Stat(title: 'reps', value: '${session.reps}'),
              _Stat(title: 'sets', value: '${session.sets}'),
              _Stat(title: 'duration', value: session.duration),
            ],
          ),
          const SizedBox(height: 16),
          const Text('AI COACHING NOTES', style: TextStyle(fontWeight: FontWeight.w700)),
          const SizedBox(height: 10),
          for (final cue in mockFeedbackCues) CoachingCueCard(cue: cue),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => context.push('/library/${exercise.id}'),
                  child: const Text('Fix this'),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: OutlinedButton(
                  onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Session saved (mock)')),
                  ),
                  child: const Text('Save session'),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: ElevatedButton(
                  onPressed: () => context.go('/library'),
                  child: const Text('Finish'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  const _Stat({required this.title, required this.value});
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w700)),
        Text(title),
      ],
    );
  }
}
