import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: const Center(
        child: Text('Your HomePage Content Here!'),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0, // Optional: Removes the shadow
      leading: IconButton(
        icon: SvgPicture.asset(
          'assets/icons/Arrow - Left.svg', // Replace with your Svg asset path
          width: 24, // Adjust size as needed
          height: 24, // Adjust size as needed
          colorFilter: const ColorFilter.mode(Colors.black, BlendMode.srcIn), // Ensures icon is black
        ),
        onPressed: () {
          // Handle left button press
        },
      ),
      title: const Text(
        'Breakfast',
        style: TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: true,
      actions: [
        IconButton(
          icon: SvgPicture.asset(
            'assets/icons/dots.svg', // Replace with your Svg asset path
            width: 5, // Adjust size as needed
            height: 5, // Adjust size as needed
            colorFilter: const ColorFilter.mode(Colors.black, BlendMode.srcIn), // Ensures icon is black
          ),
          onPressed: () {
            // Handle right button press
          },
        ),
      ],
    );
  }
}
