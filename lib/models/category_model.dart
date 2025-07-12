import 'package:flutter/material.dart'; // For Color type

class CategoryModel {
  String name;
  String iconPath;
  Color boxColor;

  CategoryModel({
    required this.name,
    required this.iconPath,
    required this.boxColor,
  });

  static List<CategoryModel> getCategories() {
    List<CategoryModel> categories = [];

    categories.add(CategoryModel(
      name: 'Salad',
      iconPath: 'assets/icons/plate.svg',
      boxColor: const Color(0xff92A3FD),
    ));

    categories.add(CategoryModel(
      name: 'Pancakes',
      iconPath: 'assets/icons/pancakes.svg',
      boxColor: const Color(0xffC58BF2),
    ));

    categories.add(CategoryModel(
      name: 'Pie',
      iconPath: 'assets/icons/pie.svg',
      boxColor: const Color(0xff92A3FD),
    ));

    categories.add(CategoryModel(
      name: 'Orange Snacks',
      iconPath: 'assets/icons/orange-snacks.svg',
      boxColor: const Color(0xffC58BF2),
    ));

    // Add more categories as needed

    return categories;
  }

  // Optional: For better debugging and comparison in tests
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is CategoryModel &&
              runtimeType == other.runtimeType &&
              name == other.name &&
              iconPath == other.iconPath &&
              boxColor == other.boxColor;

  @override
  int get hashCode => name.hashCode ^ iconPath.hashCode ^ boxColor.hashCode;

  @override
  String toString() {
    return 'CategoryModel{name: $name, iconPath: $iconPath, boxColor: $boxColor}';
  }
}
