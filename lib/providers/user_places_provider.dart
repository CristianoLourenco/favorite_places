import 'dart:io';

import 'package:favorite_places/models/place_model.dart';
import 'package:riverpod/legacy.dart';

class UserPlacesProvider extends StateNotifier<List<PlaceModel>> {
  UserPlacesProvider() : super(const []);

  void addPlace(String title, File image) {
    final newPlace = PlaceModel(title: title, image: image);
    state = [newPlace, ...state];
  }
}

final userPlacesProvider =
    StateNotifierProvider<UserPlacesProvider, List<PlaceModel>>(
      (ref) => UserPlacesProvider(),
    );
