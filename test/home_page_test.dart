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
        // You can add more specific assertions for the SVG asset if needed,
        // though testing the exact asset path can be brittle.
        // For example, checking the colorFilter:
        final leadingSvgPicture = tester.widget<SvgPicture>(leadingIconFinder);
        expect(leadingSvgPicture.colorFilter, const ColorFilter.mode(Colors.black, BlendMode.srcIn));


        // Verify Action Icon (Right Button)
        final actionsIconButtons = find.descendant(
          of: appBar,
          matching: find.byType(IconButton),
        );
        // We expect two IconButtons in the AppBar: one in leading, one in actions
        // This finds the one in the 'actions' part
        expect(actionsIconButtons, findsNWidgets(2)); // Leading + Action

        final actionButtonFinder = find.descendant(
            of: find.byWidgetPredicate((widget) => widget is AppBar && widget.actions != null && widget.actions!.isNotEmpty),
            matching: find.byType(IconButton)
        ).first; // Taking the first one in the actions list
        expect(actionButtonFinder, findsOneWidget);


        final actionIconFinder = find.descendant(
          of: actionButtonFinder,
          matching: find.byType(SvgPicture),
        );
        expect(actionIconFinder, findsOneWidget);
        final actionSvgPicture = tester.widget<SvgPicture>(actionIconFinder);
        expect(actionSvgPicture.colorFilter, const ColorFilter.mode(Colors.black, BlendMode.srcIn));

      });

  testWidgets('HomePage left and right icon buttons are tappable', (WidgetTester tester) async {
    bool leftButtonPressed = false;
    bool rightButtonPressed = false;

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: HomePage(
          // You might need to pass down callbacks if they are defined in HomePage
          // and you want to test their invocation. For this example, we'll
          // assume the onPressed handlers are simple and directly in _HomePageState.
        ),
      ),
    ));

    // For more robust testing of onPressed, you might need to slightly refactor
    // HomePage to accept callbacks, or test the state changes if the onPressed
    // directly modifies state within _HomePageState.

    // Tap the leading IconButton
    final leadingButtonFinder = find.descendant(
      of: find.byType(AppBar),
      matching: find.byType(IconButton),
    ).first;
    await tester.tap(leadingButtonFinder);
    await tester.pump(); // Rebuild the widget after the tap.

    // Add assertions here if tapping the button changes state or calls a mockable function.
    // For now, we're just ensuring it doesn't crash.

    // Tap the action IconButton
    final actionButtonFinder = find.descendant(
        of: find.byWidgetPredicate((widget) => widget is AppBar && widget.actions != null && widget.actions!.isNotEmpty),
        matching: find.byType(IconButton)
    ).first;
    await tester.tap(actionButtonFinder);
    await tester.pump();

    // Add assertions here.
  });
}
