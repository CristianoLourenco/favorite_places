import 'package:favorite_places/models/place_model.dart';
import 'package:favorite_places/view/details/place_details_view.dart';
import 'package:flutter/material.dart';

class PlaceListComponent extends StatelessWidget {
  final List<PlaceModel> places;

  const PlaceListComponent({super.key, required this.places});

  @override
  Widget build(BuildContext context) {
    if (places.isEmpty) {
      return Center(
        child: Text(
          "No places added yet",
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
      );
    }
    return ListView.builder(
      itemCount: places.length,
      itemBuilder: (context, index) {
        return ListTile(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => PlaceDetailsView(place: places[index]),
              ),
            );
          },
          title: Text(
            places[index].title,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
        );
      },
    );
  }
}
