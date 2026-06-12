import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFF2563EB);
  static const Color error = Color(0xFFDC2626);

  static const Color priceLight = Color(0xFF345583);
  static const Color priceDark = Color(0xFF93C5FD);

  static Color priceColor(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark ? priceDark : priceLight;
}
