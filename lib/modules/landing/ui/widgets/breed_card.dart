import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class BreedCard extends StatelessWidget {
  final dynamic breed;
  final VoidCallback onTap;

  const BreedCard({super.key, required this.breed, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(12),
                  ),
                  child: Image.network(
                    breed.image.url,
                    height: 500,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Shimmer.fromColors(
                        baseColor: Colors.grey.shade300,
                        highlightColor: Colors.grey.shade100,
                        child: Container(
                          height: 500,
                          width: double.infinity,
                          color: Colors.grey.shade300,
                        ),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return Shimmer.fromColors(
                        baseColor: Colors.grey.shade300,
                        highlightColor: Colors.grey.shade100,
                        child: Container(
                          height: 500,
                          width: double.infinity,
                          color: Colors.grey.shade300,
                          child: const Center(
                            child: Icon(
                              Icons.error,
                              color: Colors.red,
                              size: 50,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                _buildHeader(breed.name),
              ],
            ),
            _buildFooter(breed),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(String name) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [_label(name), _label('Más')],
    );
  }

  Widget _label(String text) {
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.black54,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildFooter(dynamic breed) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Icon(Icons.flag, size: 16),
              const SizedBox(width: 4),
              Text(breed.origin),
            ],
          ),
          Row(
            children: [
              const Icon(Icons.school, size: 16),
              const SizedBox(width: 4),
              Text('Inteligencia: ${breed.intelligence}'),
            ],
          ),
        ],
      ),
    );
  }
}
