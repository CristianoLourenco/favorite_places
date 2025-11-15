import 'package:favorite_places/models/place_model.dart';
import 'package:flutter/material.dart';

class PlaceDetailsView extends StatelessWidget {
  final PlaceModel place;
  const PlaceDetailsView({super.key, required this.place});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(place.title)),
      body: Center(
        child: Text(
          place.title,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
      ),
    );
  }
}
