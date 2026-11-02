import 'package:flutter/material.dart';

import 'onboarding_slide_frame.dart';

class SecondOnboardingScreen extends StatelessWidget {
  const SecondOnboardingScreen({
    super.key,
    required this.width,
    required this.height,
    required this.onBack,
    required this.onNext,
  });

  final double width;
  final double height;
  final VoidCallback onBack;
  final VoidCallback onNext;

  @override
  Widget build(BuildContext context) => OnboardingSlideFrame(
    title: 'سود و ضررت را آسان بفهم!',
    description:
        'گدام خودش حساب‌وکتاب می‌کند تا\n'
        'بدانی چقدر سود کردی و چقدر مصرف\n'
        'داشتی.',
    illustration: 'assets/ScreenShots/illustrations/s_onbrd_img.svg',
    illustrationWidth: 172,
    illustrationHeight: 181,
    index: 1,
    width: width,
    height: height,
    onBackOrSkip: onBack,
    onNext: onNext,
    isLastPage: false,
  );
}
