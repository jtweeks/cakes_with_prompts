import 'package:flutter/material.dart'; // For Color type

class DietModel {
  String name;
  String iconPath;
  String level;
  String duration;
  String calorie;
  Color boxColor;
  bool viewIsSelected;

  DietModel({
    required this.name,
    required this.iconPath,
    required this.level,
    required this.duration,
    required this.calorie,
    required this.boxColor,
    this.viewIsSelected = false, // Default value for viewIsSelected
  });

  static List<DietModel> getDiets() {
    List<DietModel> diets = [];

    diets.add(DietModel(
      name: 'Honey Pancake',
      iconPath: 'assets/icons/honey-pancakes.svg',
      level: 'Easy',
      duration: '30mins',
      calorie: '180kCal',
      boxColor: const Color(0xff92A3FD),
      viewIsSelected: true, // Example: first item is selected
    ));

    diets.add(DietModel(
      name: 'Canai Bread',
      iconPath: 'assets/icons/canai-bread.svg',
      level: 'Easy',
      duration: '20mins',
      calorie: '230kCal',
      boxColor: const Color(0xffC58BF2),
    ));

    diets.add(DietModel(
      name: 'Keto Delight',
      iconPath: 'assets/icons/keto-diet.svg', // Replace with an appropriate icon
      level: 'Medium',
      duration: '45mins',
      calorie: '350kCal',
      boxColor: const Color(0xff92A3FD),
    ));

    diets.add(DietModel(
      name: 'Vegan Salad Bowl',
      iconPath: 'assets/icons/salad.svg', // Replace with an appropriate icon
      level: 'Easy',
      duration: '15mins',
      calorie: '150kCal',
      boxColor: const Color(0xffC58BF2),
      viewIsSelected: false,
    ));

    // Add more DietModel objects as needed

    return diets;
  }

  // Optional: For better debugging and comparison
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is DietModel &&
              runtimeType == other.runtimeType &&
              name == other.name &&
              iconPath == other.iconPath &&
              level == other.level &&
              duration == other.duration &&
              calorie == other.calorie &&
              boxColor == other.boxColor &&
              viewIsSelected == other.viewIsSelected;

  @override
  int get hashCode =>
      name.hashCode ^
      iconPath.hashCode ^
      level.hashCode ^
      duration.hashCode ^
      calorie.hashCode ^
      boxColor.hashCode ^
      viewIsSelected.hashCode;

  @override
  String toString() {
    return 'DietModel{name: $name, iconPath: $iconPath, level: $level, duration: $duration, calorie: $calorie, boxColor: $boxColor, viewIsSelected: $viewIsSelected}';
  }
}
