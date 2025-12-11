import 'dart:ui';
import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class SpeedDialFAB extends StatefulWidget {
  final List<SpeedDialChild> children;
  final String? heroTag;

  const SpeedDialFAB({super.key, required this.children, this.heroTag});

  @override
  State<SpeedDialFAB> createState() => _SpeedDialFABState();
}

class _SpeedDialFABState extends State<SpeedDialFAB>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _isOpen = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 350),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggle() {
    setState(() {
      _isOpen = !_isOpen;
      if (_isOpen) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomLeft,
      clipBehavior: Clip.none,
      children: [
        // Backdrop Blur Overlay
        if (_isOpen)
          Positioned.fill(
            child: GestureDetector(
              onTap: _toggle,
              child: TweenAnimationBuilder<double>(
                duration: const Duration(milliseconds: 200),
                tween: Tween(begin: 0.0, end: 1.0),
                builder: (context, value, child) {
                  return BackdropFilter(
                    filter: ImageFilter.blur(
                      sigmaX: 5 * value,
                      sigmaY: 5 * value,
                    ),
                    child: Container(
                      color: Colors.black.withValues(alpha: 0.3 * value),
                    ),
                  );
                },
              ),
            ),
          ),

        // Speed Dial Children
        ...List.generate(widget.children.length, (index) {
          final child = widget.children[index];
          // Calculate delay for staggered animation
          final intervalStart = index * 0.1;
          final intervalEnd = intervalStart + 0.5;
          final childAnimation = CurvedAnimation(
            parent: _controller,
            curve: Interval(
              intervalStart.clamp(0.0, 1.0),
              intervalEnd.clamp(0.0, 1.0),
              curve: Curves.easeOutBack,
            ),
          );

          final offset = (widget.children.length - index) * 70.0;

          return AnimatedBuilder(
            animation: _controller,
            builder: (context, _) {
              return Positioned(
                bottom: 16 + (offset * childAnimation.value),
                left: 16,
                child: Transform.scale(
                  scale: childAnimation.value,
                  alignment: Alignment.bottomCenter,
                  child: Opacity(
                    opacity: childAnimation.value.clamp(0.0, 1.0),
                    child: _buildSpeedDialChild(child),
                  ),
                ),
              );
            },
          );
        }),

        // Main FAB
        Positioned(
          bottom: 16,
          left: 16,
          child: GestureDetector(
            onTap: _toggle,
            child: Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const LinearGradient(
                  colors: [AppColors.jabaliRed, Color(0xFFD32F2F)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.jabaliRed.withValues(alpha: 0.4),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Center(
                child: AnimatedRotation(
                  turns: _isOpen ? 0.125 : 0,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOutBack,
                  child: Icon(
                    _isOpen ? Icons.close : Icons.add,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSpeedDialChild(SpeedDialChild child) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Label
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Text(
            child.label,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: Colors.black87,
            ),
          ),
        ),
        const SizedBox(width: 12),
        // Mini FAB
        GestureDetector(
          onTap: () {
            _toggle();
            child.onTap();
          },
          child: Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: child.backgroundColor,
              boxShadow: [
                BoxShadow(
                  color: child.backgroundColor.withValues(alpha: 0.4),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Icon(child.icon, color: Colors.white, size: 22),
          ),
        ),
      ],
    );
  }
}

class SpeedDialChild {
  final String label;
  final IconData icon;
  final Color backgroundColor;
  final VoidCallback onTap;

  const SpeedDialChild({
    required this.label,
    required this.icon,
    required this.backgroundColor,
    required this.onTap,
  });
}
