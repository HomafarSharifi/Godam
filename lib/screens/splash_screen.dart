import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../widgets/apple_linear_progress.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key, this.dataLoading});

  final Future<void>? dataLoading;

  static const routeName = '/';
  static const designFrameKey = ValueKey('splash-design-frame');

  static const _minimumDisplayTime = Duration(milliseconds: 2500);
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
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? _minimumDisplayTimer;

  final _progressController = AppleLinearProgressController();

  bool _startupWorkComplete = false;
  bool _minimumDisplayComplete = false;
  bool _progressComplete = false;
  bool _navigationStarted = false;

  @override
  void initState() {
    super.initState();

    _startupWorkComplete = widget.dataLoading == null;

    _minimumDisplayTimer = Timer(SplashScreen._minimumDisplayTime, () {
      _minimumDisplayComplete = true;
      _advanceWhenReady();
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _progressController.start();
      }
    });

    if (widget.dataLoading != null) {
      widget.dataLoading!.then<void>(
        (_) {
          if (!mounted) return;

          _startupWorkComplete = true;
          _advanceWhenReady();
        },
        onError: (Object error, StackTrace stackTrace) {
          if (!mounted) return;

          // Allow the user to continue if startup loading fails.
          _startupWorkComplete = true;
          _advanceWhenReady();
        },
      );
    }
  }

  void _onProgressComplete() {
    _progressComplete = true;
    _advanceWhenReady();
  }

  void _advanceWhenReady() {
    if (_navigationStarted ||
        !_startupWorkComplete ||
        !_minimumDisplayComplete ||
        !_progressComplete ||
        !mounted) {
      return;
    }

    _navigationStarted = true;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      Navigator.of(context).pushReplacementNamed('/onboarding');
    });
    WidgetsBinding.instance.scheduleFrame();
  }

  @override
  void dispose() {
    _minimumDisplayTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SplashScreen._overlayStyle,
      child: Scaffold(
        backgroundColor: SplashScreen._background,
        body: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) => ColoredBox(
              color: SplashScreen._background,
              child: SizedBox(
                key: SplashScreen.designFrameKey,
                width: constraints.maxWidth,
                height: constraints.maxHeight,
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: _SplashFrame(
                    width: constraints.maxWidth,
                    height: constraints.maxHeight,
                    progressController: _progressController,
                    onProgressComplete: _onProgressComplete,
                  ),
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
  const _SplashFrame({
    required this.width,
    required this.height,
    required this.progressController,
    required this.onProgressComplete,
  });

  final double width;
  final double height;
  final AppleLinearProgressController progressController;
  final VoidCallback onProgressComplete;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Positioned.fill(
          child: Center(
            child: FractionallySizedBox(
              widthFactor: 0.84,
              heightFactor: 0.42,
              child: SvgPicture.asset(
                'assets/figma/splash/pattern-1.svg',
                fit: BoxFit.contain,
                excludeFromSemantics: true,
              ),
            ),
          ),
        ),
        Positioned(
          left: width * 0.1501,
          right: width * 0.1476,
          top: height * 0.338,
          bottom: height * 0.338,
          child: SvgPicture.asset(
            'assets/figma/splash/ellipse-3.svg',
            fit: BoxFit.contain,
            excludeFromSemantics: true,
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          top: height * 0.46,
          child: Center(
            child: FractionallySizedBox(
              widthFactor: 0.72,
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
                  Semantics(
                    key: const ValueKey('splash-loading-indicator'),
                    label: 'Loading',
                    liveRegion: true,
                    child: ExcludeSemantics(
                      child: SizedBox(
                        width: width * 0.44,
                        height: 6,
                        child: AppleLinearProgress(
                          key: const ValueKey('splash-loader'),
                          controller: progressController,
                          height: 6,
                          duration: const Duration(milliseconds: 1800),
                          onCompleted: onProgressComplete,
                        ),
                      ),
                    ),
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
