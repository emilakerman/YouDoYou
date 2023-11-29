import 'package:flutter/material.dart';
import 'package:youdoyou/constants/app_colors.dart';
import 'package:youdoyou/features/todos/presentation/create_todo/create_to_do_item.dart';

Widget buildFABRow({
  required BuildContext context,
}) {
  return _buildFAB(icon: Icons.add, context: context);
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
            return const CreateItemWidget();
          },
        );
      }

      if (icon == Icons.add) {
        showCreateItemDialog(context);
      }
    },
    backgroundColor: AppColors.secondary,
    child: Icon(icon),
  );
}
