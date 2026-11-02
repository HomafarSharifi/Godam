import 'package:flutter/material.dart';

import 'screens/onboarding_screen.dart';
import 'screens/registration_screen.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, this.startupLoading});

  final Future<void>? startupLoading;

  @override
  Widget build(BuildContext context) {
    const primary = Color(0xFF008081);
    const background = Color(0xFFFBFAF6);

    return MaterialApp(
      title: 'Godam',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: primary),
        scaffoldBackgroundColor: background,
        useMaterial3: true,
      ),
      home: SplashScreen(dataLoading: startupLoading),
      routes: {
        OnboardingScreen.routeName: (_) => const OnboardingScreen(),
        RegistrationScreen.routeName: (_) => const RegistrationScreen(),
      },
    );
  }
}
