import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'empty_state_page.dart';

/// Main shell for the four reference empty states.
///
/// Tabs are ordered right to left: Home, Inventory, Expenses, Sales.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const routeName = '/home';
  static const bottomNavigationKey = ValueKey('home-bottom-navigation');
  static ValueKey<String> tabKey(int index) => ValueKey('home-tab-$index');

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const _background = Color(0xFFFBFAF6);
  static const _header = Colors.white;
  static const _primary = Color(0xFF008081);
  static const _primaryDark = Color(0xFF004D4D);
  static const _activeText = Color(0xFF006667);
  static const _pillFill = Color(0xFFE6F5F5);
  static const _pillBorder = Color(0xFF99D6D6);
  static const _kalameh = 'Kalameh';

  static const _tabs = <_TabData>[
    _TabData('خانه', Icons.home_outlined, Icons.home_rounded),
    _TabData('انبار', Icons.inventory_2_outlined, Icons.inventory_2_rounded),
    _TabData('مصارف', Icons.receipt_long_outlined, Icons.receipt_long_rounded),
    _TabData('فروش', Icons.shopping_bag_outlined, Icons.shopping_bag_rounded),
  ];

  int _selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: _header,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
        systemNavigationBarColor: _background,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          backgroundColor: _background,
          body: SafeArea(
            top: false,
            child: Column(
              children: [
                _buildHeader(),
                Expanded(
                  child: IndexedStack(
                    index: _selectedTab,
                    children: const [
                      EmptyStatePage(state: EmptyStateKind.home),
                      EmptyStatePage(state: EmptyStateKind.inventory),
                      EmptyStatePage(state: EmptyStateKind.expenses),
                      EmptyStatePage(state: EmptyStateKind.sales),
                    ],
                  ),
                ),
                _buildBottomNavigation(),
                const SizedBox(height: 22),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return SizedBox(
      height: 120,
      child: Align(
        alignment: const Alignment(0, 0.433),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Row(
            children: [
              _buildMenuMark(),
              const Spacer(),
              _buildNotificationMark(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuMark() {
    return SizedBox(
      width: 24,
      height: 24,
      child: Center(
        child: SizedBox(
          width: 20,
          height: 14,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
              3,
              (_) => Container(
                height: 1.5,
                decoration: BoxDecoration(
                  color: _primary,
                  borderRadius: BorderRadius.circular(1),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNotificationMark() {
    return Container(
      width: 36,
      height: 36,
      decoration: const BoxDecoration(color: _pillFill, shape: BoxShape.circle),
      child: const Icon(
        Icons.notifications_none_rounded,
        color: _primaryDark,
        size: 20,
      ),
    );
  }

  Widget _buildBottomNavigation() {
    return Center(
      child: LayoutBuilder(
        builder: (context, constraints) {
          final width = constraints.maxWidth < 284
              ? constraints.maxWidth - 32
              : 252.0;
          final slotWidth = width / _tabs.length;
          final activeWidth = (slotWidth + 1).clamp(48.0, 64.0);
          final activeLeft =
              width - 4 - activeWidth - (_selectedTab * slotWidth);

          return SizedBox(
            key: HomeScreen.bottomNavigationKey,
            width: width,
            height: 56,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: _pillFill,
                borderRadius: BorderRadius.circular(28),
                border: Border.all(color: _pillBorder),
              ),
              child: Stack(
                children: [
                  AnimatedPositioned(
                    duration: const Duration(milliseconds: 180),
                    curve: Curves.easeOut,
                    left: activeLeft,
                    top: 4,
                    width: activeWidth,
                    height: 48,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: _pillBorder,
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                  ),
                  Row(
                    children: List.generate(
                      _tabs.length,
                      (index) => _buildTab(index, slotWidth),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTab(int index, double slotWidth) {
    final tab = _tabs[index];
    final selected = _selectedTab == index;
    return SizedBox(
      width: slotWidth,
      height: 56,
      child: Semantics(
        key: HomeScreen.tabKey(index),
        button: true,
        selected: selected,
        label: tab.label,
        child: InkWell(
          onTap: () => setState(() => _selectedTab = index),
          borderRadius: BorderRadius.circular(24),
          child: ExcludeSemantics(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  selected ? tab.selectedIcon : tab.icon,
                  size: 22,
                  color: selected ? _activeText : _primary,
                ),
                const SizedBox(height: 2),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    tab.label,
                    maxLines: 1,
                    softWrap: false,
                    style: TextStyle(
                      fontFamily: _kalameh,
                      fontSize: 10,
                      fontWeight: selected ? FontWeight.w600 : FontWeight.w300,
                      color: selected ? _activeText : _primary,
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

class _TabData {
  const _TabData(this.label, this.icon, this.selectedIcon);

  final String label;
  final IconData icon;
  final IconData selectedIcon;
}
