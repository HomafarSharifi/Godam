import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Displays the supplied registration design as the onboarding destination.
class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen({super.key});

  static const routeName = '/register';

  static const _systemUiStyle = SystemUiOverlayStyle(
    statusBarColor: Color(0xFFFBFAF6),
    statusBarIconBrightness: Brightness.dark,
    statusBarBrightness: Brightness.light,
    systemNavigationBarColor: Color(0xFFFBFAF6),
    systemNavigationBarIconBrightness: Brightness.dark,
    systemNavigationBarDividerColor: Color(0xFFFBFAF6),
  );

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: _systemUiStyle,
      child: Scaffold(
        backgroundColor: const Color(0xFFFBFAF6),
        body: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) => Stack(
              fit: StackFit.expand,
              children: [
                SvgPicture.asset(
                  'assets/ScreenShots/First Time Once Appear/Register.svg',
                  width: constraints.maxWidth,
                  height: constraints.maxHeight,
                  fit: BoxFit.contain,
                  semanticsLabel: 'Godam registration design',
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: Semantics(
                    button: true,
                    label: 'Back to onboarding',
                    child: SizedBox(
                      width: 48,
                      height: 48,
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () => Navigator.of(context).maybePop(),
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
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
