import 'package:e_comerce_app/data/local_models/marker_info.dart';
import 'package:equatable/equatable.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

abstract class MapEvent extends Equatable {
  const MapEvent();

  @override
  List<Object?> get props => [];
}

class LoadMap extends MapEvent {}

class UpdateCurrentLocation extends MapEvent {
  final Point location;

  const UpdateCurrentLocation(this.location);

  @override
  List<Object?> get props => [location];
}

class AddMarkers extends MapEvent {
  final List<MarkerInfo> markers;

  const AddMarkers(this.markers);

  @override
  List<Object?> get props => [markers];
}

class SelectMarker extends MapEvent {
  final MarkerInfo marker;

  const SelectMarker(this.marker);

  @override
  List<Object?> get props => [marker];
}
