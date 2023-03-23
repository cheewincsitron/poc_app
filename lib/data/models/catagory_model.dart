import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class CatagoryModel {
  final String id;
  final String name;
  final String description;
  final String imageUrl;

  CatagoryModel({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
    };
  }

  factory CatagoryModel.fromMap(Map<String, dynamic> map) {
    return CatagoryModel(
      id: map['id'] as String,
      name: map['name'] as String,
      description: map['description'] as String,
      imageUrl: map['imageUrl'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory CatagoryModel.fromJson(String source) =>
      CatagoryModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
