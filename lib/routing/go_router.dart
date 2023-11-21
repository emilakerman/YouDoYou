import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:youdoyou/common_widgets/error_widget.dart';
import 'package:youdoyou/features/todos/presentation/home_screen/home.dart';
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

      /// The `errorBuilder` is a callback function that is used to build a widget when the GoRouter
      /// encounters an error or when a route is not found. In this case, it returns a `Text` widget with the
      /// text "Error". This widget will be displayed when there is an error or when a route is not found.
      errorBuilder: (BuildContext context, GoRouterState state) => const CustomErrorWidget(),
    );
  },
);
