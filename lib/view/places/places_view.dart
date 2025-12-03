import 'package:favorite_places/providers/user_places_provider.dart';
import 'package:favorite_places/view/add_place/add_place_view.dart';
import 'package:favorite_places/view/components/place_list_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlacesView extends ConsumerStatefulWidget {
  const PlacesView({super.key});

  @override
  ConsumerState<PlacesView> createState() {
    return _PlacesViewState();
  }
}

class _PlacesViewState extends ConsumerState<PlacesView> {
  late Future<void> _placeListLoading;

  @override
  void initState() {
    super.initState();
    _placeListLoading = ref.read(userPlacesProvider.notifier).loadPlaces();
  }

  @override
  Widget build(BuildContext context) {
    final userPlaces = ref.watch(userPlacesProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Places"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (context) => AddPlaceView()));
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder(
          future: _placeListLoading,
          builder: (context, snapshot) =>
              snapshot.connectionState == ConnectionState.waiting
              ? const Center(child: CircularProgressIndicator())
              : PlaceListComponent(places: userPlaces),
        ),
      ),
    );
  }
}
