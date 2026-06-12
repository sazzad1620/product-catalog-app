import 'package:flutter/material.dart';
import 'package:product_catalog_app/features/products/presentation/bloc/products_event.dart';

class SortDropdown extends StatelessWidget {
  final SortType? sortType;
  final ValueChanged<SortType?> onChanged;

  const SortDropdown({
    super.key,
    required this.sortType,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 4, 12, 8),
      child: InputDecorator(
        decoration: const InputDecoration(
          labelText: 'Sort by price',
        ).applyDefaults(Theme.of(context).inputDecorationTheme),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<SortType?>(
            value: sortType,
            isExpanded: true,
            dropdownColor: scheme.surface,
            style: TextStyle(color: scheme.onSurface, fontSize: 16),
            items: const [
              DropdownMenuItem(
                value: null,
                child: Text('Default order'),
              ),
              DropdownMenuItem(
                value: SortType.priceLowToHigh,
                child: Text('Price: Low to High'),
              ),
              DropdownMenuItem(
                value: SortType.priceHighToLow,
                child: Text('Price: High to Low'),
              ),
            ],
            onChanged: onChanged,
          ),
        ),
      ),
    );
  }
}
