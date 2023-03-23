import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class BannerEntity {
  final String id;
  final String name;
  final String image;

  BannerEntity({
    required this.id,
    required this.name,
    required this.image,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'image': image,
    };
  }

  factory BannerEntity.fromMap(Map<String, dynamic> map) {
    return BannerEntity(
      id: map['id'] as String,
      name: map['name'] as String,
      image: map['imageUrl'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory BannerEntity.fromJson(String source) =>
      BannerEntity.fromMap(json.decode(source) as Map<String, dynamic>);
}
