import 'package:uuid/uuid.dart';

class PlaceModel {
  final String id;
  final String title;

  PlaceModel({required this.title}) : id = const Uuid().v4();
}
