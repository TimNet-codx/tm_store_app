import 'dart:convert';

class OrderModel {
  final String id;
  final String fullName;
  final String email;
  final String state;
  final String city;
  final String street;
  final String productName;
  final int productPrice;
  final int quantity;
  final String category;
  final String buyerdId;
  final String vendorId;
  final String image;
  final bool processing;
  final bool delivered;
 
  

  OrderModel({
    required this.id,
    required this.fullName,
    required this.email,
    required this.state,
    required this.city,
    required this.street,
    required this.productName,
    required this.productPrice,
    required this.quantity,
    required this.category,
    required this.buyerdId,
    required this.vendorId,
    required this.image,
    required this.processing,
    required this.delivered,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "id": id,
      "fullName": fullName,
      "email": email,
      "state": state,
      "city": city,
      "street": street,
      "productName": productName,
      "productPrice": productPrice,
      "quantity": quantity,
      "category": category,
      "buyerdId": buyerdId,
      "vendorId": vendorId,
      "image": image,
      "processing": processing,
      "delivered": delivered,
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      id: map["_id"] as String? ?? "",
      fullName: map["fullName"] as String? ?? "",
      email: map["email"] as String? ?? "",
      state: map["state"] as String? ?? "",
      city: map["city"] as String? ?? "",
      street: map["street"] as String? ?? "",
      productName: map["productName"] as String? ?? "",
      productPrice: map["productPrice"] as int? ?? 0,
      quantity: map["quantity"] as int? ?? 0,
      category: map["category"] as String? ?? "",
      buyerdId: map["buyerdId"] as String? ?? "",
      vendorId: map["vendorId"] as String? ?? "",
      image: map["image"] as String? ?? "",
      processing: map["processing"] as bool? ?? false,
      delivered: map["delivered"] as bool? ?? false,
    );
  }
  
  String toJson() => json.encode(toMap());


  factory OrderModel.fromJson (String source) => OrderModel.fromMap(json.decode(source) as Map<String, dynamic>);
 

}