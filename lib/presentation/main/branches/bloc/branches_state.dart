import 'package:e_comerce_app/data/local_models/marker_info.dart';
import 'package:equatable/equatable.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

abstract class MapState extends Equatable {
  const MapState();

  @override
  List<Object?> get props => [];
}

class MapInitial extends MapState {}

class MapLoading extends MapState {}

class MapLoaded extends MapState {
  final Point? currentLocation;
  final List<MarkerInfo> markers;
  final List<MapObject> mapObjects;

  const MapLoaded({
    this.currentLocation,
    this.markers = const [],
    this.mapObjects = const [],
  });

  MapLoaded copyWith({
    Point? currentLocation,
    List<MarkerInfo>? markers,
    List<MapObject>? mapObjects,
  }) {
    return MapLoaded(
      currentLocation: currentLocation ?? this.currentLocation,
      markers: markers ?? this.markers,
      mapObjects: mapObjects ?? this.mapObjects,
    );
  }

  @override
  List<Object?> get props => [currentLocation, markers, mapObjects];
}

class MapError extends MapState {
  final String message;

  const MapError(this.message);

  @override
  List<Object> get props => [message];
}

class MarkerSelected extends MapState {
  final MarkerInfo marker;
  final List<MapObject> mapObjects;
  final Point? currentLocation;
  final List<MarkerInfo> markers;

  const MarkerSelected(
      this.marker,
      [this.mapObjects = const [],
        this.currentLocation,
        this.markers = const []
      ]);

  @override
  List<Object?> get props => [marker, mapObjects, currentLocation, markers];
}