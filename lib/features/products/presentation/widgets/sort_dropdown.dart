import 'package:flutter/material.dart';
import 'package:product_catalog_app/core/theme/app_colors.dart';
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
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 4, 12, 8),
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: 'Sort by price',
          filled: true,
          fillColor: AppColors.surface,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.categoryChip),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.categoryChip),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<SortType?>(
            value: sortType,
            isExpanded: true,
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
