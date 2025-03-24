import 'package:hive/hive.dart';

part 'favourite_model.g.dart';

@HiveType(typeId: 0)
class Product extends HiveObject {
  @HiveField(0)
  final int? id;

  @HiveField(1)
  final String? name;

  @HiveField(2)
  final double? price;
  @HiveField(3)
  final String? image;

  Product(
      {required this.id,
        required this.name,
        required this.price,
        required this.image});
}
