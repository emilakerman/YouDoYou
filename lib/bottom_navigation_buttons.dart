import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youdoyou/constants/app_colors.dart';

Widget buildFABRow({
  required BuildContext context,
  Function? onPressed,
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
  final iconHandlers = {
    Icons.line_style_outlined: () {
      //TODO(Any): Implement navigation.
    },
    Icons.list_alt_outlined: () {
      //TODO(Any): Implement navigation.
    },
    Icons.list_sharp: () {
      //TODO(Any): Implement navigation.
    },
  };

  return Consumer(
    builder: (_, ref, __) => FloatingActionButton(
      heroTag: null,
      onPressed: iconHandlers[icon],
      backgroundColor: AppColors.primary,
      child: Icon(icon),
    ),
  );
}
