import 'dart:math';

import 'package:flutter/material.dart';

/// Paints the complete onboarding backdrop, including its animated color edge.
class OnboardingFrameBackground extends StatefulWidget {
  const OnboardingFrameBackground({super.key, required this.showLightBody});

  final bool showLightBody;

  @override
  State<OnboardingFrameBackground> createState() =>
      _OnboardingFrameBackgroundState();
}

class _OnboardingFrameBackgroundState extends State<OnboardingFrameBackground>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final reduceMotion =
        MediaQuery.maybeOf(context)?.disableAnimations ?? false;
    if (reduceMotion) {
      _controller.stop();
    } else if (!_controller.isAnimating) {
      _controller.repeat();
    }
  }

  @override
  Widget build(BuildContext context) {
    final reduceMotion =
        MediaQuery.maybeOf(context)?.disableAnimations ?? false;
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) => CustomPaint(
        painter: _OnboardingBackgroundPainter(
          phase: reduceMotion ? 0 : _controller.value,
          showLightBody: widget.showLightBody,
        ),
        child: const SizedBox.expand(),
      ),
    );
  }
}

class _OnboardingBackgroundPainter extends CustomPainter {
  const _OnboardingBackgroundPainter({
    required this.phase,
    required this.showLightBody,
  });

  final double phase;
  final bool showLightBody;

  static const _teal = Color(0xFF008081);
  static const _light = Color(0xFFFBFAF6);

  @override
  void paint(Canvas canvas, Size size) {
    if (size.isEmpty) return;
    if (showLightBody) {
      canvas.drawColor(_light, BlendMode.src);
      final path = Path()
        ..moveTo(0, 0)
        ..lineTo(size.width, 0);
      final baseY = size.height * 0.36;
      final amplitude1 = min(12.0, size.height * 0.014);
      final amplitude2 = min(6.0, size.height * 0.007);
      final angle = phase * 2 * pi;
      final step = max(1.0, size.width / 240);

      for (double x = size.width; x >= 0; x -= step) {
        final normalizedX = x / size.width;
        final wave1 = sin(normalizedX * 2 * pi + angle) * amplitude1;
        final wave2 = sin(normalizedX * 4 * pi - angle * 2) * amplitude2;
        path.lineTo(x, baseY + wave1 + wave2);
      }
      path.close();
      canvas.drawPath(path, Paint()..color = _teal);
    } else {
      canvas.drawColor(_teal, BlendMode.src);
    }
  }

  @override
  bool shouldRepaint(covariant _OnboardingBackgroundPainter oldDelegate) =>
      oldDelegate.phase != phase || oldDelegate.showLightBody != showLightBody;
}
