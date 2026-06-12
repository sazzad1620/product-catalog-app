import 'package:flutter/material.dart';
import 'package:product_catalog_app/features/products/presentation/bloc/products_event.dart';

enum _SortMenuOption { defaultOrder, priceLowToHigh, priceHighToLow }

class SortDropdown extends StatelessWidget {
  final SortType? sortType;
  final ValueChanged<SortType?> onChanged;

  const SortDropdown({
    super.key,
    required this.sortType,
    required this.onChanged,
  });

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

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 0, 12, 8),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final menuWidth = constraints.maxWidth;

          return SizedBox(
            width: menuWidth,
            child: PopupMenuButton<_SortMenuOption>(
              position: PopupMenuPosition.under,
              popUpAnimationStyle: const AnimationStyle(
                duration: Duration(milliseconds: 350),
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
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              color: scheme.surface,
              elevation: 2,
              onSelected: (option) => onChanged(_toSortType(option)),
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
              child: InputDecorator(
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.sort),
                  suffixIcon: const Icon(Icons.arrow_drop_down),
                ).applyDefaults(Theme.of(context).inputDecorationTheme),
                child: Text(
                  _label(sortType),
                  style: TextStyle(color: scheme.onSurface, fontSize: 16),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
