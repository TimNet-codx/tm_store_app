class CartModel {
  final String productName;
  final int productPrice;
  final String category;
  final List<String> images;
  final String vendorId;
  final int productQuantity;
  int quantity;
  final String productId;
  final String description;
  final String fullName;
  final String userId;

  CartModel( {required this.userId, required this.productName, required this.productPrice, required this.category, required this.images, required this.vendorId, required this.productQuantity, required this.quantity, required this.productId, required this.description, required this.fullName});


Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'productId': productId,
      'productName': productName,
      'productPrice': productPrice,
      'category': category,
      'images': images,
      'vendorId': vendorId,
      'productQuantity': productQuantity,
      'quantity': quantity,
      'description': description,
      'fullName': fullName,
      'userId': userId,
    };
  }
}