import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:godam/main.dart';
import 'package:godam/screens/onboarding_screen.dart';
import 'package:godam/screens/registration_screen.dart';
import 'package:godam/screens/splash_screen.dart';
import 'package:godam/widgets/apple_linear_progress.dart';
import 'package:godam/widgets/onboarding_frame_background.dart';

void main() {
  testWidgets('renders the responsive Splash frame and local artwork', (
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
    expect(tester.getSize(loader), const Size(172.92, 6));
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

  testWidgets('loading animation completes once and holds at full', (
    tester,
  ) async {
    var completionCount = 0;
    await tester.pumpWidget(
      MaterialApp(
        home: SizedBox(
          width: 173,
          height: 6,
          child: AppleLinearProgress(onCompleted: () => completionCount++),
        ),
      ),
    );
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 1900));

    expect(completionCount, 1);
    expect(
      tester
          .widget<FractionallySizedBox>(find.byType(FractionallySizedBox))
          .widthFactor,
      1,
    );
    await tester.pump(const Duration(seconds: 2));
    expect(completionCount, 1);
  });

  testWidgets('waits for both progress and startup work before navigating', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(393, 852));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    final startupLoading = Completer<void>();

    await tester.pumpWidget(MyApp(startupLoading: startupLoading.future));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 1900));

    expect(find.byType(SplashScreen), findsOneWidget);
    expect(find.byType(OnboardingScreen), findsNothing);

    startupLoading.complete();
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));
    await tester.pump();

    expect(find.byType(OnboardingScreen), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('automatically opens onboarding when startup work is absent', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(393, 852));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(const MyApp());
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 1900));
    await tester.pump(const Duration(milliseconds: 400));

    expect(find.byType(OnboardingScreen), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets(
    'onboarding adapts to compact and tall viewports without overflow',
    (tester) async {
      addTearDown(() => tester.binding.setSurfaceSize(null));

      for (final size in [const Size(320, 568), const Size(432, 932)]) {
        await tester.binding.setSurfaceSize(size);
        await tester.pumpWidget(const MaterialApp(home: OnboardingScreen()));
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 100));

        expect(tester.takeException(), isNull, reason: '$size viewport');
        expect(
          tester.getSize(find.byKey(OnboardingScreen.designFrameKey)),
          size,
        );
        await tester.pumpWidget(const SizedBox.shrink());
      }
    },
  );

  testWidgets('onboarding shows its RTL copy and animated frame artwork', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(393, 852));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(const MaterialApp(home: OnboardingScreen()));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));
    expect(tester.takeException(), isNull);

    expect(find.text('انبارت، همیشه همراهته!'), findsOneWidget);
    expect(
      find.text(
        'خرید و فروش دکانت را آسان مدیریت\n'
        'کن و همیشه از موجودی اجناست\n'
        'باخبر باش.',
      ),
      findsOneWidget,
    );
    expect(find.byType(SvgPicture), findsOneWidget);
    expect(find.byType(OnboardingFrameBackground), findsOneWidget);
    final illustration = tester.getSize(
      find.byKey(const ValueKey('onboarding-illustration-0')),
    );
    expect(illustration.width, lessThanOrEqualTo(393 * 0.55));
    expect(illustration.height, lessThanOrEqualTo(852 * 0.30));
    expect(illustration.aspectRatio, closeTo(172 / 217, 0.001));
    expect(
      Directionality.of(tester.element(find.text('انبارت، همیشه همراهته!'))),
      TextDirection.rtl,
    );
  });

  testWidgets('onboarding Next and Back controls change slides', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(393, 852));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(const MaterialApp(home: OnboardingScreen()));
    await tester.pump();

    await tester.tap(find.byKey(OnboardingScreen.nextButtonKeyFor(0)));
    await tester.pump(const Duration(milliseconds: 500));
    await tester.pump();
    expect(find.text('سود و ضررت را آسان بفهم!'), findsOneWidget);
    expect(
      find.byKey(const ValueKey('onboarding-page-status-2')),
      findsOneWidget,
    );

    await tester.tap(find.byKey(OnboardingScreen.backButtonKeyFor(1)));
    await tester.pump(const Duration(milliseconds: 500));
    await tester.pump();
    expect(find.text('انبارت، همیشه همراهته!'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('onboarding can be swiped and Finish opens registration', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(393, 852));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(
      MaterialApp(
        home: const OnboardingScreen(),
        routes: {
          RegistrationScreen.routeName: (_) => const RegistrationScreen(),
        },
      ),
    );
    await tester.pump();

    final pageView = find.byKey(OnboardingScreen.pageViewKey);
    final secondPage = find.byKey(const ValueKey('onboarding-page-status-2'));
    await tester.drag(pageView, const Offset(320, 0));
    await tester.pump(const Duration(milliseconds: 600));
    await tester.pump();
    if (secondPage.evaluate().isEmpty) {
      await tester.drag(pageView, const Offset(-320, 0));
      await tester.pump(const Duration(milliseconds: 600));
      await tester.pump();
    }
    expect(secondPage, findsOneWidget);
    expect(find.text('سود و ضررت را آسان بفهم!'), findsOneWidget);

    await tester.tap(find.byKey(OnboardingScreen.nextButtonKeyFor(1)));
    await tester.pump(const Duration(milliseconds: 500));
    await tester.pump();
    expect(find.text('حساب‌وکتاب، بدون دردسر!'), findsOneWidget);

    await tester.tap(find.byKey(OnboardingScreen.finishButtonKey));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));
    expect(find.byType(RegistrationScreen), findsOneWidget);
    expect(find.byType(SvgPicture), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('Skip opens the registration design', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: const OnboardingScreen(),
        routes: {
          RegistrationScreen.routeName: (_) => const RegistrationScreen(),
        },
      ),
    );
    await tester.pump();

    await tester.tap(find.byKey(OnboardingScreen.skipButtonKeyFor(0)));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));

    expect(find.byType(RegistrationScreen), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
