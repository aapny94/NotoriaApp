import 'package:flutter/material.dart';
import 'package:notoria_app/core/widgets/category_table.dart';
import '../../Categories/screens/add_categories.dart';

class CategoriesWidget extends StatefulWidget {
  const CategoriesWidget({super.key});

  @override
  State<CategoriesWidget> createState() => _CategoriesWidgetState();
}

class _CategoriesWidgetState extends State<CategoriesWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent),
      backgroundColor: const Color.fromARGB(0, 19, 19, 19),

      body: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(top: 10, left: 26, right: 16),
              child: const Text(
                'Categories',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 36,
                  fontFamily: 'Helvetica',
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 26, right: 26),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Category list created",
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Helvetica',
                    fontSize: 16,
                  ),
                ),
                Container(
                  height: 25,
                  width: 25,
                  decoration: BoxDecoration(
                    color: Color(0xFFE82925),
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(
                      35,
                    ), // optional, for rounded corners
                  ),
                  child: IconButton(
                    icon: Icon(Icons.add, color: Colors.black),
                    iconSize: 18,
                    padding: EdgeInsets.zero,
                    alignment: Alignment.center,
                    onPressed: () async {
                      final created = await Navigator.push<bool?>(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddCategories(),
                        ),
                      );

                      if (created == true) {
                        setState(() {});
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 22),
              child: CategoriesTable(),
            ),
          ),
        ],
      ),
    );
  }
}
