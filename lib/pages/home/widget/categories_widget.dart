import 'package:flutter/material.dart';
import 'package:notoria_app/core/widgets/category_table.dart';

class CategoriesWidget extends StatelessWidget {
  const CategoriesWidget({super.key});

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
                    padding: EdgeInsets.zero, // <-- This centers the icon
                    alignment:
                        Alignment.center, // <-- This ensures center alignment
                    onPressed: () {
                      // Your action here
                    },
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Expanded( // <-- Add this!
            child: Padding(padding:   
              const EdgeInsets.only(left: 20.0, right: 22),
              child: CategoriesTable(),
            ),  
          ),
        ],
      ),
    );
  }
}
