import 'package:favorite_places/models/location_model.dart';
import 'package:favorite_places/providers/user_places_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:location/location.dart';

class LocationInputComponent extends ConsumerStatefulWidget {
  final void Function(LocationModel location) onLocationAdded;

  const LocationInputComponent(this.onLocationAdded, {super.key});

  @override
  ConsumerState<LocationInputComponent> createState() =>
      _LocationInputComponentState();
}

class _LocationInputComponentState
    extends ConsumerState<LocationInputComponent> {
  LocationModel? _pickedLocation;

  final _isGetingLocation = ValueNotifier<bool>(false);

  void getCurrentLocation() async {
    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    _isGetingLocation.value = true;
    locationData = await location.getLocation();
    final address = await ref
        .read(userPlacesProvider.notifier)
        .getLocation(
          locationData.latitude.toString(),
          locationData.longitude.toString(),
        );

    if (address == null ||
        locationData.latitude == null ||
        locationData.longitude == null) {
      return;
    }
    _pickedLocation = LocationModel(
      latitude: locationData.latitude!,
      longitude: locationData.longitude!,
      address: address,
    );
    _isGetingLocation.value = false;
  }

  @override
  Widget build(BuildContext context) {
    Widget contentWidget = Container();
    return Column(
      children: [
        ValueListenableBuilder(
          valueListenable: _isGetingLocation,
          builder: (context, isGetingLocationValue, child) {
            if (isGetingLocationValue) {
              contentWidget = CircularProgressIndicator();
            }
            if (!isGetingLocationValue) {
              contentWidget = Text(
                "No location chosen",
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              );
            }

            if (_pickedLocation != null) {
              final imageUrl = ref
                  .read(userPlacesProvider.notifier)
                  .getImageLocation(
                    _pickedLocation!.latitude,
                    _pickedLocation!.longitude,
                  );

              contentWidget = Image.network(
                imageUrl,
                height: double.infinity,
                width: double.infinity,
                fit: BoxFit.cover,
              );
            }
            return Container(
              height: 170,
              width: double.infinity,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1,
                  color: Theme.of(
                    context,
                  ).colorScheme.primary.withAlpha((255 * 0.2).toInt()),
                ),
              ),

              child: contentWidget,
            );
          },
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton.icon(
              onPressed: getCurrentLocation,
              icon: const Icon(Icons.location_on),
              label: const Text("Get current location"),
            ),
            TextButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.map),
              label: const Text("Select on Map"),
            ),
          ],
        ),
      ],
    );
  }
}
