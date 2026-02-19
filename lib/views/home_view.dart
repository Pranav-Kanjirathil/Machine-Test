import 'package:flutter/material.dart';
import 'package:machine/widgets/add_user.dart';
import 'package:machine/widgets/sort_dialog.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<Map<String, dynamic>> users = [];
  List<Map<String, dynamic>> displayUsers = [];

  @override
  void initState() {
    super.initState();
    displayUsers = users;
  }

  void search(String value) {
    setState(() {
      displayUsers = users.where((user) {
        return user["name"].toLowerCase().contains(value.toLowerCase());
      }).toList();
    });
  }

  void filter(int type) {
    setState(() {
      if (type == 0) {
        displayUsers = users;
      } else if (type == 1) {
        displayUsers = users
            .where((user) => int.parse(user["age"]) >= 60)
            .toList();
      } else {
        displayUsers = users
            .where((user) => int.parse(user["age"]) < 60)
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEBEBEB),

      appBar: AppBar(
        automaticallyImplyLeading: false,

        backgroundColor: Colors.black,

        toolbarHeight: 69,

        title: const Row(
          children: [
            Icon(Icons.location_on, color: Colors.white),

            SizedBox(width: 8),

            Text("Nilambur", style: TextStyle(color: Colors.white)),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,

        child: const Icon(Icons.add),

        onPressed: () async {
          final result = await showDialog(
            context: context,
            builder: (_) => const AddUser(),
          );

          if (result != null) {
            setState(() {
              users.add(result);
              displayUsers = users;
            });
          }
        },
      ),

      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),

            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    onChanged: search,

                    decoration: InputDecoration(
                      hintText: "search by name",

                      prefixIcon: const Icon(Icons.search),

                      filled: true,
                      fillColor: Colors.white,

                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 10),

                GestureDetector(
                  onTap: () async {
                    final result = await showModalBottomSheet(
                      context: context,
                      backgroundColor: Colors.transparent,
                      builder: (_) => const SortDialog(),
                    );

                    if (result != null) {
                      filter(result);
                    }
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

          const Padding(
            padding: EdgeInsets.all(16),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "User Lists",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),

          Expanded(
            child: displayUsers.isEmpty
                ? const Center(child: Text("No Users Added"))
                : ListView.builder(
                    itemCount: displayUsers.length,

                    itemBuilder: (context, index) {
                      final user = displayUsers[index];

                      return Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 6,
                        ),

                        padding: const EdgeInsets.all(12),

                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                        ),

                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 30,
                              backgroundImage: FileImage(user["image"]),
                            ),

                            const SizedBox(width: 15),

                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,

                              children: [
                                Text(user["name"]),

                                Text("Age: ${user["age"]}"),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
