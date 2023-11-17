import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:youdoyou/home_screen/widgets/home.dart';
import 'package:youdoyou/routing/routes.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//TODO(Any): Replace all Placeholder() with correct widget/page.

final goRouterProvider = Provider<GoRouter>(
  (ref) {
    return GoRouter(
      initialLocation: '/',
      routes: [
        GoRoute(
          path: '/',
          name: AppRoutes.root.name,
          builder: (BuildContext context, GoRouterState state) => const Home(),
          routes: [
            GoRoute(
              path: 'home',
              name: AppRoutes.home.name,
              builder: (BuildContext context, GoRouterState state) => const Placeholder(),
              routes: [
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
      //TODO(Any): Replace this with some error 404 widget.
      errorBuilder: (BuildContext context, GoRouterState state) => const Text("Error"),
    );
  },
);
