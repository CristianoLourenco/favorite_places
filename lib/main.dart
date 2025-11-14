import 'package:favorite_places/config/theme_config.dart';
import 'package:favorite_places/view/places/places_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Favourite Places',
      theme: ThemeConfig.theme,
      home: const PlacesView(),
    );
  }
}
