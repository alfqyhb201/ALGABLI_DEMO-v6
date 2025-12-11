import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class AppHeader extends StatelessWidget {
  final String title;
  final List<Widget>? actions;
  final bool showBackButton;
  final VoidCallback? onMenuPressed;

  const AppHeader({
    super.key,
    required this.title,
    this.actions,
    this.showBackButton = true,
    this.onMenuPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 16,
        bottom: 24,
        left: 16,
        right: 16,
      ),
      decoration: const BoxDecoration(
        color: AppColors.darkCard,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(32),
          bottomRight: Radius.circular(32),
        ),
      ),
      child: Row(
        children: [
          if (onMenuPressed != null)
            IconButton(
              icon: const Icon(Icons.menu, color: Colors.white),
              onPressed: onMenuPressed,
            )
          else if (showBackButton && Navigator.canPop(context))
            IconButton(
              icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          if (actions != null) ...actions!,
        ],
      ),
    );
  }
}
