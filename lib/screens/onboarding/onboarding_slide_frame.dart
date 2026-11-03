
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

// Shared responsive layout for the separate onboarding page widgets.
class OnboardingSlideFrame extends StatelessWidget {
  const OnboardingSlideFrame({
    super.key,
    required this.title,
    required this.description,
    required this.illustration,
    required this.illustrationWidth,
    required this.illustrationHeight,
    required this.index,
    required this.width,
    required this.height,
    required this.onBackOrSkip,
    required this.onNext,
    required this.isLastPage,
  });

  final String title;
  final String description;
  final String illustration;
  final double illustrationWidth;
  final double illustrationHeight;
  final int index;
  final double width;
  final double height;
  final VoidCallback onBackOrSkip;
  final VoidCallback onNext;
  final bool isLastPage;

  static const _teal = Color(0xFF008081);
  static const _mutedTeal = Color(0xFF99D6D6);
  static const _arrowTint = Color(0xB399D6D6);

  static const illustrationKey =
      ValueKey('onboarding-illustration');

  static const finishButtonKey =
      ValueKey('onboarding-finish-button');

  static ValueKey<String> skipButtonKeyFor(int index) =>
      ValueKey('onboarding-skip-button-$index');

  static ValueKey<String> backButtonKeyFor(int index) =>
      ValueKey('onboarding-back-button-$index');

  static ValueKey<String> nextButtonKeyFor(int index) =>
      ValueKey('onboarding-next-button-$index');

  @override
  Widget build(BuildContext context) {
    final horizontalPadding =
        (width * 0.08).clamp(20.0, 48.0).toDouble();

    final titleSize =
        (width * 0.056).clamp(20.0, 25.0).toDouble();

    final bodySize =
        (width * 0.033).clamp(12.0, 16.0).toDouble();

    final imageScale = min(
      (width * 0.55) / illustrationWidth,
      (height * 0.30) / illustrationHeight,
    );

    final imageWidth = illustrationWidth * imageScale;
    final imageHeight = illustrationHeight * imageScale;

    return LayoutBuilder(
      builder: (context, constraints) => Stack(
        fit: StackFit.expand,
        children: [
          SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: horizontalPadding,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(height: height * 0.145),

                    Transform.translate(
                      offset: Offset(0, -height * 0.06),
                      child: Column(
                        children: [
                          Text(
                            title,
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
                              description,
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
                      padding: EdgeInsets.symmetric(
                        vertical: height * 0.06,
                      ),
                      child: SizedBox(
                        width: imageWidth,
                        height: imageHeight,
                        child: SvgPicture.asset(
                          key: ValueKey(
                            '${illustrationKey.value}-$index',
                          ),
                          illustration,
                          fit: BoxFit.contain,
                          excludeFromSemantics: true,
                        ),
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.only(
                        bottom: height * 0.045,
                      ),
                      child: Semantics(
                        key: isLastPage
                            ? finishButtonKey
                            : nextButtonKeyFor(index),
                        button: true,
                        label: isLastPage
                            ? 'Finish onboarding'
                            : 'Next onboarding page',
                        child: IconButton(
                          onPressed: onNext,
                          tooltip: isLastPage ? 'Finish' : 'Next',
                          iconSize: 40,
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints.tightFor(
                            width: 48,
                            height: 48,
                          ),
                          icon: _OnboardingActionIcon(
                            icon: isLastPage
                                ? Icons.check
                                : Icons.chevron_right,
                            progress: (index + 1) / 3,
                            previousProgress: index / 3,
                            isLastPage: isLastPage,
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
                  ? skipButtonKeyFor(index)
                  : backButtonKeyFor(index),
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
                  Icons.chevron_left,
                  color: index == 0 ? _arrowTint : Colors.white,
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
  const _OnboardingActionIcon({
    required this.icon,
    required this.progress,
    required this.previousProgress,
    required this.isLastPage,
  });

  final IconData icon;
  final double progress;
  final double previousProgress;
  final bool isLastPage;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 40,
      height: 40,
      child: TweenAnimationBuilder<double>(
        tween: Tween<double>(
          begin: previousProgress,
          end: progress,
        ),
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOut,
        builder: (context, animatedProgress, child) {
          return CustomPaint(
            painter: _ProgressRingPainter(
              progress: animatedProgress,
              color: OnboardingSlideFrame._mutedTeal,
            ),
            child: Padding(
              // Keep the same inset on every page so the circle
              // remains centered inside the progress ring.
              padding: const EdgeInsets.all(6),
              child: Container(
                decoration: const BoxDecoration(
                  color: OnboardingSlideFrame._teal,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Icon(
                    icon,
                    color: Colors.white,
                    size: isLastPage ? 18 : 28,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _ProgressRingPainter extends CustomPainter {
  const _ProgressRingPainter({
    required this.progress,
    required this.color,
  });

  final double progress;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    const strokeWidth = 3.0;

    final center = Offset(
      size.width / 2,
      size.height / 2,
    );

    final radius = (size.shortestSide - strokeWidth) / 2;

    final rect = Rect.fromCircle(
      center: center,
      radius: radius,
    );

    // Draw the complete, subtle outline.
    final trackPaint = Paint()
      ..color = color.withValues(alpha: 0.45)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    canvas.drawCircle(center, radius, trackPaint);

    // Draw the animated progress arc clockwise from the top.
    final progressPaint = Paint()
      ..color = OnboardingSlideFrame._teal
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      rect,
      -pi / 2,
      2 * pi * progress.clamp(0.0, 1.0),
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(
    covariant _ProgressRingPainter oldDelegate,
  ) {
    return oldDelegate.progress != progress ||
        oldDelegate.color != color;
  }
}
