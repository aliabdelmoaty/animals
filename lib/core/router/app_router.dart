import 'package:go_router/go_router.dart';

import '../../features/favorite/ui/favorite_screen.dart';
import '../../features/home/domain/entities/breed_entity.dart';
import '../widgets/app_shell.dart';
import 'router_names.dart';
import '../../features/details/ui/details_screen.dart';
import '../../features/home/ui/home_screen.dart';
import '../../features/msg/ui/msg_screen.dart';
import '../../features/onboarding/ui/onboading_screen.dart';
import '../../features/profile/ui/profile_screen.dart';

abstract class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: RouterNames.onboarding,
    routes: [
      ShellRoute(
        builder: (context, state, child) => AppShell(child: child),
        routes: [
          GoRoute(
            path: RouterNames.home,
            builder: (context, state) => const HomeScreen(),
          ),
          GoRoute(
            path: RouterNames.favorite,
            builder: (context, state) => const FavoriteScreen(),
          ),
          GoRoute(
            path: RouterNames.msg,
            builder: (context, state) => const MsgScreen(),
          ),
          GoRoute(
            path: RouterNames.profile,
            builder: (context, state) => const ProfileScreen(),
          ),
        ],
      ),
      GoRoute(
        path: RouterNames.onboarding,
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: RouterNames.details,
        builder: (context, state) {
          final breed = state.extra as BreedEntity;
          return DetailsScreen(breed: breed);
        },
      ),
    ],
  );
}
