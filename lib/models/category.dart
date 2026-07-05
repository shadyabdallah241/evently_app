import 'package:flutter/material.dart';

class CategoryData {
  final IconData icon;
  final String text;

  CategoryData(this.icon, this.text);

  IconData getIcon(ThemeMode appTheme) {
    return icon;
  }
}

final List<CategoryData> categories = [
  CategoryData(Icons.grid_view_rounded, 'all'),
  CategoryData(Icons.directions_bike_outlined, 'sport'),
  CategoryData(Icons.menu_book, 'category_book_club'),
  CategoryData(Icons.cake_outlined, 'birthday'),
  CategoryData(Icons.draw, 'exhibition'),
  CategoryData(Icons.chair_alt_rounded, 'meeting'),
];
