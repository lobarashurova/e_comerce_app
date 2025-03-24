import 'package:e_comerce_app/data/local_models/marker_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

import 'branches_event.dart';
import 'branches_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  YandexMapController? mapController;

  final Point tashkentLocation = const Point(latitude: 41.2995, longitude: 69.2401);

  MapBloc() : super(MapInitial()) {
    on<LoadMap>(_onLoadMap);
    on<UpdateCurrentLocation>(_onUpdateCurrentLocation);
    on<AddMarkers>(_onAddMarkers);
    on<SelectMarker>(_onSelectMarker);
  }

  Future<void> _onLoadMap(LoadMap event, Emitter<MapState> emit) async {
    emit(MapLoading());

    try {
      add(UpdateCurrentLocation(tashkentLocation));

      const predefinedMarkers =[
        MarkerInfo(
          id: '1',
          point:  Point(latitude: 41.3111, longitude: 69.2486),
          name: 'Location 1',
        ),
        MarkerInfo(
          id: '2',
          point:  Point(latitude: 41.3266, longitude: 69.2289),
          name: 'Location 2',
        ),
      ];

      add(AddMarkers(predefinedMarkers));

    } catch (e) {
      debugPrint('Failed to load map: $e');
      emit(MapError('Failed to load map: $e'));
    }
  }

  Future<void> _onUpdateCurrentLocation(
      UpdateCurrentLocation event,
      Emitter<MapState> emit
      ) async {
    final currentState = state;

    if (currentState is MapLoaded) {
      final mapObjects = _createMapObjects(
        currentLocation: event.location,
        markers: currentState.markers,
        selectedMarker: null,
      );

      emit(currentState.copyWith(
        currentLocation: event.location,
        mapObjects: mapObjects,
      ));

      _moveToLocation(event.location);
    } else if (currentState is MarkerSelected) {
      final mapObjects = _createMapObjects(
        currentLocation: event.location,
        markers: currentState.markers,
        selectedMarker: currentState.marker,
      );

      emit(MapLoaded(
        currentLocation: event.location,
        markers: currentState.markers,
        mapObjects: mapObjects,
      ));

      _moveToLocation(event.location);
    } else {
      final mapObjects = _createMapObjects(
        currentLocation: event.location,
        markers: const [],
        selectedMarker: null,
      );

      emit(MapLoaded(
        currentLocation: event.location,
        markers: const [],
        mapObjects: mapObjects,
      ));

      _moveToLocation(event.location);
    }
  }

  void _onAddMarkers(AddMarkers event, Emitter<MapState> emit) {
    final currentState = state;

    if (currentState is MapLoaded) {
      final mapObjects = _createMapObjects(
        currentLocation: currentState.currentLocation,
        markers: event.markers,
        selectedMarker: null,
      );

      emit(currentState.copyWith(
        markers: event.markers,
        mapObjects: mapObjects,
      ));
    } else if (currentState is MarkerSelected) {
      final mapObjects = _createMapObjects(
        currentLocation: currentState.currentLocation,
        markers: event.markers,
        selectedMarker: currentState.marker,
      );

      emit(MapLoaded(
        currentLocation: currentState.currentLocation,
        markers: event.markers,
        mapObjects: mapObjects,
      ));
    } else {
      final mapObjects = _createMapObjects(
        markers: event.markers,
        selectedMarker: null,
      );

      emit(MapLoaded(
        markers: event.markers,
        mapObjects: mapObjects,
      ));
    }
  }

  void _onSelectMarker(SelectMarker event, Emitter<MapState> emit) {
    final currentState = state;
    if (currentState is MapLoaded) {
      final mapObjects = _createMapObjects(
        currentLocation: currentState.currentLocation,
        markers: currentState.markers,
        selectedMarker: event.marker,
      );

      emit(MarkerSelected(
        event.marker,
        mapObjects,
        currentState.currentLocation,
        currentState.markers,
      ));
    } else if (currentState is MarkerSelected) {
      final mapObjects = _createMapObjects(
        currentLocation: currentState.currentLocation,
        markers: currentState.markers,
        selectedMarker: event.marker,
      );

      emit(MarkerSelected(
        event.marker,
        mapObjects,
        currentState.currentLocation,
        currentState.markers,
      ));
    }
  }

  List<MapObject> _createMapObjects({
    Point? currentLocation,
    List<MarkerInfo> markers = const [],
    MarkerInfo? selectedMarker,
  }) {
    final List<MapObject> objects = [];

    if (currentLocation != null) {
      objects.add(
        PlacemarkMapObject(
          mapId: const MapObjectId('current_location'),
          point: currentLocation,
          icon: PlacemarkIcon.single(
            PlacemarkIconStyle(
              image: BitmapDescriptor.fromAssetImage('assets/images/current_loc.png'),
              scale: 0.8,
            ),
          ),
          onTap: (_, point) {
            add(SelectMarker(MarkerInfo(
              id: 'current',
              point: point,
              name: 'Tashkent',
            )));
          },
        ),
      );
    }
    for (final marker in markers) {
      objects.add(
        PlacemarkMapObject(
          mapId: MapObjectId(marker.id),
          point: marker.point,
          icon: PlacemarkIcon.single(
            PlacemarkIconStyle(
              image: BitmapDescriptor.fromAssetImage('assets/images/current_loc.png'),
              scale: 1.0,
            ),
          ),
          onTap: (_, __) {
            add(SelectMarker(marker));
          },
        ),
      );
    }

    return objects;
  }

  void setMapController(YandexMapController controller) {
    mapController = controller;

    _moveToLocation(tashkentLocation);
    if (state is MapLoaded && (state as MapLoaded).currentLocation != null) {
      _moveToLocation((state as MapLoaded).currentLocation!);
    } else if (state is MarkerSelected && (state as MarkerSelected).currentLocation != null) {
      _moveToLocation((state as MarkerSelected).currentLocation!);
    }
  }

  void _moveToLocation(Point location) {
    mapController?.moveCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: location,
          zoom: 14.0,
        ),
      ),
    );
  }
}