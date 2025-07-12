import 'package:cakes_with_prompts/models/category_model.dart';
import 'package:flutter/material.dart'; // For Color
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CategoryModel', () {
    test('Constructor creates a valid CategoryModel instance', () {
      // Arrange
      const name = 'Test Category';
      const iconPath = 'assets/icons/test_icon.svg';
      const boxColor = Colors.blue;

      // Act
      final model = CategoryModel(
        name: name,
        iconPath: iconPath,
        boxColor: boxColor,
      );

      // Assert
      expect(model.name, name);
      expect(model.iconPath, iconPath);
      expect(model.boxColor, boxColor);
    });

    test('Instances with same values should be equal', () {
      final model1 = CategoryModel(
        name: 'Salad',
        iconPath: 'assets/icons/plate.svg',
        boxColor: const Color(0xff92A3FD),
      );
      final model2 = CategoryModel(
        name: 'Salad',
        iconPath: 'assets/icons/plate.svg',
        boxColor: const Color(0xff92A3FD),
      );
      final model3 = CategoryModel(
        name: 'Cake',
        iconPath: 'assets/icons/pancakes.svg',
        boxColor: const Color(0xffC58BF2),
      );

      expect(model1 == model2, isTrue);
      expect(model1.hashCode == model2.hashCode, isTrue);
      expect(model1 == model3, isFalse);
    });

    test('toString() returns a readable string representation', () {
      final model = CategoryModel(
        name: 'Pie',
        iconPath: 'assets/icons/pie.svg',
        boxColor: Colors.green,
      );
      expect(
        model.toString(),
        'CategoryModel{name: Pie, iconPath: assets/icons/pie.svg, boxColor: ${Colors.green}}',
      );
    });
  });

  group('CategoryModel.getCategories', () {
    test('returns a non-empty list of CategoryModel objects', () {
      // Act
      final categories = CategoryModel.getCategories();

      // Assert
      expect(categories, isNotEmpty);
      expect(categories, isA<List<CategoryModel>>());
      expect(categories.every((category) => category is CategoryModel), isTrue);
    });

    test('returns categories with expected data', () {
      // Act
      final categories = CategoryModel.getCategories();

      // Assert
      // Check the first category as an example
      if (categories.isNotEmpty) {
        final firstCategory = categories.first;
        expect(firstCategory.name, 'Salad');
        expect(firstCategory.iconPath, 'assets/icons/plate.svg');
        expect(firstCategory.boxColor, const Color(0xff92A3FD));
      } else {
        fail('getCategories returned an empty list, cannot check first item.');
      }

      // You can add more specific checks for other categories if needed
      expect(categories.length, 4); // Based on the current implementation
    });

    test('all categories have non-empty names and iconPaths', () {
      final categories = CategoryModel.getCategories();
      for (var category in categories) {
        expect(category.name, isNotEmpty);
        expect(category.iconPath, isNotEmpty);
        // You could also add a check for valid asset paths if you have a helper for it
      }
    });
  });
}
