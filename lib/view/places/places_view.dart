import 'package:favorite_places/view/components/place_list_component.dart';
import 'package:flutter/material.dart';

class PlacesView extends StatelessWidget {
  const PlacesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Places"),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.add))],
      ),
      body: PlaceListComponent(places: []),
    );
  }
}
