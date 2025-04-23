import 'dart:async';
import 'package:cat_breeds_app/modules/landing/ui/widgets/breed_list_view.dart';
import 'package:cat_breeds_app/modules/landing/ui/widgets/search_history_list.dart';
import 'package:cat_breeds_app/ui/widgets/animated_logo.dart';
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
        context.read<LandingBloc>().add(LoadSearchHistory());
      } else if (_searchController.text.isEmpty) {}
    });

    _scrollController.addListener(() {
      final bloc = context.read<LandingBloc>();
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent - 200 &&
          !bloc.isLoading) {
        bloc.add(LoadCatImages(page: bloc.currentPage));
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
        } else {}
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
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
        body: BlocBuilder<LandingBloc, LandingState>(
          builder: (context, state) {
            // final bloc = context.read<LandingBloc>();
            final isShowingHistory =
                _searchFocusNode.hasFocus &&
                state is SearchHistoryLoaded &&
                state.searchHistory.isNotEmpty;

            if (isShowingHistory) {
              return SearchHistoryList(
                history: state.searchHistory,
                onSelect: (term) {
                  _searchController.text = term;
                  _searchFocusNode.unfocus();
                  context.read<LandingBloc>().add(
                    SearchCatImages(query: term, page: 0),
                  );
                },
                onClear: () {
                  context.read<LandingBloc>().add(ClearSearchHistory());
                },
              );
            } else if (state is LandingLoaded) {
              return BreedListView(
                scrollController: _scrollController,
                breeds: state.images,
                onRefresh: () async {
                  _searchController.clear();
                  FocusScope.of(context).unfocus();
                  context.read<LandingBloc>().add(
                    SearchCatImages(query: ' ', page: 1),
                  );
                },
              );
            } else if (state is LandingError) {
              return Center(child: Text(state.message));
            } else {
              return const Center(child: AnimatedLogo());
            }
          },
        ),
      ),
    );
  }
}
