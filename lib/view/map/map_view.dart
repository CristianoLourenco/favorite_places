import 'dart:async';

import 'package:favorite_places/models/location_model.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapView extends StatefulWidget {
  final LocationModel location;
  final bool isSelecting;

  const MapView({super.key, required this.location, this.isSelecting = false});

  @override
  State<MapView> createState() => _MapViewState();
}

/*

const LocationModel(latitude: 37.422, longitude: -122.084, address: "", mapImageAddress: ""),
*/
class _MapViewState extends State<MapView> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.isSelecting ? "Pick your Location" : "Your location",
        ),

        actions: [
          if (widget.isSelecting)
            IconButton(onPressed: () {}, icon: const Icon(Icons.save)),
        ],
      ),

      body: GoogleMap(
        mapType: MapType.hybrid,
        onMapCreated: (controller) => _controller.complete(controller),
        initialCameraPosition: _kGooglePlex,

        // CameraPosition(
        //   target: LatLng(widget.location.latitude, widget.location.longitude),
        //   zoom: 10,
        // ),

        // markers: {
        //   Marker(
        //     markerId: const MarkerId("m1"),
        //     position: LatLng(
        //       widget.location.latitude,
        //       widget.location.longitude,
        //     ),
        //   ),
        // },
      ),
    );
  }
}
