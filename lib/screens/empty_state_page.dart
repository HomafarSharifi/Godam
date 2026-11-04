import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// The reference-backed content for one of the four empty tabs.
class EmptyStatePage extends StatelessWidget {
  const EmptyStatePage({super.key, required this.state});

  final EmptyStateKind state;

  static const _textDark = Color(0xFF1C1A15);
  static const _textMuted = Color(0xFF645F50);
  static const _teal = Color(0xFF008081);
  static const _kalameh = 'Kalameh';

  EmptyStateContent get _content => switch (state) {
    EmptyStateKind.home => const EmptyStateContent(
      illustration: 'h_empty_img.svg',
      illustrationWidth: 167,
      illustrationHeight: 150,
      title: 'خوش آمدید به گدام',
      subtitle: 'برای شروع کار لطفا اجناس تان را وارد برنامه کنید',
      action: 'افزودن جنس',
      actionIcon: Icons.add,
    ),
    EmptyStateKind.inventory => const EmptyStateContent(
      illustration: 'i_empty_img.svg',
      illustrationWidth: 156,
      illustrationHeight: 165,
      title: 'گدام شما خالیه!',
      subtitle: 'اجناس تان را اینجا وارد کنید',
      action: 'افزودن جنس',
      actionIcon: Icons.add,
    ),
    EmptyStateKind.expenses => const EmptyStateContent(
      illustration: 'e_empty_img.svg',
      illustrationWidth: 168,
      illustrationHeight: 155,
      title: 'هنوز مصرفی ثبت نشده',
      subtitle: 'هزینه های تان را ثبت کنید تا ضرر نکنید!',
      action: 'ثبت مصارف',
      actionIcon: Icons.bookmark_add_outlined,
    ),
    EmptyStateKind.sales => const EmptyStateContent(
      illustration: 's_empty_img.svg',
      illustrationWidth: 139,
      illustrationHeight: 166,
      title: 'چیزی فروخته نشده!',
      subtitle: 'همین حالا اولین فروش تان را ثبت کنید.',
      action: 'ثبت فروش',
      actionIcon: Icons.shopping_bag_outlined,
    ),
  };

  @override
  Widget build(BuildContext context) {
    final content = _content;
    return LayoutBuilder(
      builder: (context, constraints) {
        final compactWidth = constraints.maxWidth < 360;
        final horizontalPadding = compactWidth ? 16.0 : 24.0;
        final illustrationScale = (constraints.maxWidth / 393).clamp(0.78, 1.0);
        final topSpace = (constraints.maxHeight * 0.212).clamp(24.0, 134.0);

        return SingleChildScrollView(
          key: ValueKey('empty-state-scroll-${state.name}'),
          padding: EdgeInsets.fromLTRB(
            horizontalPadding,
            topSpace,
            horizontalPadding,
            20,
          ),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 200 * illustrationScale,
                  height: 170 * illustrationScale,
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: SvgPicture.asset(
                      'assets/ScreenShots/illustrations/${content.illustration}',
                      key: ValueKey('empty-state-illustration-${state.name}'),
                      width: content.illustrationWidth * illustrationScale,
                      height: content.illustrationHeight * illustrationScale,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  content.title,
                  key: ValueKey('empty-state-title-${state.name}'),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontFamily: _kalameh,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    height: 1.3,
                    color: _textDark,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  content.subtitle,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontFamily: _kalameh,
                    fontSize: 13,
                    fontWeight: FontWeight.w300,
                    height: 1.5,
                    color: _textMuted,
                  ),
                ),
                const SizedBox(height: 36),
                SizedBox(
                  width: content.buttonWidth,
                  height: 50,
                  child: FilledButton(
                    // Figma shows these action affordances, but provides no
                    // verified destination or behavior for them yet.
                    onPressed: null,
                    style: FilledButton.styleFrom(
                      backgroundColor: _teal,
                      foregroundColor: Colors.white,
                      disabledBackgroundColor: _teal,
                      disabledForegroundColor: Colors.white,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            content.action,
                            style: const TextStyle(
                              fontFamily: _kalameh,
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Icon(content.actionIcon, size: 22),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

enum EmptyStateKind { home, inventory, expenses, sales }

class EmptyStateContent {
  const EmptyStateContent({
    required this.illustration,
    required this.illustrationWidth,
    required this.illustrationHeight,
    required this.title,
    required this.subtitle,
    required this.action,
    required this.actionIcon,
  });

  final String illustration;
  final double illustrationWidth;
  final double illustrationHeight;
  final String title;
  final String subtitle;
  final String action;
  final IconData actionIcon;

  double get buttonWidth => switch (action) {
    'افزودن جنس' => 159,
    'ثبت مصارف' => 150,
    'ثبت فروش' => 144,
    _ => 159,
  };
}
