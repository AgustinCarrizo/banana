import 'package:banana/model/producto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'productos.g.dart';

@JsonSerializable()
class Productos {
  Productos(this.products, this.total, this.skip, this.limit);

  factory Productos.fromJson(Map<String, dynamic> json) =>
      _$ProductosFromJson(json);

  final int? limit;
  final List<Producto?>? products;
  final int? skip;
  final int? total;

  Map<String, dynamic> toJson() => _$ProductosToJson(this);
}
