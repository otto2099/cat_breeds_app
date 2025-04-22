import 'dart:async';
import 'package:cat_breeds_app/modules/landing/ui/widgets/breed_list_view.dart';
import 'package:cat_breeds_app/modules/landing/ui/widgets/search_history_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cat_breeds_app/modules/landing/blocs/landing_bloc.dart';
import 'package:cat_breeds_app/modules/landing/blocs/landing_event.dart';
import 'package:cat_breeds_app/modules/landing/blocs/landing_state.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  late final ScrollController _scrollController;
  late final TextEditingController _searchController;
  late final FocusNode _searchFocusNode;
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

    _loadInitialData();
    _setupListeners();
  }

  void _loadInitialData() {
    context.read<LandingBloc>().add(LoadCatImages(page: 0));
    context.read<LandingBloc>().add(LoadSearchHistory());
  }

  void _setupListeners() {
    _searchFocusNode.addListener(() {
      if (_searchFocusNode.hasFocus) {
        setState(() => _showHistory = true);
        context.read<LandingBloc>().add(LoadSearchHistory());
      } else if (_searchController.text.isEmpty) {
        setState(() => _showHistory = false);
        context.read<LandingBloc>().add(LoadCatImages(page: 0));
      }
    });

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent - 200 &&
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
      _debounce?.cancel();
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
                      context.read<LandingBloc>().add(
                        SearchCatImages(query: ' ', page: 1),
                      );
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
                        ? SearchHistoryList(
                          history: _localSearchHistory,
                          onSelect: (term) {
                            _searchController.text = term;
                            _searchFocusNode.unfocus();
                            setState(() => _showHistory = false);
                            context.read<LandingBloc>().add(
                              SearchCatImages(query: term, page: 0),
                            );
                          },
                          onClear: () {
                            context.read<LandingBloc>().add(
                              ClearSearchHistory(),
                            );
                            context.read<LandingBloc>().add(
                              LoadSearchHistory(),
                            );
                          },
                        )
                        : BreedListView(
                          scrollController: _scrollController,
                          breeds: _breeds,
                          onRefresh: () async {
                            _searchController.clear();
                            FocusScope.of(context).unfocus();
                            setState(() => _showHistory = false);
                            context.read<LandingBloc>().add(
                              SearchCatImages(query: ' ', page: 1),
                            );
                          },
                        ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
