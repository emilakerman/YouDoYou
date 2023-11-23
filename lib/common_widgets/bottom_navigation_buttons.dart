import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:youdoyou/constants/app_colors.dart';
import 'package:youdoyou/features/todos/data/firestore_data_service.dart';
import 'package:youdoyou/features/todos/presentation/create_todo/createToDoItem.dart';
import 'package:youdoyou/routing/routes.dart';

/// The `buildFABRow` function returns a row of floating action buttons with different icons, and the
/// `_buildFAB` function builds each individual floating action button.
Widget buildFABRow({
  required BuildContext context,
}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      _buildFAB(icon: Icons.home, context: context),
      _buildFAB(icon: Icons.add, context: context),
      _buildFAB(icon: Icons.line_style_outlined, context: context),
    ],
  );
}

Widget _buildFAB({
  required IconData icon,
  required BuildContext context,
}) {
  return FloatingActionButton(
    heroTag: null,
    onPressed: () {
      void showCreateItemDialog(BuildContext context) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return CreateItemWidget();
          },
        );
      }

      if (icon == Icons.home) {
        context.goNamed(AppRoutes.root.name);
      } else if (icon == Icons.add) {
        showCreateItemDialog(context);
      } else if (icon == Icons.line_style_outlined) {
        //TODO(Any): Implement navigation.
      }
    },
    backgroundColor: AppColors.secondary,
    child: Icon(icon),
  );
}
