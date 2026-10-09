// import 'dart:convert';

// class OrderModel {
//   final String id;
//   final String fullName;
//   final String email;
//   final String state;
//   final String city;
//   final String street;
//   final String productName;
//   final int productPrice;
//   final int quantity;
//   final String category;
//   final String buyerId;
//   final String vendorId;
//   final String image;
//   final bool processing;
//   final bool delivered;
 
  

//   OrderModel({
//     required this.id,
//     required this.fullName,
//     required this.email,
//     required this.state,
//     required this.city,
//     required this.street,
//     required this.productName,
//     required this.productPrice,
//     required this.quantity,
//     required this.category,
//     required this.buyerId,
//     required this.vendorId,
//     required this.image,
//     required this.processing,
//     required this.delivered,
//   });

//   Map<String, dynamic> toMap() {
//     return <String, dynamic>{
//       "id": id,
//       "fullName": fullName,
//       "email": email,
//       "state": state,
//       "city": city,
//       "street": street,
//       "productName": productName,
//       "productPrice": productPrice,
//       "quantity": quantity,
//       "category": category,
//       "buyerId": buyerId,
//       "vendorId": vendorId,
//       "image": image,
//       "processing": processing,
//       "delivered": delivered,
//     };
//   }

//   factory OrderModel.fromMap(Map<String, dynamic> map) {
//     return OrderModel(
//       id: map["_id"] as String? ?? "",
//       fullName: map["fullName"] as String? ?? "",
//       email: map["email"] as String? ?? "",
//       state: map["state"] as String? ?? "",
//       city: map["city"] as String? ?? "",
//       street: map["street"] as String? ?? "",
//       productName: map["productName"] as String? ?? "",
//       productPrice: map["productPrice"] as int? ?? 0,
//       quantity: map["quantity"] as int? ?? 0,
//       category: map["category"] as String? ?? "",
//       buyerId: map["buyerdId"] as String? ?? "",
//       vendorId: map["vendorId"] as String? ?? "",
//       image: map["image"] as String? ?? "",
//       processing: map["processing"] as bool? ?? false,
//       delivered: map["delivered"] as bool? ?? false,
//     );
//   }
  
//   String toJson() => json.encode(toMap());


//   factory OrderModel.fromJson (String source) => OrderModel.fromMap(json.decode(source) as Map<String, dynamic>);
 

// }

import 'dart:convert';

class OrderModel {
  final String id;
  final String fullName;
  final String email;
  final String state;
  final String city;
  final String street;
  final String postalCode;
  final String phoneNumber;
  final String productName;
  final double productPrice;
  final int quantity;
  final String category;
  final String buyerId;
  final String vendorId;
  final String image;
  final bool processing;
  final String country;
  final bool delivered;
  final bool isSelected; // New field to track selection


  OrderModel({
    required this.id,
    required this.fullName,
    required this.email,
    required this.phoneNumber,
    required this.country,
    required this.state,
    required this.city,
    required this.street,
    this.postalCode = '',
    required this.productName,
    required this.productPrice,
    required this.quantity,
    required this.category,
    required this.buyerId,
    required this.vendorId,
    required this.image,
    required this.processing,
    required this.delivered,
    this.isSelected = false, // Default value for the new field
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "orderId": id,
      "fullName": fullName,
      "email": email,
      "phoneNumber": phoneNumber,
      "country": country,
      "state": state,
      "city": city,
      "street": street,
      "postalCode": postalCode,
      "productName": productName,
      "productPrice": productPrice,
      "quantity": quantity,
      "category": category,
      "buyerId": buyerId,
      "vendorId": vendorId,
      "image": image,
      "processing": processing,
      "delivered": delivered,
      "isSelected": isSelected,
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      id: map["_id"] as String? ?? map["id"] as String? ?? "",
      fullName: map["fullName"] as String? ?? "",
      email: map["email"] as String? ?? "",
      phoneNumber: map["phoneNumber"] as String? ?? "",
      country: map["country"] as String? ?? "",
      state: map["state"] as String? ?? "",
      city: map["city"] as String? ?? "",
      street: map["street"] as String? ?? "",
      postalCode: map["postalCode"] as String? ?? "",
      productName: map["productName"] as String? ?? "",
      productPrice: (map["productPrice"] as num?)?.toDouble() ?? 0.0,
      quantity: map["quantity"] as int? ?? 0,
      category: map["category"] as String? ?? "",
      buyerId: map["buyerId"] as String? ?? map["buyerdId"] as String? ?? "",
      vendorId: map["vendorId"] as String? ?? "",
      image: map["image"] as String? ?? "",
      processing: map["processing"] as bool? ?? true,
      delivered: map["delivered"] as bool? ?? false,
      isSelected: map["isSelected"] as bool? ?? false, // Default to false if not present
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderModel.fromJson(String source) =>
      OrderModel.fromMap(json.decode(source) as Map<String, dynamic>);
}