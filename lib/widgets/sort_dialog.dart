import 'package:flutter/material.dart';
import 'package:machine/view_models/user_viewmodel.dart';
import 'package:provider/provider.dart';

class SortDialog extends StatelessWidget {
  const SortDialog({super.key});

  @override
  Widget build(BuildContext context) {

    final vm = Provider.of<UserViewModel>(context);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
      ),

      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          const Text(
            "Sort",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 15),

          RadioListTile<int>(
            value: 0,
            groupValue: vm.selectedFilter,
            title: const Text("All"),
            onChanged: (value) {
              vm.filter(value!);
              Navigator.pop(context);
            },
          ),

          RadioListTile<int>(
            value: 1,
            groupValue: vm.selectedFilter,
            title: const Text("Age: Elder"),
            onChanged: (value) {
              vm.filter(value!);
              Navigator.pop(context);
            },
          ),

          RadioListTile<int>(
            value: 2,
            groupValue: vm.selectedFilter,
            title: const Text("Age: Younger"),
            onChanged: (value) {
              vm.filter(value!);
              Navigator.pop(context);
            },
          ),

        ],
      ),
    );
  }
}
