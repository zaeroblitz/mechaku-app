part of 'models.dart';

class ProductModel {
  final String id;
  final String name;
  final String categoryId;
  final String color;
  final String description;
  final String grade;
  final String size;
  final List<String> gallery;
  final int price;
  final bool isBestSeller;

  ProductModel(
    this.id,
    this.name,
    this.categoryId,
    this.color,
    this.description,
    this.grade,
    this.size,
    this.gallery,
    this.price,
    this.isBestSeller,
  );

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    List<String> gallery = List.from(json['gallery']);
    return ProductModel(
        json['id'],
        json['name'],
        json['categoryId'],
        json['color'],
        json['description'],
        json['grade'],
        json['size'],
        gallery,
        json['price'],
        json['isBestSeller']);
  }
  String toRupiahFormat(int price) {
    return NumberFormat.currency(
      locale: 'ID',
      decimalDigits: 0,
      symbol: 'Rp ',
    ).format(price);
  }
}
