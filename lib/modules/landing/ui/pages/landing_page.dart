// [IMPORTS]
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cat_breeds_app/modules/landing/blocs/landing_bloc.dart';
import 'package:cat_breeds_app/modules/landing/blocs/landing_event.dart';
import 'package:cat_breeds_app/modules/landing/blocs/landing_state.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  late ScrollController _scrollController;
  late TextEditingController _searchController;
  late FocusNode _searchFocusNode;
  bool _showHistory = false;
  bool _isLoadingMore = false;
  List<String> _localSearchHistory = [];
  List<dynamic> _breeds = [];
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _searchController = TextEditingController();
    _searchFocusNode = FocusNode();

    context.read<LandingBloc>().add(LoadCatImages(page: 0));
    context.read<LandingBloc>().add(LoadSearchHistory());

    _searchFocusNode.addListener(() {
      if (_searchFocusNode.hasFocus) {
        setState(() => _showHistory = true);
        context.read<LandingBloc>().add(LoadSearchHistory());
      } else {
        if (_searchController.text.isEmpty) {
          setState(() => _showHistory = false);
          context.read<LandingBloc>().add(LoadCatImages(page: 0));
        }
      }
    });

    _scrollController.addListener(() {
      final position = _scrollController.position;
      if (position.pixels >= position.maxScrollExtent - 200 &&
          !_isLoadingMore) {
        _isLoadingMore = true;
        context.read<LandingBloc>().add(
          LoadCatImages(page: context.read<LandingBloc>().currentPage),
        );
      }

      if (_searchFocusNode.hasFocus) {
        _searchFocusNode.unfocus();
      }
    });

    _searchController.addListener(() {
      final query = _searchController.text;
      if (_debounce?.isActive ?? false) _debounce!.cancel();
      _debounce = Timer(const Duration(seconds: 2), () {
        if (query.isNotEmpty) {
          context.read<LandingBloc>().add(
            SearchCatImages(query: query, page: 0),
          );
          context.read<LandingBloc>().add(AddSearchTerm(searchTerm: query));
          setState(() => _showHistory = false);
        } else {
          context.read<LandingBloc>().add(LoadCatImages(page: 0));
          context.read<LandingBloc>().add(LoadSearchHistory());
        }
      });
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _scrollController.dispose();
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  Widget _buildBreedCard(dynamic breed) {
    return Card(
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
                          child: Icon(Icons.error, color: Colors.red, size: 50),
                        ),
                      ),
                    );
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
                    breed.name,
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
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        if (_searchController.text.isEmpty) {
          setState(() => _showHistory = false);
          context.read<LandingBloc>().add(LoadCatImages(page: 0));
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('CatBreeds'),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(56),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _searchController,
                focusNode: _searchFocusNode,
                decoration: InputDecoration(
                  hintText: 'Buscar raza...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.grey.shade400),
                  ),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      _searchController.clear();
                      context.read<LandingBloc>().add(LoadCatImages(page: 0));
                      setState(() => _showHistory = true);
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
        body: BlocListener<LandingBloc, LandingState>(
          listenWhen:
              (previous, current) =>
                  current is SearchHistoryLoaded || current is LandingLoaded,
          listener: (context, state) {
            if (state is SearchHistoryLoaded) {
              setState(() => _localSearchHistory = state.searchHistory);
            }
            if (state is LandingLoaded) {
              setState(() {
                _breeds = state.images;
                _isLoadingMore = false;
              });
            }
          },
          child: Column(
            children: [
              Expanded(
                child:
                    (_showHistory && _localSearchHistory.isNotEmpty)
                        ? Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Historial de búsqueda',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      context.read<LandingBloc>().add(
                                        ClearSearchHistory(),
                                      );
                                      context.read<LandingBloc>().add(
                                        LoadSearchHistory(),
                                      );
                                    },
                                    child: const Text('Limpiar'),
                                  ),
                                ],
                              ),
                              const Divider(height: 1),
                              Expanded(
                                child: ListView.separated(
                                  itemCount: _localSearchHistory.length,
                                  itemBuilder: (_, index) {
                                    final term = _localSearchHistory[index];
                                    return ListTile(
                                      leading: const Icon(Icons.history),
                                      title: Text(term),
                                      onTap: () {
                                        _searchController.text = term;
                                        _searchFocusNode.unfocus();
                                        setState(() => _showHistory = false);
                                        context.read<LandingBloc>().add(
                                          SearchCatImages(query: term, page: 0),
                                        );
                                      },
                                    );
                                  },
                                  separatorBuilder:
                                      (_, __) => const Divider(height: 1),
                                ),
                              ),
                            ],
                          ),
                        )
                        : RefreshIndicator(
                          onRefresh: () async {
                            _searchController.clear();
                            FocusScope.of(context).unfocus();
                            setState(() => _showHistory = false);
                            context.read<LandingBloc>().add(
                              SearchCatImages(query: ' ', page: 0),
                            );
                          },
                          child:
                              (_breeds.isNotEmpty
                                  ? CustomScrollView(
                                    controller: _scrollController,
                                    physics:
                                        const AlwaysScrollableScrollPhysics(),
                                    slivers: [
                                      SliverList(
                                        delegate: SliverChildBuilderDelegate((
                                          context,
                                          index,
                                        ) {
                                          if (index == _breeds.length) {
                                            return const Padding(
                                              padding: EdgeInsets.all(16.0),
                                              child: Center(
                                                child: SizedBox.shrink(),
                                              ),
                                            );
                                          }
                                          final breed = _breeds[index];
                                          return GestureDetector(
                                            onTap: () {
                                              context.go(
                                                '/detail',
                                                extra: breed,
                                              );
                                            },
                                            child: _buildBreedCard(breed),
                                          );
                                        }, childCount: _breeds.length + 1),
                                      ),
                                    ],
                                  )
                                  : const Center(
                                    child: Text("No hay imágenes disponibles"),
                                  )),
                        ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
