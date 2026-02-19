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

      padding: EdgeInsets.all(20),

      decoration: BoxDecoration(
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
          Text(
            "Sort",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),

          SizedBox(height: 15),

          RadioListTile<int>(
            value: 0,
            groupValue: selectedValue,
            title: const Text("All"),
            onChanged: (value) {
              setState(() {
                selectedValue = value!;
              });

              Navigator.pop(context, selectedValue);
            },
          ),

          RadioListTile<int>(
            value: 1,
            groupValue: selectedValue,
            title: const Text("Age: Elder"),
            onChanged: (value) {
              setState(() {
                selectedValue = value!;
              });

              Navigator.pop(context, selectedValue);
            },
          ),

          RadioListTile<int>(
            value: 2,
            groupValue: selectedValue,
            title: const Text("Age: Younger"),
            onChanged: (value) {
              setState(() {
                selectedValue = value!;
              });

              Navigator.pop(context, selectedValue);
            },
          ),
        ],
      ),
    );
  }
}
