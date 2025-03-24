import 'package:equatable/equatable.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class MarkerInfo extends Equatable {
  final String id;
  final Point point;
  final String name;

  const MarkerInfo({
    required this.id,
    required this.point,
    required this.name,
  });

  @override
  List<Object?> get props => [id, point, name];
}
