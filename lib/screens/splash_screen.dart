import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../widgets/apple_linear_progress.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key, this.dataLoading});

  /// Pending startup work, when the caller has data to load.
  ///
  /// With no future, the indeterminate indicator remains visible by default.
  final Future<void>? dataLoading;

  static const designFrameKey = ValueKey('splash-design-frame');

  static const _frameWidth = 393.0;
  static const _frameHeight = 852.0;
  static const _background = Color(0xFFFBFAF6);
  static const _textColor = Color(0xFF1C1A15);

  static const _overlayStyle = SystemUiOverlayStyle(
    statusBarColor: _background,
    statusBarIconBrightness: Brightness.dark,
    statusBarBrightness: Brightness.light,
    systemNavigationBarColor: _background,
    systemNavigationBarIconBrightness: Brightness.dark,
    systemNavigationBarDividerColor: _background,
  );

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: _overlayStyle,
      child: Scaffold(
        backgroundColor: _background,
        body: ColoredBox(
          color: _background,
          child: Center(
            child: FittedBox(
              fit: BoxFit.contain,
              child: SizedBox(
                key: designFrameKey,
                width: _frameWidth,
                height: _frameHeight,
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: _SplashFrame(dataLoading: dataLoading),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SplashFrame extends StatelessWidget {
  const _SplashFrame({this.dataLoading});

  final Future<void>? dataLoading;

  static const _patternWidth = 329.091;
  static const _patternHeight = 333.934;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Positioned(
          left: (SplashScreen._frameWidth - _patternWidth) / 2 + 0.05,
          top: (SplashScreen._frameHeight - _patternHeight) / 2 - 6.03,
          width: _patternWidth,
          height: _patternHeight,
          child: SvgPicture.asset(
            'assets/figma/splash/pattern-1.svg',
            fit: BoxFit.contain,
            excludeFromSemantics: true,
          ),
        ),
        Positioned(
          left: SplashScreen._frameWidth * 0.1501,
          right: SplashScreen._frameWidth * 0.1476,
          top: SplashScreen._frameHeight * 0.338,
          bottom: SplashScreen._frameHeight * 0.338,
          child: SvgPicture.asset(
            'assets/figma/splash/ellipse-3.svg',
            fit: BoxFit.contain,
            excludeFromSemantics: true,
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          top: SplashScreen._frameHeight / 2 - 34,
          child: Center(
            child: SizedBox(
              width: 173,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Transform.translate(
                    offset: const Offset(0, -24),
                    child: const Text(
                      'گدام',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: SplashScreen._textColor,
                        fontSize: 32,
                        fontWeight: FontWeight.w600,
                        height: 1,
                        fontFamily: 'Kalameh',
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Transform.translate(
                    offset: const Offset(0, -8),
                    child: const Text(
                      'مدیریت هوشمند گدام(انبار) و دکان',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: SplashScreen._textColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w300,
                        height: 1,
                        fontFamily: 'Kalameh',
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  FutureBuilder<void>(
                    future: dataLoading,
                    builder: (context, snapshot) {
                      final isLoading =
                          dataLoading == null ||
                          snapshot.connectionState != ConnectionState.done;
                      return isLoading
                          ? Semantics(
                              key: const ValueKey('splash-loading-indicator'),
                              label: 'Loading',
                              liveRegion: true,
                              child: ExcludeSemantics(
                                child: SizedBox(
                                  width: 173,
                                  height: 6,
                                  child: AppleLinearProgress(
                                    key: const ValueKey('splash-loader'),
                                    height: 6,
                                  ),
                                ),
                              ),
                            )
                          : const SizedBox(width: 173, height: 6);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
