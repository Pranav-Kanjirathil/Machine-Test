import 'dart:io';

class UserModel {

  final String name;
  final int age;
  final String imagePath;

  UserModel({
    required this.name,
    required this.age,
    required this.imagePath,
  });

  File get imageFile => File(imagePath);

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "age": age,
      "imagePath": imagePath,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json["name"],
      age: json["age"],
      imagePath: json["imagePath"],
    );
  }

}
