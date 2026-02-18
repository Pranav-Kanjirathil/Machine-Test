import 'package:flutter/material.dart';
import 'package:machine/widgets/add_user.dart';
import 'package:machine/widgets/sort_dialog.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEBEBEB),

      // APP BAR
      appBar: AppBar(
        backgroundColor: Colors.black,
        toolbarHeight: 69,
        elevation: 0,
        titleSpacing: 16,
        title: const Row(
          children: [
            Icon(Icons.location_on, color: Colors.white, size: 20),
            SizedBox(width: 8),
            Text(
              "Nilambur",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),

      // FLOATING BUTTON
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(context: context, builder: (context) => const AddUser());
        },
        backgroundColor: Colors.black,
        shape: const CircleBorder(),
        child: const Icon(Icons.add, color: Colors.white, size: 30),
      ),

      body: Column(
        children: [
          // SEARCH + FILTER
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "search by name",
                      prefixIcon: const Icon(Icons.search),

                      filled: true,
                      fillColor: Colors.white,

                      contentPadding: const EdgeInsets.symmetric(vertical: 0),

                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(color: Colors.grey.shade400),
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 10),

                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,

                      backgroundColor: Colors.transparent,

                      isScrollControlled: true,

                      builder: (context) => const SortDialog(),
                    );
                  },

                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(Icons.filter_list, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),

          // TITLE
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Users Lists",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'font3',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
