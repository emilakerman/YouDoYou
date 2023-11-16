import 'package:flutter/material.dart';
import 'package:youdoyou/constants/app_colors.dart';

Widget buildFABRow({
  required BuildContext context,
}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      _buildFAB(icon: Icons.list_sharp, context: context),
      _buildFAB(icon: Icons.list_alt_outlined, context: context),
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
      if (icon == Icons.line_style_outlined) {
        //TODO(Any): Implement navigation.
      } else if (icon == Icons.list_alt_outlined) {
        //TODO(Any): Implement navigation.
      } else if (icon == Icons.list_sharp) {
        //TODO(Any): Implement navigation.
      }
    },
    backgroundColor: AppColors.primary,
    child: Icon(icon),
  );
}
