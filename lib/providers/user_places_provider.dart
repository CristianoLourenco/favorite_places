import 'package:favorite_places/models/place_model.dart';
import 'package:riverpod/legacy.dart';

class UserPlacesProvider extends StateNotifier<List<PlaceModel>> {
  UserPlacesProvider() : super(const []);

  void addPlace(String title) {
    final newPlace = PlaceModel(title: title);

    state = [newPlace, ...state];
  }
}

final userPlacesProvider =
    StateNotifierProvider<UserPlacesProvider, List<PlaceModel>>(
      (ref) => UserPlacesProvider(),
    );
