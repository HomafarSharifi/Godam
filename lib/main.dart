import 'package:flutter/material.dart';
import 'package:godam/screens/home_screen.dart';
import 'package:godam/screens/onboarding_screen.dart';
import 'package:godam/screens/registration_screen.dart';
import 'package:godam/screens/splash_screen.dart';

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
      initialRoute: SplashScreen.routeName,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: primary),
        scaffoldBackgroundColor: background,
        useMaterial3: true,
      ),
      routes: {
        SplashScreen.routeName: (_) =>
            SplashScreen(dataLoading: startupLoading),
        OnboardingScreen.routeName: (_) => const OnboardingScreen(),
        RegistrationScreen.routeName: (_) => const RegistrationScreen(),
        HomeScreen.routeName: (_) => const HomeScreen(),
      },
    );
  }
}
