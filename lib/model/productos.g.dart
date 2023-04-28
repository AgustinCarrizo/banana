// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'productos.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Productos _$ProductosFromJson(Map<String, dynamic> json) => Productos(
      (json['products'] as List<dynamic>?)
          ?.map((e) =>
              e == null ? null : Producto.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['total'] as int?,
      json['skip'] as int?,
      json['limit'] as int?,
    );

Map<String, dynamic> _$ProductosToJson(Productos instance) => <String, dynamic>{
      'limit': instance.limit,
      'products': instance.products,
      'skip': instance.skip,
      'total': instance.total,
    };
