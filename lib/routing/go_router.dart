import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:youdoyou/common_widgets/error_widget.dart';
import 'package:youdoyou/features/todos/domain/todo_model.dart';
import 'package:youdoyou/features/todos/presentation/detailScreen/detail_screen.dart';
import 'package:youdoyou/features/authentication/presentation/auth_page.dart';
import 'package:youdoyou/features/authentication/presentation/auth_screen.dart';
import 'package:youdoyou/features/todos/presentation/home_screen/home.dart';
import 'package:youdoyou/routing/routes.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final goRouterProvider = Provider<GoRouter>(
  (ref) {
    return GoRouter(
      initialLocation: '/',
      routes: [
        GoRoute(
          path: '/',
          name: AppRoutes.root.name,
          builder: (BuildContext context, GoRouterState state) => 
            AuthPage(),
          routes: [
            GoRoute(
              path: 'home',
              name: AppRoutes.home.name,
              builder: (BuildContext context, GoRouterState state) =>
                  Home(),
            GoRoute(
              path: 'detail',
              name: AppRoutes.detail.name,
              builder: (BuildContext context, GoRouterState state) {
                final Map<String, dynamic> args =
                    state.extra as Map<String, dynamic>;

                final TodoModel entry = args['entry'] as TodoModel;
                final String id = args['id'] as String;

                // Now you can use 'entry' and 'id' in your DetailScreen.

                return DetailScreen(entry: entry, id: id);
              },
            ),
          ],
        ),
      ],

      /// The `errorBuilder` is a callback function that is used to build a widget when the GoRouter
      /// encounters an error or when a route is not found. In this case, it returns a `Text` widget with the
      /// text "Error". This widget will be displayed when there is an error or when a route is not found.
      errorBuilder: (BuildContext context, GoRouterState state) =>
          const CustomErrorWidget(),
    );
  },
);
