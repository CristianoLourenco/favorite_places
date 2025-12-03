import 'dart:io';

import 'package:favorite_places/models/location_model.dart';
import 'package:uuid/uuid.dart';

class PlaceModel {
  final String id;
  final String title;
  final File image;
  final LocationModel location;

  PlaceModel({
    required this.title,
    required this.image,
    required this.location,
    String? id,
  }) : id = id ?? const Uuid().v4();
}
