part of 'models.dart';

class ProductModel {
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

  String toRupiahFormat(int price) {
    return NumberFormat.currency(
      locale: 'ID',
      decimalDigits: 0,
      symbol: 'Rp ',
    ).format(price);
  }
}
