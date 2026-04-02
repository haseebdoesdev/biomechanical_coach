import 'package:biomechanical_coach/core/router/app_router.dart';
import 'package:biomechanical_coach/core/theme/app_theme.dart';
import 'package:biomechanical_coach/providers/app_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BiomechanicalCoachApp extends ConsumerWidget {
  const BiomechanicalCoachApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mode = ref.watch(themeModeProvider);
    return MaterialApp.router(
      title: 'Biomechanical Coach',
      theme: ThemeData.light(),
      darkTheme: AppTheme.dark(),
      themeMode: mode,
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
    );
  }
}
