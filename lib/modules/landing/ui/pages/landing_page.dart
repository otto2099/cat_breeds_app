import 'package:cat_breeds_app/modules/landing/blocs/landing_bloc.dart';
import 'package:cat_breeds_app/modules/landing/blocs/landing_event.dart';
import 'package:cat_breeds_app/modules/landing/blocs/landing_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  late ScrollController _scrollController;
  late TextEditingController _searchController;
  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _searchController = TextEditingController();

    context.read<LandingBloc>().add(LoadCatImages(page: 0));

    // Detectar cuando el usuario ha llegado al final del scroll
    _scrollController.addListener(() {
      if (_scrollController.position.atEdge &&
          _scrollController.position.pixels != 0) {
        // Cargar más imágenes cuando el usuario llega al final
        context.read<LandingBloc>().add(
          LoadCatImages(page: context.read<LandingBloc>().currentPage),
        );
      }
    });

    _searchController.addListener(() {
      final query = _searchController.text;
      // context.read<LandingBloc>().add(SearchCatImages(query: query));
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CatBreeds'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(56),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Buscar raza...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey.shade400),
                ),
                suffixIcon: Icon(Icons.search),
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<LandingBloc, LandingState>(
          builder: (context, state) {
            if (state is LandingLoading) {
              return Center(child: CircularProgressIndicator());
            }

            if (state is LandingError) {
              return Center(child: Text(state.message));
            }

            if (state is LandingLoaded) {
              return ListView.builder(
                controller: _scrollController,
                itemCount: state.images.length + 1,
                itemBuilder: (context, index) {
                  if (index == state.images.length) {
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }

                  final image = state.images[index];

                  return Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
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
                                image.url,
                                height: 500,
                                width: double.infinity,
                                fit: BoxFit.cover,
                                loadingBuilder: (
                                  context,
                                  child,
                                  loadingProgress,
                                ) {
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
                              ),
                            ),
                            Positioned(
                              top: 8,
                              left: 8,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.black54,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  image.breeds.first.name,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 8,
                              right: 8,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.black54,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Text(
                                  'Más',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  const Icon(Icons.flag, size: 16),
                                  const SizedBox(width: 4),
                                  Text(image.breeds.first.origin),
                                ],
                              ),
                              Row(
                                children: [
                                  const Icon(Icons.school, size: 16),
                                  const SizedBox(width: 4),
                                  Text(
                                    'Inteligencia: ${image.breeds.first.intelligence}',
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            }

            return Center(child: Text("No hay imágenes disponibles"));
          },
        ),
      ),
    );
  }
}
