  class CategoryDataModel {
    final String name;
    final int totalProducts;
    final List<BrandSubset> brands;
    final List<ProductSubset> products;

    CategoryDataModel({
      required this.name,
      required this.totalProducts,
      required this.brands,
      required this.products,
    });

    factory CategoryDataModel.fromJson(Map<String, dynamic> json) {
      return CategoryDataModel(
        name: json['name'] ?? "",
        totalProducts: json['totalProducts'] ?? 0,
        brands: (json['brands'] as List).map((i) => BrandSubset.fromJson(i)).toList(),
        products: (json['products'] as List).map((i) => ProductSubset.fromJson(i)).toList(),
      );
    }
  }

  class BrandSubset {
    final String brandName;
    // final String image;
     final List<String> image;
    BrandSubset({required this.brandName, required this.image});
    factory BrandSubset.fromJson(Map<String, dynamic> json) => 
      BrandSubset(brandName: json['brandName'] ?? "", image: json['image'] ?? "");
  }

  class ProductSubset {
    final String productName;
    final int quantity;
    ProductSubset({required this.productName, required this.quantity});
    factory ProductSubset.fromJson(Map<String, dynamic> json) => 
      ProductSubset(productName: json['productName'] ?? "", quantity: json['quantity'] ?? 0);
  }