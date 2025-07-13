import 'package:cakes_with_prompts/models/popular_model.dart';
import 'package:flutter_test/flutter_test.dart';
// Assuming PopularDietsModel is in a file named popular_diets_model.dart
// Adjust the import path based on your project structure.

void main() {
  group('PopularDietsModel', () {
    test('Constructor creates a valid instance with default boxIsSelected', () {
      final model = PopularDietsModel(
        name: 'Test Popular Diet',
        iconPath: 'assets/icons/test_popular.svg',
        level: 'Hard',
        duration: '50mins',
        calorie: '400kCal',
      );

      expect(model.name, 'Test Popular Diet');
      expect(model.iconPath, 'assets/icons/test_popular.svg');
      expect(model.level, 'Hard');
      expect(model.duration, '50mins');
      expect(model.calorie, '400kCal');
      expect(model.boxIsSelected, isFalse); // Check default
    });

    test('Constructor creates a valid instance with explicit boxIsSelected', () {
      final model = PopularDietsModel(
        name: 'Selected Popular Diet',
        iconPath: 'assets/icons/selected_popular.svg',
        level: 'Easy',
        duration: '15mins',
        calorie: '150kCal',
        boxIsSelected: true,
      );
      expect(model.boxIsSelected, isTrue);
    });

    test('Instances with same values should be equal', () {
      final model1 = PopularDietsModel(
        name: 'Blueberry Pancake',
        iconPath: 'assets/icons/blueberry-pancake.svg',
        level: 'Medium',
        duration: '30mins',
        calorie: '230kCal',
        boxIsSelected: true,
      );
      final model2 = PopularDietsModel(
        name: 'Blueberry Pancake',
        iconPath: 'assets/icons/blueberry-pancake.svg',
        level: 'Medium',
        duration: '30mins',
        calorie: '230kCal',
        boxIsSelected: true,
      );
      final model3 = PopularDietsModel(
        name: 'Salmon Nigiri',
        iconPath: 'assets/icons/salmon-nigiri.svg',
        level: 'Easy',
        duration: '20mins',
        calorie: '120kCal',
        boxIsSelected: false,
      );

      expect(model1 == model2, isTrue);
      expect(model1.hashCode == model2.hashCode, isTrue);
      expect(model1 == model3, isFalse);
    });

    test('toString() returns a readable string representation', () {
      final model = PopularDietsModel(
        name: 'Low-Carb Pizza',
        iconPath: 'assets/icons/pizza.svg',
        level: 'Medium',
        duration: '40mins',
        calorie: '350kCal',
        boxIsSelected: false,
      );
      expect(
        model.toString(),
        'PopularDietsModel{name: Low-Carb Pizza, iconPath: assets/icons/pizza.svg, level: Medium, duration: 40mins, calorie: 350kCal, boxIsSelected: false}',
      );
    });
  });

  group('PopularDietsModel.getPopularDiets', () {
    test('returns a non-empty list of PopularDietsModel objects', () {
      final popularDiets = PopularDietsModel.getPopularDiets();

      expect(popularDiets, isNotEmpty);
      expect(popularDiets, isA<List<PopularDietsModel>>());
      expect(popularDiets.every((diet) => diet is PopularDietsModel), isTrue);
    });

    test('returns diets with expected data for the first item', () {
      final popularDiets = PopularDietsModel.getPopularDiets();

      if (popularDiets.isNotEmpty) {
        final firstDiet = popularDiets.first;
        expect(firstDiet.name, 'Blueberry Pancake');
        expect(firstDiet.iconPath, 'assets/icons/blueberry-pancake.svg');
        expect(firstDiet.level, 'Medium');
        expect(firstDiet.duration, '30mins');
        expect(firstDiet.calorie, '230kCal');
        expect(firstDiet.boxIsSelected, isTrue);
      } else {
        fail('getPopularDiets returned an empty list.');
      }
      expect(popularDiets.length, 4); // Based on current sample data
    });

    test('all popular diets have non-empty essential string properties', () {
      final popularDiets = PopularDietsModel.getPopularDiets();
      for (var diet in popularDiets) {
        expect(diet.name, isNotEmpty);
        expect(diet.iconPath, isNotEmpty);
        expect(diet.level, isNotEmpty);
        expect(diet.duration, isNotEmpty);
        expect(diet.calorie, isNotEmpty);
      }
    });

    test('at least one diet has boxIsSelected as true and one as false if multiple diets', () {
      final popularDiets = PopularDietsModel.getPopularDiets();
      if (popularDiets.length > 1) {
        expect(popularDiets.any((diet) => diet.boxIsSelected == true), isTrue, reason: "Expected at least one popular diet with boxIsSelected = true");
        expect(popularDiets.any((diet) => diet.boxIsSelected == false), isTrue, reason: "Expected at least one popular diet with boxIsSelected = false");
      } else if (popularDiets.isNotEmpty) {
        print("Single popular diet found, boxIsSelected: ${popularDiets.first.boxIsSelected}");
      }
    });
  });
}
