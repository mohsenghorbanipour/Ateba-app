import 'package:ateba_app/modules/search/ui/widgets/search_result_widget.dart';
import 'package:ateba_app/modules/search/ui/widgets/search_widget.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) => const Column(
        children: [
          SearchWidget(),
          Expanded(
            child: SearchResultWidget(),
          ),
        ],
      );
}
