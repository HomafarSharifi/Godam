import 'package:flutter/material.dart';

import 'onboarding_slide_frame.dart';

class ThirdOnboardingScreen extends StatelessWidget {
  const ThirdOnboardingScreen({
    super.key,
    required this.width,
    required this.height,
    required this.onBack,
    required this.onFinish,
  });

  final double width;
  final double height;
  final VoidCallback onBack;
  final VoidCallback onFinish;

  @override
  Widget build(BuildContext context) => OnboardingSlideFrame(
    title: 'حساب‌وکتاب، بدون دردسر!',
    description:
        'دیگر وقتت را با حساب‌وکتاب پیچیده\n'
        'ضایع نکن؛ گدام همه چیز را برایت\n'
        'ساده می‌سازد.',
    illustration: 'assets/ScreenShots/illustrations/t_onbrd_img.svg',
    illustrationWidth: 170,
    illustrationHeight: 193,
    index: 2,
    width: width,
    height: height,
    onBackOrSkip: onBack,
    onNext: onFinish,
    isLastPage: true,
  );
}
