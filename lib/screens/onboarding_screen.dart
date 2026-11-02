import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../widgets/onboarding_frame_background.dart';
import 'registration_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  static const routeName = '/onboarding';
  static const designFrameKey = ValueKey('onboarding-responsive-frame');
  static const pageViewKey = ValueKey('onboarding-page-view');
  static const illustrationKey = ValueKey('onboarding-illustration');
  static const finishButtonKey = ValueKey('onboarding-finish-button');

  static ValueKey<String> skipButtonKeyFor(int index) =>
      ValueKey('onboarding-skip-button-$index');
  static ValueKey<String> backButtonKeyFor(int index) =>
      ValueKey('onboarding-back-button-$index');
  static ValueKey<String> nextButtonKeyFor(int index) =>
      ValueKey('onboarding-next-button-$index');

  static const _background = Color(0xFFFBFAF6);
  static const _teal = Color(0xFF008081);
  static const _mutedTeal = Color(0xFF99D6D6);
  static const _arrowTint = Color(0xB399D6D6);

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
    if (_currentPage < _onboardingSlides.length - 1) {
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
                OnboardingFrameBackground(showLightBody: _currentPage < 2),
                Semantics(
                  key: ValueKey('onboarding-page-status-${_currentPage + 1}'),
                  liveRegion: true,
                  label:
                      'Onboarding page ${_currentPage + 1} of ${_onboardingSlides.length}',
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: PageView(
                      key: OnboardingScreen.pageViewKey,
                      controller: _pageController,
                      onPageChanged: _onPageChanged,
                      children: [
                        for (
                          var index = 0;
                          index < _onboardingSlides.length;
                          index++
                        )
                          _OnboardingSlide(
                            slide: _onboardingSlides[index],
                            width: constraints.maxWidth,
                            height: constraints.maxHeight,
                            index: index,
                            onBackOrSkip: _skipOrGoBack,
                            onNext: _goForward,
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

class _OnboardingSlideData {
  const _OnboardingSlideData({
    required this.title,
    required this.description,
    required this.illustration,
    required this.illustrationWidth,
    required this.illustrationHeight,
  });

  final String title;
  final String description;
  final String illustration;
  final double illustrationWidth;
  final double illustrationHeight;
}

const _onboardingSlides = [
  _OnboardingSlideData(
    title: 'انبارت، همیشه همراهته!',
    description:
        'خرید و فروش دکانت را آسان مدیریت\n'
        'کن و همیشه از موجودی اجناست\n'
        'باخبر باش.',
    illustration: 'assets/ScreenShots/illustrations/f_onbrd_img.svg',
    illustrationWidth: 172,
    illustrationHeight: 217,
  ),
  _OnboardingSlideData(
    title: 'سود و ضررت را آسان بفهم!',
    description:
        'گدام خودش حساب‌وکتاب می‌کند تا\n'
        'بدانی چقدر سود کردی و چقدر مصرف\n'
        'داشتی.',
    illustration: 'assets/ScreenShots/illustrations/s_onbrd_img.svg',
    illustrationWidth: 172,
    illustrationHeight: 181,
  ),
  _OnboardingSlideData(
    title: 'حساب‌وکتاب، بدون دردسر!',
    description:
        'دیگر وقتت را با حساب‌وکتاب پیچیده\n'
        'ضایع نکن؛ گدام همه چیز را برایت\n'
        'ساده می‌سازد.',
    illustration: 'assets/ScreenShots/illustrations/t_onbrd_img.svg',
    illustrationWidth: 170,
    illustrationHeight: 193,
  ),
];

class _OnboardingSlide extends StatelessWidget {
  const _OnboardingSlide({
    required this.slide,
    required this.width,
    required this.height,
    required this.index,
    required this.onBackOrSkip,
    required this.onNext,
  });

  final _OnboardingSlideData slide;
  final double width;
  final double height;
  final int index;
  final VoidCallback onBackOrSkip;
  final VoidCallback onNext;

  @override
  Widget build(BuildContext context) {
    final horizontalPadding = (width * 0.08).clamp(20.0, 48.0).toDouble();
    final titleSize = (width * 0.056).clamp(20.0, 25.0).toDouble();
    final bodySize = (width * 0.033).clamp(12.0, 16.0).toDouble();
    final imageScale = min(
      (width * 0.55) / slide.illustrationWidth,
      (height * 0.30) / slide.illustrationHeight,
    );
    final imageWidth = slide.illustrationWidth * imageScale;
    final imageHeight = slide.illustrationHeight * imageScale;

    return LayoutBuilder(
      builder: (context, constraints) => Stack(
        fit: StackFit.expand,
        children: [
          SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(height: height * 0.145),
                    Transform.translate(
                      offset: Offset(0, -height * 0.015),
                      child: Column(
                        children: [
                          Text(
                            slide.title,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Kalameh',
                              fontSize: titleSize,
                              fontWeight: FontWeight.w600,
                              height: 1.1,
                            ),
                          ),
                          SizedBox(height: height * 0.016),
                          ConstrainedBox(
                            constraints: BoxConstraints(
                              maxWidth: min(width * 0.76, 360),
                            ),
                            child: Text(
                              slide.description,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Kalameh',
                                fontSize: bodySize,
                                fontWeight: FontWeight.w300,
                                height: 1.45,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: height * 0.025),
                      child: SizedBox(
                        width: imageWidth,
                        height: imageHeight,
                        child: SvgPicture.asset(
                          key: ValueKey(
                            '${OnboardingScreen.illustrationKey.value}-$index',
                          ),
                          slide.illustration,
                          fit: BoxFit.contain,
                          excludeFromSemantics: true,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: height * 0.025),
                      child: Semantics(
                        key: index == _onboardingSlides.length - 1
                            ? OnboardingScreen.finishButtonKey
                            : OnboardingScreen.nextButtonKeyFor(index),
                        button: true,
                        label: index == _onboardingSlides.length - 1
                            ? 'Finish onboarding'
                            : 'Next onboarding page',
                        child: IconButton(
                          onPressed: onNext,
                          tooltip: index == _onboardingSlides.length - 1
                              ? 'Finish'
                              : 'Next',
                          iconSize: 40,
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints.tightFor(
                            width: 48,
                            height: 48,
                          ),
                          icon: _OnboardingActionIcon(
                            icon: index == _onboardingSlides.length - 1
                                ? Icons.check
                                : Icons.chevron_left,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: height * 0.045,
            right: width * 0.045,
            child: Semantics(
              key: index == 0
                  ? OnboardingScreen.skipButtonKeyFor(index)
                  : OnboardingScreen.backButtonKeyFor(index),
              button: true,
              label: index == 0
                  ? 'Skip onboarding'
                  : 'Previous onboarding page',
              child: IconButton(
                onPressed: onBackOrSkip,
                tooltip: index == 0 ? 'Skip' : 'Back',
                iconSize: 24,
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints.tightFor(
                  width: 40,
                  height: 40,
                ),
                icon: Icon(
                  Icons.chevron_right,
                  color: index == 0
                      ? OnboardingScreen._arrowTint
                      : Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _OnboardingActionIcon extends StatelessWidget {
  const _OnboardingActionIcon({required this.icon});

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: OnboardingScreen._mutedTeal, width: 2),
      ),
      child: Center(
        child: Container(
          margin: const EdgeInsets.all(3),
          decoration: const BoxDecoration(
            color: OnboardingScreen._teal,
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: Colors.white, size: 24),
        ),
      ),
    );
  }
}
