import 'package:flutter/material.dart';
import 'package:machine/view_models/user_viewmodel.dart';
import 'package:machine/widgets/add_user_dialog.dart';
import 'package:machine/widgets/sort_dialog.dart';
import 'package:machine/models/user_model.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<UserViewModel>(context);

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
        shape: const CircleBorder(),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        elevation: 6,
        child: const Icon(Icons.add),
        onPressed: () async {
          final result = await showDialog(
            context: context,
            builder: (_) => const AddUser(),
          );

          if (result != null) {
            vm.addUser(
              UserModel(
                name: result["name"],
                age: int.parse(result["age"]),
                phoneNumber: result["phone"],
                imagePath: result["image"]?.path ?? "",
              ),
            );
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
                    onChanged: vm.search,
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
                      vm.filter(result);
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.filter_list,
                      color: Colors.white,
                    ),
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
            child: vm.users.isEmpty
                ? const Center(
                    child: Text("No Users Added"),
                  )
                : ListView.builder(
                    itemCount: vm.users.length,
                    itemBuilder: (context, index) {
                      final user = vm.users[index];

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
                              backgroundImage: user.imagePath.isNotEmpty
                                  ? FileImage(user.imageFile)
                                  : null,
                              child: user.imagePath.isEmpty
                                  ? const Icon(Icons.person)
                                  : null,
                            ),
                            const SizedBox(width: 15),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(user.name),
                                Text("Age: ${user.age}"),
                                Text("Phone: ${user.phoneNumber}"),
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
