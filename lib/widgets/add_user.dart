import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/services.dart';

class AddUser extends StatefulWidget {
  const AddUser({super.key});

  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {

  File? selectedImage;

  final nameController = TextEditingController();
  final ageController = TextEditingController();

  final picker = ImagePicker();

  Future pickImage() async {

    final pickedFile =
        await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {

      setState(() {

        selectedImage = File(pickedFile.path);

      });

    }

  }

  @override
  Widget build(BuildContext context) {

    return Dialog(

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),

      child: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          mainAxisSize: MainAxisSize.min,

          children: [

            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Add A New User",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            SizedBox(height: 20),

            GestureDetector(
              onTap: pickImage,

              child: CircleAvatar(
                radius: 40,
                backgroundColor: Colors.blue,

                backgroundImage:
                    selectedImage != null
                        ? FileImage(selectedImage!)
                        : null,

                child: selectedImage == null
                    ? const Icon(
                        Icons.person,
                        color: Colors.white,
                        size: 40,
                      )
                    : null,
              ),
            ),

            SizedBox(height: 20),

            TextField(
              controller: nameController,

              decoration: InputDecoration(
                labelText: "Name",
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(10),
                ),
              ),
            ),

            SizedBox(height: 10),

            TextField(
              controller: ageController,

              keyboardType: TextInputType.number,

              inputFormatters: [

                FilteringTextInputFormatter.digitsOnly,

                LengthLimitingTextInputFormatter(3),

              ],

              decoration: InputDecoration(
                labelText: "Age",
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(10),
                ),
              ),
            ),

            SizedBox(height: 20),

            Row(
              children: [

                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Colors.grey[300],
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "Cancel",
                      style: TextStyle(
                          color: Colors.black),
                    ),
                  ),
                ),

                SizedBox(width: 10),

                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                    ),

                    onPressed: () {

                      if (selectedImage == null ||
                          nameController.text.isEmpty ||
                          ageController.text.isEmpty) {
                        return;
                      }

                      Navigator.pop(context, {

                        "name": nameController.text,
                        "age": ageController.text,
                        "image": selectedImage,

                      });

                    },

                    child: const Text("Save"),
                  ),
                ),

              ],
            ),

          ],

        ),

      ),

    );

  }

}
