import 'package:flutter/material.dart';

import 'onboarding_slide_frame.dart';

class FirstOnboardingScreen extends StatelessWidget {
  const FirstOnboardingScreen({
    super.key,
    required this.width,
    required this.height,
    required this.onSkip,
    required this.onNext,
  });

  final double width;
  final double height;
  final VoidCallback onSkip;
  final VoidCallback onNext;

  @override
  Widget build(BuildContext context) => OnboardingSlideFrame(
    title: 'انبارت، همیشه همراهته!',
    description:
        'خرید و فروش دکانت را آسان مدیریت\n'
        'کن و همیشه از موجودی اجناست\n'
        'باخبر باش.',
    illustration: 'assets/ScreenShots/illustrations/f_onbrd_img.svg',
    illustrationWidth: 172,
    illustrationHeight: 217,
    index: 0,
    width: width,
    height: height,
    onBackOrSkip: onSkip,
    onNext: onNext,
    isLastPage: false,
  );
}
