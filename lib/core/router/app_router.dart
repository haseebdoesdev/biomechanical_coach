import 'package:biomechanical_coach/screens/auth/forgot_password_screen.dart';
import 'package:biomechanical_coach/screens/auth/login_screen.dart';
import 'package:biomechanical_coach/screens/auth/signup_screen.dart';
import 'package:biomechanical_coach/screens/exercise_library/exercise_detail_screen.dart';
import 'package:biomechanical_coach/screens/exercise_library/exercise_library_screen.dart';
import 'package:biomechanical_coach/screens/feedback/feedback_screen.dart';
import 'package:biomechanical_coach/screens/feedback/workout_feedback_screen.dart';
import 'package:biomechanical_coach/screens/home/home_screen.dart';
import 'package:biomechanical_coach/screens/onboarding/onboarding_screen.dart';
import 'package:biomechanical_coach/screens/profile_setup/profile_setup_screen.dart';
import 'package:biomechanical_coach/screens/progress/progress_screen.dart';
import 'package:biomechanical_coach/screens/session/session_screen.dart';
import 'package:biomechanical_coach/screens/settings/settings_screen.dart';
import 'package:biomechanical_coach/screens/splash/splash_screen.dart';
import 'package:biomechanical_coach/screens/workouts/create_workout_screen.dart';
import 'package:biomechanical_coach/screens/workouts/create_regime_screen.dart';
import 'package:biomechanical_coach/screens/workouts/workouts_screen.dart';
import 'package:biomechanical_coach/screens/session/workout_session_screen.dart';
import 'package:biomechanical_coach/shell/app_shell.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  initialLocation: '/splash',
  routes: [
    GoRoute(path: '/splash', builder: (_, __) => const SplashScreen()),
    GoRoute(path: '/onboarding', builder: (_, __) => const OnboardingScreen()),
    GoRoute(path: '/login', builder: (_, __) => const LoginScreen()),
    GoRoute(path: '/signup', builder: (_, __) => const SignupScreen()),
    GoRoute(path: '/forgot-password', builder: (_, __) => const ForgotPasswordScreen()),
    GoRoute(path: '/profile-setup', builder: (_, __) => const ProfileSetupScreen()),
    ShellRoute(
      builder: (_, __, child) => AppShell(child: child),
      routes: [
        GoRoute(path: '/home', builder: (_, __) => const HomeScreen()),
        GoRoute(path: '/library', builder: (_, __) => const ExerciseLibraryScreen()),
        GoRoute(path: '/workouts', builder: (_, __) => const WorkoutsScreen()),
        GoRoute(path: '/progress', builder: (_, __) => const ProgressScreen()),
      ],
    ),
    GoRoute(path: '/workouts/create', builder: (_, __) => const CreateWorkoutScreen()),
    GoRoute(path: '/workouts/create-regime', builder: (_, __) => const CreateRegimeScreen()),
    GoRoute(
      path: '/library/:id',
      builder: (_, state) => ExerciseDetailScreen(exerciseId: state.pathParameters['id']!),
    ),
    GoRoute(
      path: '/session/:exerciseId',
      builder: (_, state) => SessionScreen(exerciseId: state.pathParameters['exerciseId']!),
    ),
    GoRoute(
      path: '/workout-session/:workoutId',
      builder: (_, state) => WorkoutSessionScreen(workoutId: state.pathParameters['workoutId']!),
    ),
    GoRoute(
      path: '/feedback/:sessionId',
      builder: (_, state) => FeedbackScreen(sessionId: state.pathParameters['sessionId']!),
    ),
    GoRoute(
      path: '/workout-feedback/:workoutId',
      builder: (_, state) => WorkoutFeedbackScreen(workoutId: state.pathParameters['workoutId']!),
    ),
    GoRoute(path: '/settings', builder: (_, __) => const SettingsScreen()),
  ],
);
