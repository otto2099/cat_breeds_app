import 'package:cat_breeds_app/modules/landing/ui/widgets/breed_card.dart';
import 'package:cat_breeds_app/ui/widgets/animated_logo.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BreedListView extends StatelessWidget {
  final ScrollController scrollController;
  final List<dynamic> breeds;
  final Future<void> Function() onRefresh;

  const BreedListView({
    super.key,
    required this.scrollController,
    required this.breeds,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      child:
          (breeds.isNotEmpty
              ? CustomScrollView(
                controller: scrollController,
                physics: const AlwaysScrollableScrollPhysics(),
                slivers: [
                  SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      if (index == breeds.length) {
                        return const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Center(child: AnimatedLogo()),
                        );
                      }
                      final breed = breeds[index];
                      return BreedCard(
                        breed: breed,
                        onTap: () => context.go('/detail', extra: breed),
                      );
                    }, childCount: breeds.length + 1),
                  ),
                ],
              )
              : const Center(child: AnimatedLogo())),
    );
  }
}
