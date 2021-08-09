part of 'models.dart';

class CategoryModel {
  final String name;
  final String bannerUrl;

  CategoryModel(
    this.name,
    this.bannerUrl,
  );

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        json['name'],
        json['bannerUrl'],
      );
}
