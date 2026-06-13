import 'package:flutter/material.dart';
import 'package:product_catalog_app/features/products/presentation/bloc/products_event.dart';

enum _SortMenuOption { defaultOrder, priceLowToHigh, priceHighToLow }

class SortDropdown extends StatefulWidget {
  final SortType? sortType;
  final ValueChanged<SortType?> onChanged;

  const SortDropdown({
    super.key,
    required this.sortType,
    required this.onChanged,
  });

  @override
  State<SortDropdown> createState() => _SortDropdownState();
}

class _SortDropdownState extends State<SortDropdown> {
  static const _radius = BorderRadius.all(Radius.circular(12));

  bool _isMenuOpen = false;

  static String _label(SortType? sortType) {
    return switch (sortType) {
      SortType.priceLowToHigh => 'Price: Low to High',
      SortType.priceHighToLow => 'Price: High to Low',
      null => 'Default order',
    };
  }

  static SortType? _toSortType(_SortMenuOption option) {
    return switch (option) {
      _SortMenuOption.defaultOrder => null,
      _SortMenuOption.priceLowToHigh => SortType.priceLowToHigh,
      _SortMenuOption.priceHighToLow => SortType.priceHighToLow,
    };
  }

  void _setMenuOpen(bool isOpen) {
    if (_isMenuOpen != isOpen) {
      setState(() => _isMenuOpen = isOpen);
    }
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 0, 12, 8),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final menuWidth = constraints.maxWidth;

          return SizedBox(
            width: menuWidth,
            child: PopupMenuButton<_SortMenuOption>(
              position: PopupMenuPosition.under,
              borderRadius: _radius,
              popUpAnimationStyle: const AnimationStyle(
                duration: Duration(milliseconds: 300),
                reverseDuration: Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                reverseCurve: Curves.easeInOut,
              ),
              offset: const Offset(0, 2),
              padding: EdgeInsets.zero,
              constraints: BoxConstraints(
                minWidth: menuWidth,
                maxWidth: menuWidth,
              ),
              shape: const RoundedRectangleBorder(borderRadius: _radius),
              color: scheme.surface,
              elevation: 2,
              onOpened: () => _setMenuOpen(true),
              onCanceled: () => _setMenuOpen(false),
              onSelected: (option) {
                _setMenuOpen(false);
                widget.onChanged(_toSortType(option));
              },
              itemBuilder: (context) => const [
                PopupMenuItem(
                  value: _SortMenuOption.defaultOrder,
                  child: Text('Default order'),
                ),
                PopupMenuItem(
                  value: _SortMenuOption.priceLowToHigh,
                  child: Text('Price: Low to High'),
                ),
                PopupMenuItem(
                  value: _SortMenuOption.priceHighToLow,
                  child: Text('Price: High to Low'),
                ),
              ],
              child: Material(
                color: Colors.transparent,
                borderRadius: _radius,
                clipBehavior: Clip.antiAlias,
                child: InputDecorator(
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.sort),
                    suffixIcon: AnimatedRotation(
                      turns: _isMenuOpen ? 0.5 : 0,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      child: const Icon(Icons.arrow_drop_down),
                    ),
                  ).applyDefaults(Theme.of(context).inputDecorationTheme),
                  child: Text(
                    _label(widget.sortType),
                    style: textTheme.titleMedium,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
