import 'dart:io';

import 'package:favorite_places/models/location_model.dart';
import 'package:favorite_places/providers/user_places_provider.dart';
import 'package:favorite_places/view/components/image_input_component.dart';
import 'package:favorite_places/view/components/location_input_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddPlaceView extends ConsumerStatefulWidget {
  const AddPlaceView({super.key});

  @override
  ConsumerState<AddPlaceView> createState() => _AddPlaceViewState();
}

class _AddPlaceViewState extends ConsumerState<AddPlaceView> {
  late final TextEditingController _titleController;
  File? _selectedImage;
  LocationModel? _locationModel;

  void _savePlace() {
    final enteredText = _titleController.text;
    if (enteredText.isEmpty ||
        _selectedImage == null ||
        _locationModel == null) {
      return;
    }

    ref
        .read(userPlacesProvider.notifier)
        .addPlace(enteredText, _selectedImage!, _locationModel!);
    Navigator.of(context).pop();
  }

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add new Place')),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              controller: _titleController,
              style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
            ),
            const SizedBox(height: 16),
            ImageInputComponent(
              onPickeImage: (image) {
                _selectedImage = image;
              },
            ),
            const SizedBox(height: 16),
            LocationInputComponent((location) {}),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: _savePlace,
              icon: Icon(Icons.add),
              label: Text('Add Place'),
            ),
          ],
        ),
      ),
    );
  }
}
