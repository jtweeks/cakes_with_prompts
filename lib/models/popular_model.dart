import 'package:flutter/material.dart'; // For Color, though not directly used in boxColor in this model as per specs

class PopularDietsModel {
  String name;
  String iconPath;
  String level;
  String duration;
  String calorie;
  bool boxIsSelected; // Renamed from viewIsSelected to boxIsSelected as per your request

  PopularDietsModel({
    required this.name,
    required this.iconPath,
    required this.level,
    required this.duration,
    required this.calorie,
    this.boxIsSelected = false, // Default value
  });

  static List<PopularDietsModel> getPopularDiets() {
    List<PopularDietsModel> popularDiets = [];

    popularDiets.add(PopularDietsModel(
      name: 'Blueberry Pancake',
      iconPath: 'assets/icons/blueberry-pancake.svg',
      level: 'Medium',
      duration: '30mins',
      calorie: '230kCal',
      boxIsSelected: true,
    ));

    popularDiets.add(PopularDietsModel(
      name: 'Salmon Nigiri',
      iconPath: 'assets/icons/salmon-nigiri.svg',
      level: 'Easy',
      duration: '20mins',
      calorie: '120kCal',
      boxIsSelected: false,
    ));

    popularDiets.add(PopularDietsModel(
      name: 'Low-Carb Pizza',
      iconPath: 'assets/icons/pizza.svg', // Replace with a relevant icon
      level: 'Medium',
      duration: '40mins',
      calorie: '350kCal',
      boxIsSelected: false,
    ));

    popularDiets.add(PopularDietsModel(
      name: 'Chicken Salad',
      iconPath: 'assets/icons/chicken-salad.svg', // Replace with a relevant icon
      level: 'Easy',
      duration: '25mins',
      calorie: '180kCal',
      boxIsSelected: true,
    ));

    // Add more PopularDietsModel objects as needed

    return popularDiets;
  }

  // Optional: For better debugging and comparison
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is PopularDietsModel &&
              runtimeType == other.runtimeType &&
              name == other.name &&
              iconPath == other.iconPath &&
              level == other.level &&
              duration == other.duration &&
              calorie == other.calorie &&
              boxIsSelected == other.boxIsSelected;

  @override
  int get hashCode =>
      name.hashCode ^
      iconPath.hashCode ^
      level.hashCode ^
      duration.hashCode ^
      calorie.hashCode ^
      boxIsSelected.hashCode;

  @override
  String toString() {
    return 'PopularDietsModel{name: $name, iconPath: $iconPath, level: $level, duration: $duration, calorie: $calorie, boxIsSelected: $boxIsSelected}';
  }
}
