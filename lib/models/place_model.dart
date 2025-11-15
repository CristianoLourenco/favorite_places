import 'dart:io';

import 'package:uuid/uuid.dart';

class PlaceModel {
  final String id;
  final String title;
  final File image;

  PlaceModel({required this.title, required this.image})
    : id = const Uuid().v4();
}
