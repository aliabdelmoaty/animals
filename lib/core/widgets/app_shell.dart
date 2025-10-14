import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../theme/colors_app.dart';
import '../utils/assets_path.dart';
import '../router/router_names.dart';

class AppShell extends StatelessWidget {
  const AppShell({super.key, required this.child, this.appBar});
  final Widget child;
  final PreferredSizeWidget? appBar;

  @override
  Widget build(BuildContext context) {
    const List<String> tabRoutes = <String>[
      RouterNames.home,
      RouterNames.favorite,
      RouterNames.msg,
      RouterNames.profile,
    ];

    final String location = GoRouterState.of(context).uri.toString();
    int currentIndex = 0;
    for (int i = 0; i < tabRoutes.length; i++) {
      if (location.startsWith(tabRoutes[i])) {
        currentIndex = i;
        break;
      }
    }
    return Scaffold(
      appBar: appBar,
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: ColorsApp.verdigris,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        enableFeedback: false,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        unselectedItemColor: ColorsApp.taupeGray,
        elevation: 5,
        iconSize: 24.r,
        items: [
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage(AssetPaths.images.home), size: 24.r),
            activeIcon: ImageIcon(
              AssetImage(AssetPaths.images.home),
              size: 30.r,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage(AssetPaths.images.favorite), size: 24.r),
            activeIcon: ImageIcon(
              AssetImage(AssetPaths.images.favorite),
              size: 30.r,
            ),
            label: 'Favorite',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage(AssetPaths.images.message), size: 24.r),
            activeIcon: ImageIcon(
              AssetImage(AssetPaths.images.message),
              size: 30.r,
            ),
            label: 'Messages',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage(AssetPaths.images.profile), size: 24.r),
            activeIcon: ImageIcon(
              AssetImage(AssetPaths.images.profile),
              size: 30.r,
            ),
            label: 'Profile',
          ),
        ],
        currentIndex: currentIndex,
        onTap: (int index) {
          final String target = tabRoutes[index];
          if (!location.startsWith(target)) {
            context.go(target);
          }
        },
      ),
    );
  }
}
