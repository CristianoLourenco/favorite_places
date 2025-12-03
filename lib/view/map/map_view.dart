import 'dart:async';

import 'package:favorite_places/models/location_model.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapView extends StatefulWidget {
  final LocationModel location;
  final bool isSelecting;

  const MapView({
    super.key,
    this.location = const LocationModel(
      latitude: 0,
      longitude: 0,
      address: '',
      mapImageAddress: '',
    ),
    this.isSelecting = true,
  });

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  LatLng? _pickedLocation;

  @override
  void initState() {
    super.initState();
    if (widget.isSelecting) {
      _pickedLocation = LatLng(
        widget.location.latitude,
        widget.location.longitude,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.isSelecting ? "Pick your Location" : "Your location",
        ),

        actions: [
          if (widget.isSelecting)
            IconButton(
              onPressed: () {
                Navigator.of(context).pop(_pickedLocation);
              },
              icon: const Icon(Icons.save),
            ),
        ],
      ),

      body: GoogleMap(
        mapType: MapType.normal,
        onTap: !widget.isSelecting
            ? null
            : (location) {
                setState(() {
                  _pickedLocation = location;
                });
              },
        onMapCreated: (controller) => _controller.complete(controller),
        initialCameraPosition: CameraPosition(
          target: LatLng(widget.location.latitude, widget.location.longitude),
          zoom: 8.4746,
        ),

        markers: (_pickedLocation == null && widget.isSelecting)
            ? {}
            : {
                Marker(
                  markerId: const MarkerId("m1"),
                  position:
                      _pickedLocation ??
                      LatLng(
                        widget.location.latitude,
                        widget.location.longitude,
                      ),
                ),
              },
      ),
    );
  }
}
