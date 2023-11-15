import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:youdoyou/routing/routes.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();

//TODO(Any): Replace all Placeholder() with correct widget/page.

final GoRouter route = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: AppRoutes.root.name,
  routes: [
    GoRoute(
      path: '/',
      name: AppRoutes.root.name,
      builder: (BuildContext context, GoRouterState state) => const Placeholder(),
      routes: [
        GoRoute(
          path: 'home',
          name: AppRoutes.home.name,
          builder: (BuildContext context, GoRouterState state) => const Placeholder(),
          routes: [
            GoRoute(
              path: 'create',
              name: AppRoutes.create.name,
              builder: (BuildContext context, GoRouterState state) => const Placeholder(),
            ),
            GoRoute(
              path: 'detail',
              name: AppRoutes.detail.name,
              builder: (BuildContext context, GoRouterState state) => const Placeholder(),
            ),
          ],
        ),
      ],
    ),
  ],
);
