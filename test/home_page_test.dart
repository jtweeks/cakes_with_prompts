import 'package:cakes_with_prompts/models/category_model.dart';
import 'package:cakes_with_prompts/views/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';

// A helper function to wrap the widget in MaterialApp for testing
Widget createWidgetForTesting({required Widget child}) {
  return MaterialApp(
    home: child,
  );
}

void main() {
  group('HomePage AppBar Tests', () {
    testWidgets('HomePage has a white AppBar with correct title and icons',
            (WidgetTester tester) async {
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
          final leadingButtonFinder = find.descendant(
            of: appBar,
            matching: find.byType(IconButton),
          ).first; // Assumes it's the first IconButton in the AppBar
          expect(leadingButtonFinder, findsOneWidget);

          final leadingIconFinder = find.descendant(
            of: leadingButtonFinder,
            matching: find.byType(SvgPicture),
          );
          expect(leadingIconFinder, findsOneWidget);
          final leadingSvgPicture = tester.widget<SvgPicture>(leadingIconFinder);
          expect(leadingSvgPicture.colorFilter,
              const ColorFilter.mode(Colors.black, BlendMode.srcIn));
          // For specific asset testing (can be brittle):
          // expect((leadingSvgPicture.pictureProvider as ExactAssetPicture).assetName, 'assets/icons/Arrow - Left.svg');

          // Verify Action Icon (Right Button)
          final actionButtonFinder = find.descendant(
            of: find.byWidgetPredicate((widget) =>
            widget is AppBar &&
                widget.actions != null &&
                widget.actions!.isNotEmpty),
            matching: find.byType(IconButton),
          ).first; // Taking the first one in the actions list
          expect(actionButtonFinder, findsOneWidget);

          final actionIconFinder = find.descendant(
            of: actionButtonFinder,
            matching: find.byType(SvgPicture),
          );
          expect(actionIconFinder, findsOneWidget);
          final actionSvgPicture = tester.widget<SvgPicture>(actionIconFinder);
          expect(actionSvgPicture.colorFilter,
              const ColorFilter.mode(Colors.black, BlendMode.srcIn));
          // For specific asset testing:
          // expect((actionSvgPicture.pictureProvider as ExactAssetPicture).assetName, 'assets/icons/dots.svg');
        });

    testWidgets('HomePage app bar buttons are tappable',
            (WidgetTester tester) async {
          await tester.pumpWidget(createWidgetForTesting(child: const HomePage()));

          // Tap the leading IconButton
          final leadingButtonFinder = find.descendant(
            of: find.byType(AppBar),
            matching: find.byType(IconButton),
          ).first;
          await tester.tap(leadingButtonFinder);
          await tester.pump(); // Rebuild the widget after the tap.
          // Add assertions here if tapping changes state or calls a mockable function.

          // Tap the action IconButton
          final actionButtonFinder = find.descendant(
            of: find.byWidgetPredicate((widget) =>
            widget is AppBar &&
                widget.actions != null &&
                widget.actions!.isNotEmpty),
            matching: find.byType(IconButton),
          ).first;
          await tester.tap(actionButtonFinder);
          await tester.pump();
          // Add assertions here.
        });
  });

  group('HomePage Search Bar Tests', () {
    testWidgets('Search bar is present with correct hint text and icons',
            (WidgetTester tester) async {
          await tester.pumpWidget(createWidgetForTesting(child: const HomePage()));

          // Find the TextField
          final searchField = find.byType(TextField);
          expect(searchField, findsOneWidget);

          // Verify hint text
          final textFieldWidget = tester.widget<TextField>(searchField);
          expect(textFieldWidget.decoration?.hintText, 'Search Breakfast');
          expect(textFieldWidget.decoration?.hintStyle?.color, const Color(0xffDDDADA));

          // Verify Prefix Icon (Search Icon)
          // We need to be more specific if there are multiple SvgPictures on the screen.
          // One way is to find it as a descendant of the TextField's decoration.
          final prefixIcon = find.descendant(
              of: find.byWidgetPredicate((widget) => widget is TextField && widget.decoration?.prefixIcon != null),
              matching: find.byType(SvgPicture)
          );
          expect(prefixIcon, findsAtLeastNWidgets(2));
          // If you want to check the asset path (can be brittle):
          // final prefixSvg = tester.widget<SvgPicture>(prefixIcon);
          // expect((prefixSvg.pictureProvider as ExactAssetPicture).assetName, 'assets/icons/Search.svg');


          // Verify Suffix Icon (Filter Icon)
          final suffixIconContainer = find.descendant(
              of: find.byWidgetPredicate((widget) => widget is TextField && widget.decoration?.suffixIcon != null),
              matching: find.byType(Container) // The suffix icon is wrapped in a Container
          );
          expect(suffixIconContainer, findsAtLeastNWidgets(2));

          final filterIcon = find.descendant(
              of: suffixIconContainer,
              matching: find.byType(SvgPicture)
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
          final enabledOutlineBorder = decoration.enabledBorder as OutlineInputBorder;
          expect(enabledOutlineBorder.borderRadius, BorderRadius.circular(15));
          expect(enabledOutlineBorder.borderSide, BorderSide.none);

          expect(decoration.focusedBorder, isA<OutlineInputBorder>());
          final focusedOutlineBorder = decoration.focusedBorder as OutlineInputBorder;
          expect(focusedOutlineBorder.borderRadius, BorderRadius.circular(15));
          expect(focusedOutlineBorder.borderSide, BorderSide.none);

          // Verify shadow (indirectly by checking the BoxDecoration of the parent Container)
          final containerAroundTextField = find.ancestor(
            of: searchField,
            matching: find.byWidgetPredicate(
                    (widget) => widget is Container && widget.decoration != null),
          );
          expect(containerAroundTextField, findsOneWidget);
          final containerWidget = tester.widget<Container>(containerAroundTextField);
          expect(containerWidget.decoration, isA<BoxDecoration>());
          final boxDecoration = containerWidget.decoration as BoxDecoration;
          expect(boxDecoration.boxShadow, isNotNull);
          expect(boxDecoration.boxShadow!.length, 1);
          expect(boxDecoration.boxShadow![0].color, const Color(0xff1D1617).withOpacity(0.07));
          expect(boxDecoration.boxShadow![0].blurRadius, 40);
          expect(boxDecoration.boxShadow![0].spreadRadius, 0.0);
        });

    testWidgets('Typing in search bar updates its value',
            (WidgetTester tester) async {
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

    testWidgets('Filter icon in search bar suffix is present', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetForTesting(child: const HomePage()));

      final textField = find.byType(TextField);
      expect(textField, findsOneWidget);

      // Find the SuffixIcon which is a Container
      final suffixIconContainer = tester.widget<TextField>(textField).decoration!.suffixIcon;
      expect(suffixIconContainer, isNotNull);
      expect(suffixIconContainer, isA<Container>());

      // Find the SvgPicture within that SuffixIcon Container
      // This requires finding within the live widget tree, not just from decoration.
      final filterIconFinder = find.descendant(
          of: find.byWidgetPredicate((widget) { // Find the specific suffix icon container
            if (widget is! Container) return false;
            final parentTextField = find.ancestor(of: find.byWidget(widget), matching: find.byType(TextField));
            if (parentTextField.evaluate().isEmpty) return false;
            final textFieldWidget = tester.widget<TextField>(parentTextField);
            return textFieldWidget.decoration?.suffixIcon == widget;
          }),
          matching: find.byType(SvgPicture)
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
      CategoryModel(name: 'Test Salad', iconPath: 'assets/icons/test_salad.svg', boxColor: Colors.green),
      CategoryModel(name: 'Test Cake', iconPath: 'assets/icons/test_cake.svg', boxColor: Colors.pink),
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

    testWidgets('Categories section is present and displays category items', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetForTesting(child: const HomePage()));

      // Allow time for initState and _loadCategories to complete
      await tester.pumpAndSettle();

      // Find the horizontal ListView for categories
      // It's inside a Container with a specific height
      final categoriesListViewFinder = find.byWidgetPredicate((widget) =>
      widget is ListView &&
          widget.scrollDirection == Axis.horizontal &&
          (widget.semanticChildCount ?? CategoryModel.getCategories().length) > 0); // Check if it has items

      expect(categoriesListViewFinder, findsOneWidget, reason: "Horizontal ListView for categories not found or is empty.");

      // Check for the presence of the first category name from the actual model data
      final actualCategories = CategoryModel.getCategories();
      if (actualCategories.isNotEmpty) {
        expect(find.text(actualCategories.first.name), findsWidgets, reason: "First category name not found.");
        // We use findsWidgets because the text might appear in multiple places if not careful,
        // but within the context of the category item, it should be unique.

        // Find the first category item Container by its color (can be brittle if colors are not unique)
        // A better way is to use a Key on the item Container if possible.
        final firstCategoryItemContainer = find.byWidgetPredicate((widget) {
          if (widget is Container && widget.decoration is BoxDecoration) {
            final decoration = widget.decoration as BoxDecoration;
            return decoration.color == actualCategories.first.boxColor;
          }
          return false;
        });
        expect(firstCategoryItemContainer, findsWidgets, reason: "First category item container not found by color.");
      } else {
        print("Skipping detailed category item checks as CategoryModel.getCategories() returned empty.");
      }
    });

    testWidgets('Each category item has correct structure and content', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetForTesting(child: const HomePage()));
      await tester.pumpAndSettle(); // For initState

      final actualCategories = CategoryModel.getCategories();
      if (actualCategories.isEmpty) {
        print("Skipping category item structure test as no categories are loaded.");
        return;
      }

      // Test structure for the first category item
      final firstCategoryData = actualCategories.first;

      // Find the specific item. This is tricky without unique keys.
      // We can find the Column within a Container that has the correct boxColor.
      final categoryItemColumnFinder = find.descendant(
        of: find.byWidgetPredicate((widget) =>
        widget is Container &&
            widget.decoration is BoxDecoration &&
            (widget.decoration as BoxDecoration).color == firstCategoryData.boxColor
        ),
        matching: find.byType(Column),
      );
      expect(categoryItemColumnFinder, findsAtLeastNWidgets(1), reason: "Column for category item not found.");

      final firstCategoryItemColumn = categoryItemColumnFinder.first;

      // 1. Check for the white circle Container
      final whiteCircleFinder = find.descendant(
        of: firstCategoryItemColumn,
        matching: find.byWidgetPredicate((widget) =>
        widget is Container &&
            widget.constraints?.maxWidth == 50 &&
            widget.constraints?.maxHeight == 50 &&
            widget.decoration is BoxDecoration &&
            (widget.decoration as BoxDecoration).shape == BoxShape.circle &&
            (widget.decoration as BoxDecoration).color == Colors.white),
      );
      expect(whiteCircleFinder, findsOneWidget, reason: "White circle in category item not found or incorrect.");

      // 2. Check for SvgPicture inside the white circle
      final svgIconFinder = find.descendant(
        of: whiteCircleFinder, // Search within the found white circle
        matching: find.byType(SvgPicture),
      );
      expect(svgIconFinder, findsOneWidget, reason: "SVG icon in category item not found.");
      // More specific check for the icon path (can be brittle)
      // final svgWidget = tester.widget<SvgPicture>(svgIconFinder);
      // expect((svgWidget.pictureProvider as ExactAssetPicture).assetName, firstCategoryData.iconPath);

      // 3. Check for the SizedBox separator (height 15)
      final spaceBetweenCircleAndTextFinder = find.descendant(
        of: firstCategoryItemColumn,
        matching: find.byWidgetPredicate((widget) => widget is SizedBox && widget.height == 15),
      );
      expect(spaceBetweenCircleAndTextFinder, findsOneWidget, reason: "SizedBox separator (height 15) not found.");


      // 4. Check for the Text (category name)
      final categoryNameTextFinder = find.descendant(
        of: firstCategoryItemColumn,
        matching: find.text(firstCategoryData.name),
      );
      expect(categoryNameTextFinder, findsOneWidget, reason: "Category name text not found.");
    });

    testWidgets('Categories section container has correct height', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetForTesting(child: const HomePage()));
      await tester.pumpAndSettle();

      // Find the outer container of the categories section
      // This relies on the structure where _buildCategoriesSection returns a Container
      final categoriesSectionContainer = find.byWidgetPredicate((widget) {
        if (widget is Container && widget.child is ListView) {
          final listView = widget.child as ListView;
          return listView.scrollDirection == Axis.horizontal && widget.constraints?.maxHeight == 120;
        }
        return false;
      });
      expect(categoriesSectionContainer, findsOneWidget, reason: "Categories section container with height 120 not found.");
    });


    testWidgets('Category items have correct width and border radius', (WidgetTester tester) async {
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
            (widget.decoration as BoxDecoration).color == actualCategories.first.boxColor) {
          // Check width constraint and decoration
          final boxDecoration = widget.decoration as BoxDecoration;
          return widget.constraints?.minWidth == 100 && // Or maxWidth if explicitly set
              widget.constraints?.maxWidth == 100 &&
              boxDecoration.borderRadius == BorderRadius.circular(16);
        }
        return false;
      }).first; // Assuming the first match is our target

      expect(firstCategoryItemContainerFinder, findsOneWidget, reason: "First category item container with correct width/radius not found.");
      final containerWidget = tester.widget<Container>(firstCategoryItemContainerFinder);
      expect(containerWidget.constraints?.minWidth, 100.0);
      expect(containerWidget.constraints?.maxWidth, 100.0);
      expect((containerWidget.decoration as BoxDecoration).borderRadius, BorderRadius.circular(16));
    });

  });
}
