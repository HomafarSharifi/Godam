import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../widgets/onboarding_frame_background.dart';
import 'onboarding/first_onboarding_screen.dart';
import 'onboarding/second_onboarding_screen.dart';
import 'onboarding/third_onboarding_screen.dart';
import 'registration_screen.dart';

const _onboardingSlideCount = 3;

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  static const routeName = '/onboarding';
  static const designFrameKey = ValueKey('onboarding-responsive-frame');
  static const pageViewKey = ValueKey('onboarding-page-view');
  static const pageStatusKey = ValueKey('onboarding-page-status');
  static const illustrationKey = ValueKey('onboarding-illustration');
  static const finishButtonKey = ValueKey('onboarding-finish-button');

  static ValueKey<String> skipButtonKeyFor(int index) =>
      ValueKey('onboarding-skip-button-$index');
  static ValueKey<String> backButtonKeyFor(int index) =>
      ValueKey('onboarding-back-button-$index');
  static ValueKey<String> nextButtonKeyFor(int index) =>
      ValueKey('onboarding-next-button-$index');

  static const _background = Color(0xFFFBFAF6);
  static const _systemUiStyle = SystemUiOverlayStyle(
    statusBarColor: _background,
    statusBarIconBrightness: Brightness.dark,
    statusBarBrightness: Brightness.light,
    systemNavigationBarColor: _background,
    systemNavigationBarIconBrightness: Brightness.dark,
    systemNavigationBarDividerColor: _background,
  );

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late final PageController _pageController;
  int _currentPage = 0;
  bool _registrationOpening = false;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int page) {
    if (page == _currentPage) return;
    setState(() => _currentPage = page);
  }

  void _skipOrGoBack() {
    if (_currentPage > 0) {
      _setPage(_currentPage - 1);
      return;
    }
    _openRegistration();
  }

  void _goForward() {
    if (_currentPage < _onboardingSlideCount - 1) {
      _setPage(_currentPage + 1);
      return;
    }
    _openRegistration();
  }

  void _setPage(int page) {
    _pageController.jumpToPage(page);
    _onPageChanged(page);
  }

  void _openRegistration() {
    if (_registrationOpening) return;
    _registrationOpening = true;
    Navigator.of(context)
        .pushNamed(RegistrationScreen.routeName)
        .whenComplete(() {
          if (mounted) _registrationOpening = false;
        });
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: OnboardingScreen._systemUiStyle,
      child: Scaffold(
        backgroundColor: OnboardingScreen._background,
        body: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) => Stack(
              key: OnboardingScreen.designFrameKey,
              fit: StackFit.expand,
              children: [
                const OnboardingFrameBackground(),
                Semantics(
                  key: OnboardingScreen.pageStatusKey,
                  liveRegion: true,
                  label:
                      'Onboarding page ${_currentPage + 1} of $_onboardingSlideCount',
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: PageView(
                      key: OnboardingScreen.pageViewKey,
                      controller: _pageController,
                      onPageChanged: _onPageChanged,
                      children: [
                        FirstOnboardingScreen(
                          width: constraints.maxWidth,
                          height: constraints.maxHeight,
                          onSkip: _skipOrGoBack,
                          onNext: _goForward,
                        ),
                        SecondOnboardingScreen(
                          width: constraints.maxWidth,
                          height: constraints.maxHeight,
                          onBack: _skipOrGoBack,
                          onNext: _goForward,
                        ),
                        ThirdOnboardingScreen(
                          width: constraints.maxWidth,
                          height: constraints.maxHeight,
                          onBack: _skipOrGoBack,
                          onFinish: _goForward,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
