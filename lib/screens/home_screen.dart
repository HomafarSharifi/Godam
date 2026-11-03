import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const routeName = '/home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBFAF6),
      appBar: AppBar(
        title: const Text('خانه'),
        backgroundColor: const Color(0xFF008081),
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) => Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Empty state illustration
                SvgPicture.asset(
                  'assets/ScreenShots/illustrations/h_empty_img',
                  width: constraints.maxWidth * 0.6,
                  fit: BoxFit.contain,
                ),
                const SizedBox(height: 24),
                const Text(
                  'هنوز آیتمی وجود ندارد',
                  style: TextStyle(
                    fontFamily: 'Kalameh',
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                    color: Color(0xFF1C1A15),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      // Placeholder bottom navigation bar
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.inventory), label: 'Inventory'),
          BottomNavigationBarItem(icon: Icon(Icons.attach_money), label: 'Expenses'),
          BottomNavigationBarItem(icon: Icon(Icons.sell), label: 'Selling'),
          BottomNavigationBarItem(icon: Icon(Icons.menu), label: 'Menu'),
        ],
        currentIndex: 0,
        onTap: (_) {},
      ),
    );
  }
}
