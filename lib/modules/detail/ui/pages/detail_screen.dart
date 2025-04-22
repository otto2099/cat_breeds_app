import 'package:cat_breeds_app/core/models/breeds_models.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';

class BreedDetailScreen extends StatelessWidget {
  final CatBreedModel breed;

  const BreedDetailScreen({super.key, required this.breed});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(breed.name),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            context.go('/landing');
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),

        child: Column(
          children: [
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(12)),
                child: Image.network(
                  breed.image.url,
                  height: 500,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    } else {
                      return Shimmer.fromColors(
                        baseColor: Colors.grey.shade300,
                        highlightColor: Colors.grey.shade100,
                        child: Container(
                          height: 500,
                          width: double.infinity,
                          color: Colors.grey.shade300,
                        ),
                      );
                    }
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      child: Container(
                        height: 500,
                        width: double.infinity,
                        color: Colors.grey.shade300,
                        child: Center(
                          child: Icon(Icons.error, color: Colors.red, size: 50),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            Expanded(
              child: CustomScrollView(
                slivers: [
                  SliverPadding(
                    padding: const EdgeInsets.all(8.0),
                    sliver: SliverList(
                      delegate: SliverChildListDelegate([
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                breed.name,
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                breed.description,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey.shade700,
                                  height: 1.5,
                                ),
                              ),
                              SizedBox(height: 20),
                              Row(
                                children: [
                                  Icon(
                                    Icons.flag,
                                    size: 20,
                                    color: Colors.teal,
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    'Origen: ${breed.origin}',
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              Row(
                                children: [
                                  Icon(
                                    Icons.school,
                                    size: 20,
                                    color: Colors.teal,
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    'Inteligencia: ${breed.intelligence}',
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              Row(
                                children: [
                                  Icon(
                                    Icons.access_alarm,
                                    size: 20,
                                    color: Colors.teal,
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    'Esperanza de vida: ${breed.lifeSpan} años',
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ],
                              ),

                              SizedBox(height: 20),
                              SizedBox(height: 20),
                              _buildExternalLink(
                                'Wikipedia',
                                breed.wikipediaUrl,
                              ),
                              _buildExternalLink('CFA', breed.cfaUrl),
                              _buildExternalLink(
                                'Vetstreet',
                                breed.vetstreetUrl,
                              ),
                              SizedBox(height: 50),
                            ],
                          ),
                        ),
                      ]),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExternalLink(String label, String url) {
    return GestureDetector(
      onTap: () {},
      child: Card(
        elevation: 5.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              Icon(Icons.link, color: Colors.teal, size: 20.0),
              SizedBox(width: 10),
              Text(
                label,
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 16,
                  decoration: TextDecoration.underline,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
