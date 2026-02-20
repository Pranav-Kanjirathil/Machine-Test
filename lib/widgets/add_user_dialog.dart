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

  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final phoneController = TextEditingController();

  final picker = ImagePicker();

  void showImagePickerOptions() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text("Take Photo"),
                onTap: () {
                  Navigator.pop(context);
                  pickImage(ImageSource.camera);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text("Choose from Gallery"),
                onTap: () {
                  Navigator.pop(context);
                  pickImage(ImageSource.gallery);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> pickImage(ImageSource source) async {
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        selectedImage = File(pickedFile.path);
      });
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    ageController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      insetPadding: const EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
          top: 20,
          bottom: MediaQuery.of(context).viewInsets.bottom + 20,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Add A New User",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: showImagePickerOptions,
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CircleAvatar(
                      radius: 45,
                      backgroundColor: Colors.white,
                      backgroundImage: selectedImage != null
                          ? FileImage(selectedImage!)
                          : null,
                      child: selectedImage == null
                          ? const Icon(
                              Icons.person,
                              color: Colors.black,
                              size: 45,
                            )
                          : null,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.black, width: 1),
                      ),
                      padding: const EdgeInsets.all(6),
                      child: const Icon(
                        Icons.camera_alt,
                        size: 18,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: "Name",
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Please enter name";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
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
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter age";
                  }
                  final age = int.tryParse(value);
                  if (age == null || age <= 0) {
                    return "Enter valid age";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: phoneController,
                keyboardType: TextInputType.phone,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(10),
                ],
                decoration: InputDecoration(
                  labelText: "Phone Number",
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter phone number";
                  }
                  if (value.length != 10) {
                    return "Phone must be 10 digits";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[300],
                        foregroundColor: Colors.black,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("Cancel"),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[300],
                        foregroundColor: Colors.black,
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          Navigator.pop(context, {
                            "name": nameController.text.trim(),
                            "age": ageController.text.trim(),
                            "phone": phoneController.text.trim(),
                            "image": selectedImage,
                          });
                        }
                      },
                      child: const Text("Save"),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
