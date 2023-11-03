import 'package:ateba_app/core/utils/logger_helper.dart';
import 'package:ateba_app/modules/categories/bloc/categories_bloc.dart';
import 'package:ateba_app/modules/home/data/models/course.dart';
import 'package:ateba_app/modules/home/ui/widgets/course_card.dart';
import 'package:ateba_app/modules/home/ui/widgets/course_shimmer_card.dart';
import 'package:ateba_app/modules/home/ui/widgets/package_card.dart';
import 'package:ateba_app/modules/home/ui/widgets/package_shimmer_card.dart';
import 'package:flutter/material.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:provider/provider.dart';

class CategoryDataWidget extends StatelessWidget {
  const CategoryDataWidget({super.key});

  @override
  Widget build(BuildContext context) => context
          .select<CategoriesBloc, bool>((bloc) => bloc.loading)
      ? context.select<CategoriesBloc, bool>((bloc) =>
              bloc.categoriesDataType == CategoriesDataType.educationalPackages)
          ? Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: 10,
                separatorBuilder: (_, __) => const SizedBox(
                  height: 16,
                ),
                itemBuilder: (_, __) => const PackageShimmerCard(
                  width: double.infinity,
                ),
              ),
            )
          : Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: 10,
                separatorBuilder: (_, __) => const SizedBox(
                  height: 16,
                ),
                itemBuilder: (_, __) => const CourseShimmerCard(
                  width: double.infinity,
                  height: 180,
                ),
              ),
            )
      : LazyLoadScrollView(
          onEndOfPage: () {
            if (Provider.of<CategoriesBloc>(context, listen: false)
                .canLoadMore) {
              Provider.of<CategoriesBloc>(context, listen: false)
                  .loadMoreCategoryData();
            }
          },
          isLoading:
              context.select<CategoriesBloc, bool>((bloc) => bloc.loadingMore),
          child: Expanded(
            child: Consumer<CategoriesBloc>(
              builder: (context, bloc, child) =>
                  bloc.categoriesDataType == CategoriesDataType.medicalCourses
                      ? ListView.separated(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 24),
                          itemCount: bloc.courses.length,
                          separatorBuilder: (_, __) => const SizedBox(
                            height: 16,
                          ),
                          itemBuilder: (context, index) => CourseCard(
                            course: bloc.courses[index],
                            width: double.infinity,
                          ),
                        )
                      : ListView.separated(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 24),
                          itemCount: bloc.packages.length,
                          separatorBuilder: (_, __) => const SizedBox(
                            height: 16,
                          ),
                          itemBuilder: (context, index) => PackageCard(
                            package: bloc.packages[index],
                            width: double.infinity,
                          ),
                        ),
            ),
          ),
        );
}
