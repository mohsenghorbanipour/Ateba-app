import 'package:ateba_app/modules/categories/bloc/categories_bloc.dart';
import 'package:ateba_app/modules/home/ui/widgets/course_shimmer_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryDataWidget extends StatelessWidget {
  const CategoryDataWidget({super.key});

  @override
  Widget build(BuildContext context) =>
      !context.select<CategoriesBloc, bool>((bloc) => bloc.loading)
          ? Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: 10,
                separatorBuilder: (_, __) => const SizedBox(
                  height: 16,
                ),
                itemBuilder: (_, __) => const CourseShimmerCard(),
              ),
            )
          : Container();
}
