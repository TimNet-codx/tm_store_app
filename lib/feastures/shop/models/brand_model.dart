import 'dart:convert';

class BrandModel {
  final String id;
  final String brandName;
  final String image;

  BrandModel({
    required this.id,
    required this.brandName,
    required this.image,
  });

  Map<String, dynamic> toMap(){
    return {
      'id': id,
      'brandName': brandName,
      'image': image,
    };
  }

  String toJson() => json.encode(toMap());
  factory BrandModel.fromJson(Map<String, dynamic> map){
    return BrandModel(
      id: map['_id'] as String,
      brandName: map['brandName'] as String,
      image: map['image'] as String,
    );
  }
}