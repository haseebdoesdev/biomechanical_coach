import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final controller = PageController();
  int index = 0;

  static const pages = [
    ('Track your form', 'See every rep with clear visual feedback.'),
    ('AI coaching cues', 'Get contextual tips in the moment.'),
    ('Improve over time', 'Follow your trend charts session by session.'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const Spacer(),
            SizedBox(
              height: 300,
              child: PageView.builder(
                controller: controller,
                itemCount: pages.length,
                onPageChanged: (value) => setState(() => index = value),
                itemBuilder: (_, i) => Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.fitness_center, size: 72, color: Colors.deepPurple.shade200),
                    const SizedBox(height: 18),
                    Text(pages[i].$1, style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w700)),
                    const SizedBox(height: 10),
                    Text(pages[i].$2, textAlign: TextAlign.center),
                  ],
                ),
              ),
            ),
            SmoothPageIndicator(
              controller: controller,
              count: pages.length,
              effect: const WormEffect(dotHeight: 9, dotWidth: 9),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => index == 2 ? context.go('/login') : controller.nextPage(duration: const Duration(milliseconds: 240), curve: Curves.easeOut),
                child: Text(index == 2 ? 'Get started' : 'Next'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
