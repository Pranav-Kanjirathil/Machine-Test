import 'package:flutter/material.dart';

class SortDialog extends StatefulWidget {
  const SortDialog({super.key});

  @override
  State<SortDialog> createState() => _SortDialogState();
}

class _SortDialogState extends State<SortDialog> {
  int selectedValue = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,

      padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),

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
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),

          const SizedBox(height: 15),

          RadioListTile(
            value: 0,

            groupValue: selectedValue,

            activeColor: Colors.blue,

            contentPadding: EdgeInsets.zero,

            title: const Text("All", style: TextStyle(fontSize: 16)),

            onChanged: (value) {
              setState(() {
                selectedValue = value!;
              });
            },
          ),

          RadioListTile(
            value: 1,

            groupValue: selectedValue,

            activeColor: Colors.blue,

            contentPadding: EdgeInsets.zero,

            title: const Text("Age: Elder", style: TextStyle(fontSize: 16)),

            onChanged: (value) {
              setState(() {
                selectedValue = value!;
              });
            },
          ),

          RadioListTile(
            value: 2,

            groupValue: selectedValue,

            activeColor: Colors.blue,

            contentPadding: EdgeInsets.zero,

            title: const Text("Age: Younger", style: TextStyle(fontSize: 16)),

            onChanged: (value) {
              setState(() {
                selectedValue = value!;
              });
            },
          ),
        ],
      ),
    );
  }
}
