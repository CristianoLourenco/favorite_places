import 'dart:io';

import 'package:dio/dio.dart';
import 'package:favorite_places/env/env.dart';
import 'package:favorite_places/models/location_model.dart';
import 'package:favorite_places/models/place_model.dart';
import 'package:riverpod/legacy.dart';

class UserPlacesProvider extends StateNotifier<List<PlaceModel>> {
  UserPlacesProvider() : super(const []);

  void addPlace(String title, File image, LocationModel location) {
    final newPlace = PlaceModel(title: title, image: image, location: location);
    state = [newPlace, ...state];
  }

  Future<String?> getLocation(double lat, double long) async {
    try {
      final dioClient = Dio();

      final url =
          "https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$long&key=${Env.googleApiKey}";

      final result = await dioClient.get(url);

      if (result.statusCode == 200) {
        final finalLocation = result.data['results'][0]['formatted_address'];

        return finalLocation;
      }
    } catch (e) {
      return null;
    }
    return null;
  }

  String getImageLocation(double lat, double long) {
    return "https://maps.googleapis.com/maps/api/staticmap?center=$lat,$long&zoom=10&size=600x300&maptype=roadmap&markers=color:red%7Clabel:A%7C$lat,$long&&key=${Env.googleApiKey}";
  }
}

final userPlacesProvider =
    StateNotifierProvider<UserPlacesProvider, List<PlaceModel>>(
      (ref) => UserPlacesProvider(),
    );
