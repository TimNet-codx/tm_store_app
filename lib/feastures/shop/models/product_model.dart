import 'dart:convert';

class ProductModel {
  final String id;
  final String productName;
  final String description;
  final String category;
  final String subCategory;
  final int productPrice;
  final int quantity;
  //final String images;
  final List<String> images;
  final String vendorId;
  final String fullName;
  final DateTime createdAt;
   bool favourite;

   

  ProductModel({
    required this.id,
    required this.productName,
    required this.description,
    required this.category,
    required this.subCategory,
    required this.productPrice,
    required this.quantity,
    required this.images,
    required this.vendorId,
    required this.fullName,
    required this.createdAt,
    required this.favourite,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'productName': productName,
      'description': description,
      'category': category,
      'subCategory': subCategory,
      'productPrice': productPrice,
      'quantity': quantity,
      'images': images,
      'vendorId': vendorId,
      'fullName': fullName,
      // 'favourite': favourite,
      'createdAt': createdAt.toIso8601String(),
    };
  }
   String toJson()=> json.encode(toMap());

   factory ProductModel.fromMap(Map<String, dynamic> map){
    return ProductModel(  
      id: map["_id"] as String? ?? "",
      productName: map["productName"] as String? ?? "",
      description: map["description"] as String? ?? "",
      category: map["category"] as String? ?? "",
      subCategory: map["subCategory"] as String? ?? "",
      // productPrice: map["productPrice"] as int? ?? 0,
      productPrice: (map["productPrice"] as num?)?.toInt() ?? 0,
      quantity: map["quantity"] as int? ?? 0,
      // images: map["images"] as String? ?? "",
      //images: map["images"] != null ? List<String>.from(map["images"]) : [],
      
      // images: (map["images"] != null && map["images"] is List && (map["images"] as List).isNotEmpty)
      //   ? map["images"][0].toString() 
      //   : "",
      images: List<String>.from(map['images']),
      vendorId: map["vendorId"] as String? ?? "",
      fullName: map["fullName"] as String? ?? "",
      createdAt: map["createdAt"] != null 
        ? DateTime.parse(map["createdAt"])
        : DateTime.now(), 
      favourite: map["favourite"] as bool? ?? false,
    );
   }

  //  factory ProductModel.fromJson (String source) => ProductModel.fromMap(json.decode(source) as Map<String, dynamic>);
}