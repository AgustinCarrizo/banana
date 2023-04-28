import 'package:json_annotation/json_annotation.dart';

part 'producto.g.dart';

@JsonSerializable()
class Producto {
  final int? id;
  final String? title;
  final String? description;
  final int? price;
  final double? discountPercentage;
  final double? rating;
  final int? stock;
  final String? brand;
  final String? category;
  final String? thumbnail;
  final List<String?>? images;

  factory Producto.fromJson(Map<String, dynamic> json) =>
      _$ProductoFromJson(json);

  Producto(
      this.id,
      this.title,
      this.description,
      this.price,
      this.discountPercentage,
      this.rating,
      this.stock,
      this.brand,
      this.category,
      this.thumbnail,
      this.images);

  Map<String, dynamic> toJson() => _$ProductoToJson(this);
}
