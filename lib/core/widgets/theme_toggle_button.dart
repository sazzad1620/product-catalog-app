import 'package:flutter/material.dart';
import 'package:product_catalog_app/core/theme/app_theme_scope.dart';

class ThemeToggleButton extends StatelessWidget {
  const ThemeToggleButton({super.key});

  static const _duration = Duration(milliseconds: 350);
  static const _segmentWidth = 40.0;
  static const _segmentHeight = 32.0;

  @override
  Widget build(BuildContext context) {
    final scope = AppThemeScope.of(context);
    final isDark = scope.themeMode == ThemeMode.dark;
    final scheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: scheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: Stack(
            children: [
              AnimatedPositioned(
                duration: _duration,
                curve: Curves.easeInOut,
                left: isDark ? _segmentWidth : 0,
                child: Container(
                  width: _segmentWidth,
                  height: _segmentHeight,
                  decoration: BoxDecoration(
                    color: scheme.surface,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _Segment(
                    icon: Icons.light_mode_outlined,
                    tooltip: 'Light mode',
                    selected: !isDark,
                    onTap: isDark ? scope.toggleTheme : null,
                  ),
                  _Segment(
                    icon: Icons.dark_mode_outlined,
                    tooltip: 'Dark mode',
                    selected: isDark,
                    onTap: !isDark ? scope.toggleTheme : null,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Segment extends StatelessWidget {
  final IconData icon;
  final String tooltip;
  final bool selected;
  final VoidCallback? onTap;

  const _Segment({
    required this.icon,
    required this.tooltip,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Tooltip(
      message: tooltip,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: SizedBox(
          width: ThemeToggleButton._segmentWidth,
          height: ThemeToggleButton._segmentHeight,
          child: Icon(
            icon,
            size: 20,
            color: selected ? scheme.primary : scheme.onSurfaceVariant,
          ),
        ),
      ),
    );
  }
}
