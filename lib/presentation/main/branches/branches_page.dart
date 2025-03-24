import 'package:auto_route/auto_route.dart';
import 'package:e_comerce_app/common/base/base_app_bar.dart';
import 'package:e_comerce_app/common/extensions/text_extensions.dart';
import 'package:e_comerce_app/common/extensions/theme_extensions.dart';
import 'package:e_comerce_app/data/local_models/marker_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

import 'bloc/branches_bloc.dart';
import 'bloc/branches_state.dart';

@RoutePage()
class BranchesPage extends StatefulWidget {
  const BranchesPage({super.key});

  @override
  State<BranchesPage> createState() => _BranchesPageState();
}

class _BranchesPageState extends State<BranchesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BaseAppBar(
        title: "Карта",
      ),
      body: BlocConsumer<MapBloc, MapState>(
        listener: (context, state) {
          if (state is MapError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          } else if (state is MarkerSelected) {
            _showMarkerInfo(context, state.marker);
          }
        },
        builder: (context, state) {
          if (state is MapLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          List<MapObject> mapObjects = [];

          if (state is MapLoaded) {
            mapObjects = state.mapObjects;
          } else if (state is MarkerSelected) {
            mapObjects = state.mapObjects;
          } else {
            return  Center(
              child: 'Failed to load map'.s(16).w(400).c(context.colors.primary2),
            );
          }

          return Stack(
            children: [
              YandexMap(
                zoomGesturesEnabled: true,
                onMapCreated: (controller) {
                  context.read<MapBloc>().setMapController(controller);
                },
                mapObjects: mapObjects,
              ),
              // Positioned(
              //   bottom: 16,
              //   right: 16,
              //   child: FloatingActionButton(
              //     onPressed: () {
              //       if (state is MapLoaded && state.currentLocation != null) {
              //         context.read<MapBloc>().add(
              //             UpdateCurrentLocation(state.currentLocation!)
              //         );
              //       } else if (state is MarkerSelected && state.currentLocation != null) {
              //         context.read<MapBloc>().add(
              //             UpdateCurrentLocation(state.currentLocation!)
              //         );
              //       }
              //     },
              //     child: Icon(CupertinoIcons.zoom_in),
              //   ),
              // ),
            ],
          );
        },
      ),
    );
  }

  void _showMarkerInfo(BuildContext context, MarkerInfo marker) {
    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: marker.name.s(14).w(400).c(context.colors.primary2),
        content: 
          'Latitude: ${marker.point.latitude.toStringAsFixed(6)}\nLongitude: ${marker.point.longitude.toStringAsFixed(6)}'.s(14).w(400).c(context.colors.primary2),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: 'Close'.c(context.colors.primary2),
          ),
        ],
      ),
    );
  }
}