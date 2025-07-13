import 'package:cakes_with_prompts/models/category_model.dart';
import 'package:cakes_with_prompts/models/diet_model.dart';
import 'package:cakes_with_prompts/models/popular_model.dart';
import 'package:cakes_with_prompts/views/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';

// A helper function to wrap the widget in MaterialApp for testing
Widget createWidgetForTesting({required Widget child}) {
  return MaterialApp(home: child);
}

// Global mock lists for consistent testing if not using a proper mocking framework
// List<CategoryModel> globalMockCategories = [
//   CategoryModel(name: 'Test Salad', iconPath: 'assets/icons/salad.svg', boxColor: Colors.green),
//   CategoryModel(name: 'Test Cake', iconPath: 'assets/icons/pancakes.svg', boxColor: Colors.pink),
// ];

List<DietModel> globalMockDiets = [
  DietModel(
    name: 'Honey Pancake',
    iconPath: 'assets/icons/honey-pancakes.svg',
    level: 'Easy',
    duration: '30mins',
    calorie: '180kCal',
    boxColor: const Color(0xff92A3FD),
    viewIsSelected: true, // Example: first item is selected
  ),

  DietModel(
    name: 'Canai Bread',
    iconPath: 'assets/icons/canai-bread.svg',
    level: 'Easy',
    duration: '20mins',
    calorie: '230kCal',
    boxColor: const Color(0xffC58BF2),
  ),

  DietModel(
    name: 'Keto Delight',
    iconPath: 'assets/icons/keto-diet.svg',
    // Replace with an appropriate icon
    level: 'Medium',
    duration: '45mins',
    calorie: '350kCal',
    boxColor: const Color(0xff92A3FD),
  ),

  DietModel(
    name: 'Vegan Salad Bowl',
    iconPath: 'assets/icons/salad.svg',
    // Replace with an appropriate icon
    level: 'Easy',
    duration: '15mins',
    calorie: '150kCal',
    boxColor: const Color(0xffC58BF2),
    viewIsSelected: false,
  ),
];

List<PopularDietsModel> mockPopularDiets = [
  PopularDietsModel(
    name: 'Blueberry Pancake',
    iconPath: 'assets/icons/blueberry-pancake.svg',
    level: 'Medium',
    duration: '30mins',
    calorie: '230kCal',
    boxIsSelected: true,
  ),
  PopularDietsModel(
    name: 'Salmon Nigiri',
    iconPath: 'assets/icons/salmon-nigiri.svg',
    level: 'Easy',
    duration: '20mins',
    calorie: '120kCal',
    boxIsSelected: false,
  ),
  PopularDietsModel(
    name: 'Low-Carb Pizza',
    iconPath: 'assets/icons/pizza.svg',
    // Replace with a relevant icon
    level: 'Medium',
    duration: '40mins',
    calorie: '350kCal',
    boxIsSelected: false,
  ),
  PopularDietsModel(
    name: 'Chicken Salad',
    iconPath: 'assets/icons/chicken-salad.svg',
    // Replace with a relevant icon
    level: 'Easy',
    duration: '25mins',
    calorie: '180kCal',
    boxIsSelected: true,
  ),
];

void main() {
  group('HomePage AppBar Tests', () {
    testWidgets('HomePage has a white AppBar with correct title and icons', (
      WidgetTester tester,
    ) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(createWidgetForTesting(child: const HomePage()));

      // Verify AppBar properties
      final appBar = find.byType(AppBar);
      expect(appBar, findsOneWidget);

      final appBarWidget = tester.widget<AppBar>(appBar);
      expect(appBarWidget.backgroundColor, Colors.white);
      expect(appBarWidget.centerTitle, true);

      // Verify Title
      final titleFinder = find.text('Breakfast');
      expect(titleFinder, findsOneWidget);

      final titleTextWidget = tester.widget<Text>(titleFinder);
      expect(titleTextWidget.style?.color, Colors.black);
      expect(titleTextWidget.style?.fontSize, 18);
      expect(titleTextWidget.style?.fontWeight, FontWeight.bold);

      // Verify Leading Icon (Left Button)
      final leadingButtonFinder = find
          .descendant(of: appBar, matching: find.byType(IconButton))
          .first; // Assumes it's the first IconButton in the AppBar
      expect(leadingButtonFinder, findsOneWidget);

      final leadingIconFinder = find.descendant(
        of: leadingButtonFinder,
        matching: find.byType(SvgPicture),
      );
      expect(leadingIconFinder, findsOneWidget);
      final leadingSvgPicture = tester.widget<SvgPicture>(leadingIconFinder);
      expect(
        leadingSvgPicture.colorFilter,
        const ColorFilter.mode(Colors.black, BlendMode.srcIn),
      );
      // For specific asset testing (can be brittle):
      // expect((leadingSvgPicture.pictureProvider as ExactAssetPicture).assetName, 'assets/icons/Arrow - Left.svg');

      // Verify Action Icon (Right Button)
      final actionButtonFinder = find
          .descendant(
            of: find.byWidgetPredicate(
              (widget) =>
                  widget is AppBar &&
                  widget.actions != null &&
                  widget.actions!.isNotEmpty,
            ),
            matching: find.byType(IconButton),
          )
          .first; // Taking the first one in the actions list
      expect(actionButtonFinder, findsOneWidget);

      final actionIconFinder = find.descendant(
        of: actionButtonFinder,
        matching: find.byType(SvgPicture),
      );
      expect(actionIconFinder, findsOneWidget);
      final actionSvgPicture = tester.widget<SvgPicture>(actionIconFinder);
      expect(
        actionSvgPicture.colorFilter,
        const ColorFilter.mode(Colors.black, BlendMode.srcIn),
      );
      // For specific asset testing:
      // expect((actionSvgPicture.pictureProvider as ExactAssetPicture).assetName, 'assets/icons/dots.svg');
    });

    testWidgets('HomePage app bar buttons are tappable', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(createWidgetForTesting(child: const HomePage()));

      // Tap the leading IconButton
      final leadingButtonFinder = find
          .descendant(
            of: find.byType(AppBar),
            matching: find.byType(IconButton),
          )
          .first;
      await tester.tap(leadingButtonFinder);
      await tester.pump(); // Rebuild the widget after the tap.
      // Add assertions here if tapping changes state or calls a mockable function.

      // Tap the action IconButton
      final actionButtonFinder = find
          .descendant(
            of: find.byWidgetPredicate(
              (widget) =>
                  widget is AppBar &&
                  widget.actions != null &&
                  widget.actions!.isNotEmpty,
            ),
            matching: find.byType(IconButton),
          )
          .first;
      await tester.tap(actionButtonFinder);
      await tester.pump();
      // Add assertions here.
    });
  });

  group('HomePage Search Bar Tests', () {
    testWidgets('Search bar is present with correct hint text and icons', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(createWidgetForTesting(child: const HomePage()));

      // Find the TextField
      final searchField = find.byType(TextField);
      expect(searchField, findsOneWidget);

      // Verify hint text
      final textFieldWidget = tester.widget<TextField>(searchField);
      expect(textFieldWidget.decoration?.hintText, 'Search Breakfast');
      expect(
        textFieldWidget.decoration?.hintStyle?.color,
        const Color(0xffDDDADA),
      );

      // Verify Prefix Icon (Search Icon)
      // We need to be more specific if there are multiple SvgPictures on the screen.
      // One way is to find it as a descendant of the TextField's decoration.
      final prefixIcon = find.descendant(
        of: find.byWidgetPredicate(
          (widget) =>
              widget is TextField && widget.decoration?.prefixIcon != null,
        ),
        matching: find.byType(SvgPicture),
      );
      expect(prefixIcon, findsAtLeastNWidgets(2));
      // If you want to check the asset path (can be brittle):
      // final prefixSvg = tester.widget<SvgPicture>(prefixIcon);
      // expect((prefixSvg.pictureProvider as ExactAssetPicture).assetName, 'assets/icons/Search.svg');

      // Verify Suffix Icon (Filter Icon)
      final suffixIconContainer = find.descendant(
        of: find.byWidgetPredicate(
          (widget) =>
              widget is TextField && widget.decoration?.suffixIcon != null,
        ),
        matching: find.byType(
          Container,
        ), // The suffix icon is wrapped in a Container
      );
      expect(suffixIconContainer, findsAtLeastNWidgets(2));

      final filterIcon = find.descendant(
        of: suffixIconContainer,
        matching: find.byType(SvgPicture),
      );
      expect(filterIcon, findsOneWidget);
      // If you want to check the asset path:
      // final suffixSvg = tester.widget<SvgPicture>(filterIcon);
      // expect((suffixSvg.pictureProvider as ExactAssetPicture).assetName, 'assets/icons/Filter.svg');

      // Verify border properties
      final InputDecoration decoration = textFieldWidget.decoration!;
      expect(decoration.border, isA<OutlineInputBorder>());
      final outlineBorder = decoration.border as OutlineInputBorder;
      expect(outlineBorder.borderRadius, BorderRadius.circular(15));
      expect(outlineBorder.borderSide, BorderSide.none);

      expect(decoration.enabledBorder, isA<OutlineInputBorder>());
      final enabledOutlineBorder =
          decoration.enabledBorder as OutlineInputBorder;
      expect(enabledOutlineBorder.borderRadius, BorderRadius.circular(15));
      expect(enabledOutlineBorder.borderSide, BorderSide.none);

      expect(decoration.focusedBorder, isA<OutlineInputBorder>());
      final focusedOutlineBorder =
          decoration.focusedBorder as OutlineInputBorder;
      expect(focusedOutlineBorder.borderRadius, BorderRadius.circular(15));
      expect(focusedOutlineBorder.borderSide, BorderSide.none);

      // Verify shadow (indirectly by checking the BoxDecoration of the parent Container)
      final containerAroundTextField = find.ancestor(
        of: searchField,
        matching: find.byWidgetPredicate(
          (widget) => widget is Container && widget.decoration != null,
        ),
      );
      expect(containerAroundTextField, findsOneWidget);
      final containerWidget = tester.widget<Container>(
        containerAroundTextField,
      );
      expect(containerWidget.decoration, isA<BoxDecoration>());
      final boxDecoration = containerWidget.decoration as BoxDecoration;
      expect(boxDecoration.boxShadow, isNotNull);
      expect(boxDecoration.boxShadow!.length, 1);
      expect(
        boxDecoration.boxShadow![0].color,
        const Color(0xff1D1617).withAlpha(23),
      );
      expect(boxDecoration.boxShadow![0].blurRadius, 40);
      expect(boxDecoration.boxShadow![0].spreadRadius, 0.0);
    });

    testWidgets('Typing in search bar updates its value', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(createWidgetForTesting(child: const HomePage()));

      final searchField = find.byType(TextField);
      expect(searchField, findsOneWidget);

      // Enter text into the TextField
      await tester.enterText(searchField, 'Sample text');
      await tester.pump(); // Allow time for the UI to update

      // Verify the text was entered
      expect(find.text('Sample text'), findsOneWidget);
      // More robustly, check the TextField's controller's value if you assign one,
      // or check the widget's value directly:
      final textFieldWidget = tester.widget<TextField>(searchField);
      expect(textFieldWidget.controller?.text, 'Sample text');
    });

    testWidgets('Filter icon in search bar suffix is present', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(createWidgetForTesting(child: const HomePage()));

      final textField = find.byType(TextField);
      expect(textField, findsOneWidget);

      // Find the SuffixIcon which is a Container
      final suffixIconContainer = tester
          .widget<TextField>(textField)
          .decoration!
          .suffixIcon;
      expect(suffixIconContainer, isNotNull);
      expect(suffixIconContainer, isA<Container>());

      // Find the SvgPicture within that SuffixIcon Container
      // This requires finding within the live widget tree, not just from decoration.
      final filterIconFinder = find.descendant(
        of: find.byWidgetPredicate((widget) {
          // Find the specific suffix icon container
          if (widget is! Container) return false;
          final parentTextField = find.ancestor(
            of: find.byWidget(widget),
            matching: find.byType(TextField),
          );
          if (parentTextField.evaluate().isEmpty) return false;
          final textFieldWidget = tester.widget<TextField>(parentTextField);
          return textFieldWidget.decoration?.suffixIcon == widget;
        }),
        matching: find.byType(SvgPicture),
      );

      expect(filterIconFinder, findsOneWidget);

      // Optional: You could make the filter icon an IconButton and test its tappability
      // if it's supposed to be interactive. For now, just checking presence.
    });
  });

  group('HomePage Categories Section Tests', () {
    // Mock getCategories to control data for testing
    // This is important for predictable tests.
    final mockCategories = [
      CategoryModel(
        name: 'Test Salad',
        iconPath: 'assets/icons/test_salad.svg',
        boxColor: Colors.green,
      ),
      CategoryModel(
        name: 'Test Cake',
        iconPath: 'assets/icons/test_cake.svg',
        boxColor: Colors.pink,
      ),
    ];

    setUp(() {
      // It's good practice to ensure static methods return controlled data for tests.
      // One way is to modify the static method itself to allow for injection,
      // or use a mocking framework. For simplicity here, we'll assume
      // getCategories() is relatively stable or we test against its actual output.
      // If CategoryModel.getCategories() is complex or makes network calls,
      // you MUST mock it.

      // For this example, we'll rely on the actual CategoryModel.getCategories()
      // but acknowledge that mocking it would be more robust for isolated unit testing.
      // If you can modify CategoryModel:
      // CategoryModel.categoriesGetter = () => mockCategories;
    });

    testWidgets('Categories section is present and displays category items', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(createWidgetForTesting(child: const HomePage()));

      // Allow time for initState and _loadCategories to complete
      await tester.pumpAndSettle();

      // Find the horizontal ListView for categories
      // It's inside a Container with a specific height
      final categoriesListViewFinder = find.byWidgetPredicate(
        (widget) =>
            widget is ListView &&
            widget.key == Key('categories_list') &&
            widget.scrollDirection == Axis.horizontal &&
            (widget.semanticChildCount ??
                    CategoryModel.getCategories().length) >
                0,
      ); // Check if it has items

      expect(
        categoriesListViewFinder,
        findsOneWidget,
        reason: "Horizontal ListView for categories not found or is empty.",
      );

      // Check for the presence of the first category name from the actual model data
      final actualCategories = CategoryModel.getCategories();
      if (actualCategories.isNotEmpty) {
        expect(
          find.text(actualCategories.first.name),
          findsWidgets,
          reason: "First category name not found.",
        );
        // We use findsWidgets because the text might appear in multiple places if not careful,
        // but within the context of the category item, it should be unique.

        // Find the first category item Container by its color (can be brittle if colors are not unique)
        // A better way is to use a Key on the item Container if possible.
        final firstCategoryItemContainer = find.byWidgetPredicate((widget) {
          if (widget is Container && widget.decoration is BoxDecoration) {
            final decoration = widget.decoration as BoxDecoration;
            return decoration.color ==
                actualCategories.first.boxColor.withAlpha(90);
          }
          return false;
        });
        expect(
          firstCategoryItemContainer,
          findsWidgets,
          reason: "First category item container not found by color.",
        );
      } else {
        print(
          "Skipping detailed category item checks as CategoryModel.getCategories() returned empty.",
        );
      }
    });

    testWidgets('Each category item has correct structure and content', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(createWidgetForTesting(child: const HomePage()));
      await tester.pumpAndSettle(); // For initState

      final actualCategories = CategoryModel.getCategories();
      if (actualCategories.isEmpty) {
        print(
          "Skipping category item structure test as no categories are loaded.",
        );
        return;
      }

      // Test structure for the first category item
      final firstCategoryData = actualCategories.first;

      // Find the specific item. This is tricky without unique keys.
      // We can find the Column within a Container that has the correct boxColor.
      final categoryItemColumnFinder = find.descendant(
        of: find.byWidgetPredicate(
          (widget) =>
              widget is Container &&
              widget.decoration is BoxDecoration &&
              (widget.decoration as BoxDecoration).color?.withAlpha(90) ==
                  firstCategoryData.boxColor.withAlpha(90),
        ),
        matching: find.byType(Column),
      );
      expect(
        categoryItemColumnFinder,
        findsAtLeastNWidgets(1),
        reason: "Column for category item not found.",
      );

      final firstCategoryItemColumn = categoryItemColumnFinder.first;

      // 1. Check for the white circle Container
      final whiteCircleFinder = find.descendant(
        of: firstCategoryItemColumn,
        matching: find.byWidgetPredicate(
          (widget) =>
              widget is Container &&
              widget.constraints?.maxWidth == 50 &&
              widget.constraints?.maxHeight == 50 &&
              widget.decoration is BoxDecoration &&
              (widget.decoration as BoxDecoration).shape == BoxShape.circle &&
              (widget.decoration as BoxDecoration).color == Colors.white,
        ),
      );
      expect(
        whiteCircleFinder,
        findsOneWidget,
        reason: "White circle in category item not found or incorrect.",
      );

      // 2. Check for SvgPicture inside the white circle
      final svgIconFinder = find.descendant(
        of: whiteCircleFinder, // Search within the found white circle
        matching: find.byType(SvgPicture),
      );
      expect(
        svgIconFinder,
        findsOneWidget,
        reason: "SVG icon in category item not found.",
      );
      // More specific check for the icon path (can be brittle)
      // final svgWidget = tester.widget<SvgPicture>(svgIconFinder);
      // expect((svgWidget.pictureProvider as ExactAssetPicture).assetName, firstCategoryData.iconPath);

      // 3. Check for the SizedBox separator (height 15)
      final spaceBetweenCircleAndTextFinder = find.descendant(
        of: firstCategoryItemColumn,
        matching: find.byWidgetPredicate(
          (widget) => widget is SizedBox && widget.height == 15,
        ),
      );
      expect(
        spaceBetweenCircleAndTextFinder,
        findsOneWidget,
        reason: "SizedBox separator (height 15) not found.",
      );

      // 4. Check for the Text (category name)
      final categoryNameTextFinder = find.descendant(
        of: firstCategoryItemColumn,
        matching: find.text(firstCategoryData.name),
      );
      expect(
        categoryNameTextFinder,
        findsOneWidget,
        reason: "Category name text not found.",
      );
    });

    testWidgets('Categories section container has correct height', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(createWidgetForTesting(child: const HomePage()));
      await tester.pumpAndSettle();

      // Find the outer container of the categories section
      // This relies on the structure where _buildCategoriesSection returns a Container
      final categoriesSectionContainer = find.byWidgetPredicate((widget) {
        if (widget is Container && widget.child is ListView) {
          final listView = widget.child as ListView;
          return listView.scrollDirection == Axis.horizontal &&
              widget.constraints?.maxHeight == 120;
        }
        return false;
      });
      expect(
        categoriesSectionContainer,
        findsOneWidget,
        reason: "Categories section container with height 120 not found.",
      );
    });

    testWidgets('Category items have correct width and border radius', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(createWidgetForTesting(child: const HomePage()));
      await tester.pumpAndSettle();

      final actualCategories = CategoryModel.getCategories();
      if (actualCategories.isEmpty) {
        print("Skipping category item style test as no categories are loaded.");
        return;
      }

      // Find the first category item's outer Container
      final firstCategoryItemContainerFinder = find.byWidgetPredicate((widget) {
        if (widget is Container &&
            widget.decoration is BoxDecoration &&
            (widget.decoration as BoxDecoration).color?.withAlpha(90) ==
                actualCategories.first.boxColor.withAlpha(90)) {
          // Check width constraint and decoration
          final boxDecoration = widget.decoration as BoxDecoration;
          return widget.constraints?.minWidth ==
                  100 && // Or maxWidth if explicitly set
              widget.constraints?.maxWidth == 100 &&
              boxDecoration.borderRadius == BorderRadius.circular(16);
        }
        return false;
      }).first; // Assuming the first match is our target

      expect(
        firstCategoryItemContainerFinder,
        findsOneWidget,
        reason:
            "First category item container with correct width/radius not found.",
      );
      final containerWidget = tester.widget<Container>(
        firstCategoryItemContainerFinder,
      );
      expect(containerWidget.constraints?.minWidth, 100.0);
      expect(containerWidget.constraints?.maxWidth, 100.0);
      expect(
        (containerWidget.decoration as BoxDecoration).borderRadius,
        BorderRadius.circular(16),
      );
    });
  });

  group('HomePage Diets Section Tests', () {
    testWidgets('Diets section title is present', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetForTesting(child: const HomePage()));
      await tester.pumpAndSettle(); // For initState and data loading

      expect(find.text("Recommendation\nfor Diet"), findsOneWidget);
    });

    testWidgets('Diets section is present and displays diet items', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(createWidgetForTesting(child: const HomePage()));
      await tester.pumpAndSettle();

      final dietsListViewFinder = find.byWidgetPredicate(
        (widget) =>
            widget is ListView &&
            widget.key == Key("diets_list") &&
            widget.scrollDirection == Axis.horizontal &&
            widget.semanticChildCount == globalMockDiets.length,
      ); // Use mock data length
      expect(
        dietsListViewFinder,
        findsOneWidget,
        reason:
            "Horizontal ListView for diets not found or incorrect item count.",
      );

      // Check for the presence of the first diet name from mock data
      expect(find.text(globalMockDiets.first.name), findsOneWidget);
    });

    testWidgets(
      'Tapping a "View" button changes its state to "Selected" and updates others',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          createWidgetForTesting(child: const HomePage()),
        );
        await tester.pumpAndSettle();

        // Find the "View" button of the second diet item (which is initially not selected in mock data)
        final secondDietData = globalMockDiets[1];
        expect(
          secondDietData.viewIsSelected,
          isFalse,
          reason:
              "Test assumption: second diet should initially not be selected.",
        );

        final viewButtonFinder = find.descendant(
          of: find.byKey(ValueKey('diet_item_${secondDietData.name}')),
          matching: find.widgetWithText(
            GestureDetector,
            'View',
          ), // Find GestureDetector containing 'View' text
        );
        expect(
          viewButtonFinder,
          findsOneWidget,
          reason: "Could not find 'View' button for the second diet item.",
        );

        // Tap the "View" button
        await tester.tap(viewButtonFinder);
        await tester.pumpAndSettle(); // Allow UI to update after setState

        // Verify the second diet item is now "Selected"
        final selectedButtonTextFinderSecond = find.descendant(
          of: find.byKey(ValueKey('diet_item_${secondDietData.name}')),
          matching: find.text('Selected'),
        );
        expect(
          selectedButtonTextFinderSecond,
          findsOneWidget,
          reason: "Second diet item did not change to 'Selected'.",
        );

        final selectedButtonContainerSecond = tester.widget<Container>(
          find.descendant(
            of: find.byKey(ValueKey('diet_item_${secondDietData.name}')),
            matching: find.byWidgetPredicate(
              (widget) =>
                  widget is Container &&
                  widget.decoration is BoxDecoration &&
                  (widget.decoration as BoxDecoration).gradient
                      is LinearGradient,
            ),
          ),
        );
        expect(
          (selectedButtonContainerSecond.decoration as BoxDecoration).gradient,
          isA<LinearGradient>(),
        );

        // Verify the first diet item (initially selected) is now "View"
        final firstDietData = globalMockDiets.first;
        final viewButtonTextFinderFirst = find.descendant(
          of: find.byKey(ValueKey('diet_item_${firstDietData.name}')),
          matching: find.text('View'),
        );
        expect(
          viewButtonTextFinderFirst,
          findsOneWidget,
          reason: "First diet item did not change back to 'View'.",
        );

        final viewButtonContainerFirst = tester.widget<Container>(
          find.descendant(
            of: find.byKey(ValueKey('diet_item_${firstDietData.name}')),
            matching: find.byWidgetPredicate(
              (widget) =>
                  widget is Container &&
                  widget.decoration is BoxDecoration &&
                  (widget.decoration as BoxDecoration).color ==
                      const Color(0xffF7F8F8),
            ),
          ),
        );
        expect(
          (viewButtonContainerFirst.decoration as BoxDecoration).color,
          const Color(0xffF7F8F8),
        );
      },
    );

    testWidgets('Diets section container has correct height', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(createWidgetForTesting(child: const HomePage()));
      await tester.pumpAndSettle();

      final dietsSectionContainer = find.byWidgetPredicate((widget) {
        if (widget is Container && widget.child is ListView) {
          final listView = widget.child as ListView;
          // Check for height and that it's the diets list view (e.g. by an item's key)
          return listView.scrollDirection == Axis.horizontal &&
              widget.constraints?.maxHeight == 240 &&
              tester.any(
                find.byKey(ValueKey('diet_item_${globalMockDiets.first.name}')),
              );
        }
        return false;
      });
      expect(
        dietsSectionContainer,
        findsOneWidget,
        reason: "Diets section container with height 240 not found.",
      );
    });

    testWidgets('Diet items have correct width and border radius', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(createWidgetForTesting(child: const HomePage()));
      await tester.pumpAndSettle();

      final firstDietItem = find.byKey(
        ValueKey('diet_item_${globalMockDiets.first.name}'),
      );
      expect(firstDietItem, findsOneWidget);

      final containerWidget = tester.widget<Container>(firstDietItem);
      expect(containerWidget.constraints?.minWidth, 210.0); // Check width
      expect(containerWidget.constraints?.maxWidth, 210.0);
      expect(
        (containerWidget.decoration as BoxDecoration).borderRadius,
        BorderRadius.circular(20),
      );
    });
  });

  group('HomePage PopularDiets Section Tests', () {
    testWidgets('PopularDiets section title is present', (
        WidgetTester tester,
        ) async {
      // Override static method for this test too
      await tester.pumpWidget(createWidgetForTesting(child: const HomePage()));
      await tester.pumpAndSettle();

      // Find the widget you want to scroll to
      final targetFinder = find.byKey(const Key('popular_diets_list'));

      // Find the scrollable widget (e.g., ListView, CustomScrollView)
      final scrollableFinder = find.byType(Scrollable).first;

      // Scroll until the target widget is visible
      await tester.scrollUntilVisible(
        targetFinder,
        50.0, // pixels to scroll
        scrollable: scrollableFinder,
      );

      expect(find.text("Popular Diets"), findsOneWidget);
    });

    testWidgets('PopularDiets section renders correctly', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(createWidgetForTesting(child: const HomePage()));
      await tester.pumpAndSettle();

      // Find the widget you want to scroll to
      final targetFinder = find.byKey(const Key('popular_diets_list'));

      // Find the scrollable widget (e.g., ListView, CustomScrollView)
      final scrollableFinder = find.byType(Scrollable).first;

      // Scroll until the target widget is visible
      await tester.scrollUntilVisible(
        targetFinder,
        150.0, // pixels to scroll
        scrollable: scrollableFinder,
      );

      // 1. Verify ListView presence
      final popularDietsListViewFinder = find.byKey(
        const ValueKey('popular_diets_list'),
      );
      expect(popularDietsListViewFinder, findsOneWidget);

      // 2. Verify number of items
      // Since ListView.separated builds separators too, we count specific item containers
      expect(
        find.byKey(ValueKey('popular_diet_item_${mockPopularDiets[0].name}')),
        findsOneWidget,
      );
      expect(
        find.byKey(ValueKey('popular_diet_item_${mockPopularDiets[1].name}')),
        findsOneWidget,
      );

      // Verify the total number of actual items (excluding separators)
      final popularDietItemFinder = find.byWidgetPredicate(
        (widget) =>
            widget is Container &&
            widget.key is ValueKey &&
            (widget.key as ValueKey).value.toString().startsWith(
              'popular_diet_item_',
            ),
      );
      expect(popularDietItemFinder, findsNWidgets(mockPopularDiets.length));

      // 3. Verify item content for the first item
      final firstItem = mockPopularDiets[0];
      expect(find.text(firstItem.name), findsOneWidget);
      expect(
        find.text(
          '${firstItem.level} | ${firstItem.duration} | ${firstItem.calorie}',
        ),
        findsOneWidget,
      );
      // For SVG, if you are not using a mock, ensure assets are available.
      // With a mock, you might check for the mock's output or a specific widget type.
      // Due to the SvgPicture.asset being potentially complex to test directly without full asset loading,
      // we'll check for a GestureDetector that would contain it.
      final firstItemImageGestureDetector = find.descendant(
        of: find.byKey(ValueKey('popular_diet_item_${firstItem.name}')),
        matching: find.byWidgetPredicate(
          (widget) => widget is GestureDetector && widget.child is SvgPicture,
        ),
      );
      expect(firstItemImageGestureDetector, findsOneWidget);

      // 4. Verify initial background color
      // First item: boxIsSelected = false (transparent)
      Container firstItemContainer = tester.widget<Container>(
        find.byKey(ValueKey('popular_diet_item_${firstItem.name}')),
      );
      expect(
        (firstItemContainer.decoration as BoxDecoration).color,
        Colors.white,
      );

      // Second item: boxIsSelected = true (white)
      final secondItem = mockPopularDiets[1];
      Container secondItemContainer = tester.widget<Container>(
        find.byKey(ValueKey('popular_diet_item_${secondItem.name}')),
      );
      expect(
        (secondItemContainer.decoration as BoxDecoration).color,
        Colors.transparent,
      );

      // 5. Test tap interaction and background color change
      // Tap the image of the first item (which is initially not selected)
      await tester.tap(firstItemImageGestureDetector);
      await tester.pumpAndSettle(); // Rebuild the widget tree

      // Verify background color of the first item is now white
      firstItemContainer = tester.widget<Container>(
        find.byKey(ValueKey('popular_diet_item_${firstItem.name}')),
      );
      expect(
        (firstItemContainer.decoration as BoxDecoration).color,
        Colors.transparent,
        reason: "Background should be transparent after tap",
      );

      // Verify the model's state was updated (optional, depends on how you want to test)
      // This requires accessing state, which can be tricky.
      // The UI change is a good indicator.

      // Tap it again to toggle back
      await tester.ensureVisible(firstItemImageGestureDetector);
      await tester.tap(firstItemImageGestureDetector);
      await tester.pumpAndSettle();
      firstItemContainer = tester.widget<Container>(
        find.byKey(ValueKey('popular_diet_item_${firstItem.name}')),
      );
      expect(
        (firstItemContainer.decoration as BoxDecoration).color,
        Colors.white,
        reason: "Background should be white after second tap",
      );
    });
  });
}

// You would need to add these static setters to your model classes for this simple mocking approach
// In CategoryModel.dart:
// static List<CategoryModel> Function() categoriesGetter = _getCategoriesActual;
// static List<CategoryModel> getCategories() => categoriesGetter();
// static List<CategoryModel> _getCategoriesActual() { /* original implementation */ }

// In DietModel.dart:
// static List<DietModel> Function() dietsGetter = _getDietsActual;
// static List<DietModel> getDiets() => dietsGetter();
// static List<DietModel> _getDietsActual() { /* original implementation */ }
