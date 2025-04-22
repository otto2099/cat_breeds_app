import 'package:flutter/material.dart';

class BreedDetailScreen extends StatelessWidget {
  final String breedId;
  const BreedDetailScreen({super.key, required this.breedId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Detalle del Gato: $breedId')),
      body: Center(
        child: Text('Información del Gato con ID: $breedId'),
      ),
    );
  }
}
