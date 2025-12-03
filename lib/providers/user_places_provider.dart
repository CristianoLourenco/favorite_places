import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:favorite_places/env/env.dart';
import 'package:favorite_places/models/location_model.dart';
import 'package:favorite_places/models/place_model.dart';
import 'package:flutter/widgets.dart';
import 'package:riverpod/legacy.dart';
import 'package:path_provider/path_provider.dart' as syspaths;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;

class UserPlacesProvider extends StateNotifier<List<PlaceModel>> {
  UserPlacesProvider() : super(const []);

  void addPlace(String title, File image, LocationModel location) async {
    final appDir = await syspaths.getApplicationDocumentsDirectory();
    final fileNmae = path.basename(image.path);
    final savedImage = await image.copy('${appDir.path}/$fileNmae');

    debugPrint('Image saved at: ${savedImage.path}');
    log('Image saved at: ${savedImage.path}');

    final newPlace = PlaceModel(
      title: title,
      image: savedImage,
      location: location,
    );

    final dbPath = await sql.getDatabasesPath();
    final db = await sql.openDatabase(
      path.join(dbPath, 'places.db'),
      version: 1,
      onCreate: (db, version) {
        return db.execute('''CREATE TABLE user_places(
            id TEXT PRIMARY KEY, 
            title TEXT, 
            image TEXT, 
            lat REAL, 
            lng REAL, 
            address TEXT
            )''');
      },
    );
    await db.insert('user_places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path,
      'lat': newPlace.location.latitude,
      'lng': newPlace.location.longitude,
      'address': newPlace.location.address,
    });
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
    return "https://maps.googleapis.com/maps/api/staticmap?center=$lat,$long&zoom=8&size=600x300&maptype=roadmap&markers=color:red%7Clabel:A%7C$lat,$long&&key=${Env.googleApiKey}";
  }
}

final userPlacesProvider =
    StateNotifierProvider<UserPlacesProvider, List<PlaceModel>>(
      (ref) => UserPlacesProvider(),
    );
