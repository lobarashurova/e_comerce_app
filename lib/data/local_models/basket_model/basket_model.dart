import 'package:hive/hive.dart';

part 'basket_model.g.dart';

@HiveType(typeId: 2)
class BasketLocalModel extends HiveObject {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String? name;
  @HiveField(2)
  final double? price;
  @HiveField(3)
  final String? image;
  @HiveField(4)
  final int? count;

  BasketLocalModel(
      {required this.id,
        required this.name,
        required this.price,
        required this.image,

        required this.count});

  BasketLocalModel copyWith({
    int? id,
    String? name,
    double? price,
    String? image,

    int? count,
  }) {
    return BasketLocalModel(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      image: image ?? this.image,

      count: count ?? this.count,
    );
  }

  factory BasketLocalModel.fromJson(Map<String, dynamic> json) {
    return BasketLocalModel(
      id: json['id'], // Convert id to string as the field expects a string
      name: json['name'] ?? '', // Default to an empty string if null
      price: json['price'], // Convert price to string
      image: json['img'] ?? '', // Use img for the image field
      count: json['quantity'] ?? 0, // Default to 0 if null
    );
  }
}
