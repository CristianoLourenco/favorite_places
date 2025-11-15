import 'package:favorite_places/models/place_model.dart';
import 'package:flutter/material.dart';

class PlaceDetailsView extends StatelessWidget {
  final PlaceModel place;
  const PlaceDetailsView({super.key, required this.place});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(place.title)),
      body: Stack(
        children: [
          Image.file(
            place.image,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
        ],
      ),
    );
  }
}
