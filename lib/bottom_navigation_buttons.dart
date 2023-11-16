import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:youdoyou/constants/app_colors.dart';
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
      if (icon == Icons.home) {
        context.goNamed(AppRoutes.root.name);
      } else if (icon == Icons.add) {
        //TODO(Any): Implement show alert Method to add TODO item.
      } else if (icon == Icons.line_style_outlined) {
        //TODO(Any): Implement navigation.
      }
    },
    backgroundColor: AppColors.primary,
    child: Icon(icon),
  );
}
