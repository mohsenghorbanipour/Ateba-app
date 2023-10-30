import 'package:ateba_app/modules/categories/bloc/categories_bloc.dart';
import 'package:ateba_app/modules/categories/data/models/category.dart';
import 'package:ateba_app/modules/categories/ui/widgets/category_card.dart';
import 'package:ateba_app/modules/categories/ui/widgets/category_card_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoriesWidget extends StatelessWidget {
  const CategoriesWidget({super.key});

  @override
  Widget build(BuildContext context) => context
          .select<CategoriesBloc, bool>((bloc) => bloc.loading)
      ? Expanded(
          child: GridView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 28),
            physics: const BouncingScrollPhysics(),
            itemCount: 30,
            itemBuilder: (context, index) => const CategoryCardShimmer(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 16,
              mainAxisExtent: 104,
              mainAxisSpacing: 28,
            ),
          ),
        )
      : Expanded(
          child: Selector<CategoriesBloc, List<Category>>(
            selector: (context, bloc) => bloc.categories,
            builder: (context, categories, child) => GridView.builder(
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 28),
              physics: const BouncingScrollPhysics(),
              itemCount: categories.length,
              itemBuilder: (context, index) => CategoryCard(
                category: categories[index],
              ),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 16,
                mainAxisExtent: 104,
                mainAxisSpacing: 28,
              ),
            ),
          ),
        );
}
