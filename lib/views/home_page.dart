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
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          _buildSearchField(), // Add the search field here
          // Add other ListView children below if needed
        ],
      ),
    );
  }

  Widget _buildSearchField() {
    final TextEditingController _searchController = TextEditingController();
    return Container(
      margin: const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 20),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: const Color(0xff1D1617).withOpacity(0.07),
            blurRadius: 40,
            spreadRadius: 0.0,
          )
        ],
      ),
      child: TextField(
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintText: 'Search Breakfast',
          hintStyle: const TextStyle(
            color: Color(0xffDDDADA),
            fontSize: 14,
          ),
          prefixIcon: Padding(
            padding: const EdgeInsets.all(12),
            child: SvgPicture.asset(
              'assets/icons/Search.svg',
              width: 20,
              height: 20,
            ),
          ),
          suffixIcon: Container(
            width: 100, // Adjust width to accommodate the button and text
            child: IntrinsicHeight(
              // Ensures the vertical divider takes full height
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const VerticalDivider(
                    color: Colors.black12,
                    indent: 10,
                    endIndent: 10,
                    thickness: 0.1,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: SvgPicture.asset(
                      'assets/icons/Filter.svg',
                      width: 20,
                      height: 20,
                    ),
                  ),
                ],
              ),
            ),
          ),
          contentPadding: const EdgeInsets.all(15),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none, // No visible border
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
        ),
        controller: _searchController,
        onChanged: (value) {
          // Handle search text changes
          print('Search term: $value');
          _searchController.text = value;
        },
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0, // Optional: Removes the shadow
      leading: IconButton(
        icon: SvgPicture.asset(
          'assets/icons/Arrow - Left.svg',
          width: 24, // Adjust size as needed
          height: 24, // Adjust size as needed
          colorFilter:
          const ColorFilter.mode(Colors.black, BlendMode.srcIn), // Ensures icon is black
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
            'assets/icons/dots.svg',
            width: 5, // Adjust size as needed
            height: 5, // Adjust size as needed
            colorFilter:
            const ColorFilter.mode(Colors.black, BlendMode.srcIn), // Ensures icon is black
          ),
          onPressed: () {
            // Handle right button press
          },
        ),
      ],
    );
  }
}
