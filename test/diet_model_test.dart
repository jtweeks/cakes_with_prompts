import 'package:cakes_with_prompts/models/diet_model.dart';
import 'package:flutter/material.dart'; // For Color
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('DietModel', () {
    test('Constructor creates a valid DietModel instance with default viewIsSelected', () {
      // Arrange
      const name = 'Test Diet';
      const iconPath = 'assets/icons/test_diet.svg';
      const level = 'Medium';
      const duration = '40mins';
      const calorie = '300kCal';
      const boxColor = Colors.orange;

      // Act
      final model = DietModel(
        name: name,
        iconPath: iconPath,
        level: level,
        duration: duration,
        calorie: calorie,
        boxColor: boxColor,
      );

      // Assert
      expect(model.name, name);
      expect(model.iconPath, iconPath);
      expect(model.level, level);
      expect(model.duration, duration);
      expect(model.calorie, calorie);
      expect(model.boxColor, boxColor);
      expect(model.viewIsSelected, isFalse); // Check default value
    });

    test('Constructor creates a valid DietModel instance with explicit viewIsSelected', () {
      // Arrange
      const name = 'Selected Diet';
      const iconPath = 'assets/icons/selected_diet.svg';
      const level = 'Hard';
      const duration = '60mins';
      const calorie = '500kCal';
      const boxColor = Colors.red;
      const viewIsSelected = true;

      // Act
      final model = DietModel(
        name: name,
        iconPath: iconPath,
        level: level,
        duration: duration,
        calorie: calorie,
        boxColor: boxColor,
        viewIsSelected: viewIsSelected,
      );

      // Assert
      expect(model.viewIsSelected, isTrue);
    });

    test('Instances with same values should be equal', () {
      final model1 = DietModel(
        name: 'Honey Pancake',
        iconPath: 'assets/icons/honey-pancakes.svg',
        level: 'Easy',
        duration: '30mins',
        calorie: '180kCal',
        boxColor: const Color(0xff92A3FD),
        viewIsSelected: true,
      );
      final model2 = DietModel(
        name: 'Honey Pancake',
        iconPath: 'assets/icons/honey-pancakes.svg',
        level: 'Easy',
        duration: '30mins',
        calorie: '180kCal',
        boxColor: const Color(0xff92A3FD),
        viewIsSelected: true,
      );
      final model3 = DietModel(
        name: 'Canai Bread',
        iconPath: 'assets/icons/canai-bread.svg',
        level: 'Easy',
        duration: '20mins',
        calorie: '230kCal',
        boxColor: const Color(0xffC58BF2),
        viewIsSelected: false,
      );

      expect(model1 == model2, isTrue);
      expect(model1.hashCode == model2.hashCode, isTrue);
      expect(model1 == model3, isFalse);
    });

    test('toString() returns a readable string representation', () {
      final model = DietModel(
        name: 'Keto Delight',
        iconPath: 'assets/icons/keto-diet.svg',
        level: 'Medium',
        duration: '45mins',
        calorie: '350kCal',
        boxColor: Colors.teal,
        viewIsSelected: false,
      );
      expect(
        model.toString(),
        'DietModel{name: Keto Delight, iconPath: assets/icons/keto-diet.svg, level: Medium, duration: 45mins, calorie: 350kCal, boxColor: ${Colors.teal}, viewIsSelected: false}',
      );
    });
  });

  group('DietModel.getDiets', () {
    test('returns a non-empty list of DietModel objects', () {
      // Act
      final diets = DietModel.getDiets();

      // Assert
      expect(diets, isNotEmpty);
      expect(diets, isA<List<DietModel>>());
      expect(diets.every((diet) => diet is DietModel), isTrue);
    });

    test('returns diets with expected data for the first item', () {
      // Act
      final diets = DietModel.getDiets();

      // Assert
      if (diets.isNotEmpty) {
        final firstDiet = diets.first;
        expect(firstDiet.name, 'Honey Pancake');
        expect(firstDiet.iconPath, 'assets/icons/honey-pancakes.svg');
        expect(firstDiet.level, 'Easy');
        expect(firstDiet.duration, '30mins');
        expect(firstDiet.calorie, '180kCal');
        expect(firstDiet.boxColor, const Color(0xff92A3FD));
        expect(firstDiet.viewIsSelected, isTrue);
      } else {
        fail('getDiets returned an empty list, cannot check first item.');
      }
      // Based on the current implementation in getDiets()
      expect(diets.length, 4);
    });

    test('all diets have non-empty names and iconPaths', () {
      final diets = DietModel.getDiets();
      for (var diet in diets) {
        expect(diet.name, isNotEmpty);
        expect(diet.iconPath, isNotEmpty);
        expect(diet.level, isNotEmpty);
        expect(diet.duration, isNotEmpty);
        expect(diet.calorie, isNotEmpty);
        // viewIsSelected can be true or false, so no isNotEmpty check needed for it
      }
    });

    test('at least one diet has viewIsSelected as true and one as false if multiple diets', () {
      final diets = DietModel.getDiets();
      if (diets.length > 1) { // Only relevant if there's a mix
        expect(diets.any((diet) => diet.viewIsSelected == true), isTrue, reason: "Expected at least one diet with viewIsSelected = true");
        expect(diets.any((diet) => diet.viewIsSelected == false), isTrue, reason: "Expected at least one diet with viewIsSelected = false");
      } else if (diets.isNotEmpty) {
        // If only one diet, just print its state for information
        print("Single diet found, viewIsSelected: ${diets.first.viewIsSelected}");
      }
    });
  });
}
