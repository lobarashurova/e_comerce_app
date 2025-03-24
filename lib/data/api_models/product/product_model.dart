import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_model.g.dart';

part 'product_model.freezed.dart';


@freezed
class TotalProductModel with _$TotalProductModel {
  const factory TotalProductModel({
    List<ProductModel>? products,
    int? total,
    int? skip,
    int? limit,
}) = _TotalProductModel;

  factory TotalProductModel.fromJson(Map<String, dynamic> json) =>
      _$TotalProductModelFromJson(json);
}

@freezed
class ProductModel with _$ProductModel {
  const factory ProductModel({
    int? id,
    String? title,
    String? description,
    String? category,
    double? price,
    double? discountPercentage,
    double? rating,
    List<String>? images,
    String? thumbnail,
}) = _ProductModel;

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);
}