import 'package:cakes_with_prompts/models/category_model.dart';
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

  @override
  void initState() {
    super.initState();
    _loadCategories();
  }

  void _loadCategories() {
    categories = CategoryModel.getCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          _buildSearchField(),
          _buildCategoriesSection(), // Add the categories section here
          // Add other ListView children below if needed
        ],
      ),
    );
  }

  Widget _buildSearchField() {
    // ... (your existing _buildSearchField method)
    // Add the TextEditingController as a member of the state class
    // if you need to access or clear its value from elsewhere.
    // For this example, keeping it local to the build method is fine
    // if its value is only used within the onChanged callback.
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
    return Container(
      height: 120, // Height of the horizontal ListView container
      padding: const EdgeInsets.only(left: 20, top: 10, bottom: 10), // Add padding for items
      child: ListView.separated(
        itemCount: categories.length,
        scrollDirection: Axis.horizontal,
        separatorBuilder: (context, index) => const SizedBox(width: 25), // Separator
        itemBuilder: (context, index) {
          CategoryModel item = categories[index];
          return Container(
            width: 100, // Width of each category item
            // Height is implicitly managed by the parent Container's height
            // and the content of the Column. We don't need to set height here
            // unless there's a specific design reason.
            decoration: BoxDecoration(
              color: item.boxColor,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center, // Center items vertically in Column
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Padding( // Add padding inside the circle if icon is too large
                    padding: const EdgeInsets.all(8.0), // Adjust padding as needed
                    child: SvgPicture.asset(
                      item.iconPath,
                      // You might want to set width/height for the SVG if it's too big
                      // or if you want consistent icon sizing.
                      width: 24,
                      height: 24,
                      // colorFilter: ColorFilter.mode(item.boxColor.withOpacity(0.7), BlendMode.srcIn), // Optional: tint icon
                    ),
                  ),
                ),
                const SizedBox(height: 15), // Separator between circle and text
                Text(
                  item.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.w400, // Or FontWeight.normal
                    color: Colors.black, // Or Colors.black87 for slightly less intensity
                    fontSize: 14, // Adjust as needed
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 1, // Ensure text doesn't wrap excessively
                  overflow: TextOverflow.ellipsis, // Handle long text
                ),
              ],
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
