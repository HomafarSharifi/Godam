import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:godam/main.dart';
import 'package:godam/screens/splash_screen.dart';
import 'package:godam/widgets/apple_linear_progress.dart';

void main() {
  testWidgets('renders the Figma Splash frame and its local artwork', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(393, 852));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(const MyApp());
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));

    expect(find.text('گدام'), findsOneWidget);
    expect(find.text('مدیریت هوشمند گدام(انبار) و دکان'), findsOneWidget);
    expect(find.byType(SvgPicture), findsNWidgets(2));
    expect(find.byType(AppleLinearProgress), findsOneWidget);
    final loader = find.byKey(const ValueKey('splash-loading-indicator'));
    expect(loader, findsOneWidget);
    expect(tester.getSize(loader), const Size(173, 6));
    expect(
      tester.getRect(loader).top,
      greaterThanOrEqualTo(
        tester.getRect(find.text('مدیریت هوشمند گدام(انبار) و دکان')).bottom +
            11,
      ),
    );
    expect(
      tester.getSize(find.byKey(SplashScreen.designFrameKey)),
      const Size(393, 852),
    );
  });

  testWidgets(
    'keeps the custom loader visible until startup loading completes',
    (tester) async {
      final startupLoading = Completer<void>();

      await tester.pumpWidget(
        MaterialApp(home: SplashScreen(dataLoading: startupLoading.future)),
      );
      await tester.pump();

      final loader = find.byKey(const ValueKey('splash-loading-indicator'));
      expect(loader, findsOneWidget);

      startupLoading.complete();
      await tester.pump();
      await tester.pump();

      expect(loader, findsNothing);
    },
  );
}
