import 'package:cakes_with_prompts/models/category_model.dart';
import 'package:cakes_with_prompts/models/diet_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
// Assuming your models are in a 'models' directory

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<CategoryModel> categories = [];
  List<DietModel> diets = []; // Add diets list

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() {
    categories = CategoryModel.getCategories();
    diets = DietModel.getDiets(); // Load diets data
  }

  // Method to handle view button tap and update state
  void _onDietViewTapped(int index) {
    setState(() {
      // Example: Toggle selection or set only one as selected
      // For this example, let's assume only one can be "viewIsSelected"
      for (int i = 0; i < diets.length; i++) {
        diets[i].viewIsSelected = (i == index);
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          _buildSearchField(),
          _buildCategoriesSection(),
          _buildSectionTitle("Recommendation\nfor Diet"), // Title for the Diets section
          _buildDietsSection(), // Add the diets section here
          // Add other ListView children below if needed
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 30, bottom: 15),
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
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
            width: 100,
            child: IntrinsicHeight(
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
            borderSide: BorderSide.none,
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
        controller: _searchController, // Assign the controller
        onChanged: (value) {
          // Handle search text changes
          print('Search term: $value');
          // If you want the text field to immediately reflect what's typed
          // (which it does by default), you don't need this line:
          // _searchController.text = value;
          // However, if you were manipulating the value before setting it,
          // or if onChanged had more complex logic, this might be relevant.
        },
      ),
    );
  }

  Widget _buildCategoriesSection() {
    // ... (your existing _buildCategoriesSection method)
    return Container(
      height: 120, // Height of the horizontal ListView container
      padding: const EdgeInsets.only(left: 20, top: 10, bottom: 10), // Add padding for items
      child: ListView.separated(
        key: ValueKey('categories_list'),
        itemCount: categories.length,
        scrollDirection: Axis.horizontal,
        separatorBuilder: (context, index) => const SizedBox(width: 25), // Separator
        itemBuilder: (context, index) {
          CategoryModel item = categories[index];
          return Container(
            key: ValueKey('category_item_${item.name}'), // Add a key for testing
            width: 100,
            decoration: BoxDecoration(
              color: item.boxColor.withAlpha(90),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SvgPicture.asset(
                      item.iconPath,
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Text(
                  item.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildDietsSection() {
    return Container(
      height: 240, // Height of the Diets section container
      child: ListView.separated(
        key: ValueKey('diets_list'),
        itemCount: diets.length,
        scrollDirection: Axis.horizontal,
        separatorBuilder: (context, index) => const SizedBox(width: 25), // Separator
        itemBuilder: (context, index) {
          DietModel diet = diets[index];
          return Container(
            key: ValueKey('diet_item_${diet.name}'), // Add a key for testing
            width: 210, // Width of each diet item
            decoration: BoxDecoration(
              color: diet.boxColor.withAlpha(90),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding( // Add padding inside the item
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Distribute space
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    diet.iconPath,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    diet.name,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w500, // Medium weight
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${diet.level} | ${diet.duration} | ${diet.calorie}',
                    style: const TextStyle(
                      color: Color(0xff7B6F72), // A slightly muted color
                      fontSize: 13,
                      fontWeight: FontWeight.w300, // Light weight
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  GestureDetector(
                    onTap: () {
                      _onDietViewTapped(index);
                    },
                    child: Container(
                      height: 45, // Fixed height for the button
                      width: 130, // Fixed width for the button
                      decoration: BoxDecoration(
                        gradient: diet.viewIsSelected
                            ? const LinearGradient(colors: [
                          Color(0xff9DCEFF),
                          Color(0xff92A3FD)
                        ]) // Blue gradient when selected
                            : null, // No gradient when not selected
                        color: diet.viewIsSelected
                            ? null // Color is handled by gradient
                            : const Color(0xffF7F8F8), // Greyish when not selected
                        borderRadius: BorderRadius.circular(22.5), // half of height
                      ),
                      child: Center(
                        child: Text(
                          diet.viewIsSelected ? 'Selected' : 'View',
                          style: TextStyle(
                            color: diet.viewIsSelected ? Colors.white : Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }


  AppBar buildAppBar() {
    // ... (your existing buildAppBar method)
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: SvgPicture.asset(
          'assets/icons/Arrow - Left.svg',
          width: 24,
          height: 24,
          colorFilter:
          const ColorFilter.mode(Colors.black, BlendMode.srcIn),
        ),
        onPressed: () {},
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
            width: 5,
            height: 5,
            colorFilter:
            const ColorFilter.mode(Colors.black, BlendMode.srcIn),
          ),
          onPressed: () {},
        ),
      ],
    );
  }
}
