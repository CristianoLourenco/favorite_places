import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class LocationInputComponent extends StatefulWidget {
  const LocationInputComponent({super.key});

  @override
  State<LocationInputComponent> createState() => _LocationInputComponentState();
}

class _LocationInputComponentState extends State<LocationInputComponent> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
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

          child: Text(
            "No location chosen",
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton.icon(
              onPressed: () {},
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
