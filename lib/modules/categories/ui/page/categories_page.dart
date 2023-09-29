import 'package:ateba_app/core/theme/style/color_palatte.dart';
import 'package:ateba_app/modules/categories/bloc/categories_bloc.dart';
import 'package:ateba_app/modules/categories/ui/widgets/categories_tab_widget.dart';
import 'package:ateba_app/modules/categories/ui/widgets/education_video_category_card.dart';
import 'package:ateba_app/modules/home/bloc/home_bloc.dart';
import 'package:ateba_app/modules/home/ui/widgets/package_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({super.key});

  @override
  Widget build(BuildContext context) => Column(
        children: [
          const CategoriesTabWidget(),
          const SizedBox(
            height: 4,
          ),
          if (context.select<CategoriesBloc, bool>(
              (bloc) => bloc.tabState == TabState.educationalVideos))
            Expanded(
              child: GridView.builder(
                shrinkWrap: true,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 28),
                physics: const BouncingScrollPhysics(),
                itemCount: 30,
                itemBuilder: (context, index) =>
                    const EducationalVideoCategoryCard(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 16,
                  mainAxisExtent: 104,
                  mainAxisSpacing: 28,
                ),
              ),
            )
          else
            Expanded(
              child: ListView.separated(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                itemCount: 10,
                separatorBuilder: (_, __) => const SizedBox(
                  height: 16,
                ),
                itemBuilder: (context, index) => PackageCard(
                  package: Provider.of<CategoriesBloc>(context, listen: false)
                      .packages
                      .first,
                  width: double.infinity,
                ),
              ),
            )
        ],
      );
}
