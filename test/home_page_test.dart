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
          await tester.enterText(searchField, 'Pancakes');
          await tester.pump(); // Allow time for the UI to update

          // Verify the text was entered
          expect(find.text('Pancakes'), findsOneWidget);
          // More robustly, check the TextField's controller's value if you assign one,
          // or check the widget's value directly:
          final textFieldWidget = tester.widget<TextField>(searchField);
          expect(textFieldWidget.controller?.text, 'Pancakes');
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
}
