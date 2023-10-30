import 'package:ateba_app/modules/categories/bloc/categories_bloc.dart';
import 'package:ateba_app/modules/categories/ui/widgets/categories_tab_widget.dart';
import 'package:ateba_app/modules/categories/ui/widgets/categories_widget.dart';
import 'package:ateba_app/modules/categories/ui/widgets/category_card.dart';
import 'package:ateba_app/modules/categories/ui/widgets/category_data_widget.dart';
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
            const CategoriesWidget()
          else 
            const CategoryDataWidget(),
        ],
      );
}
