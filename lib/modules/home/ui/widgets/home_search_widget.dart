import 'package:ateba_app/core/components/textfiled_component.dart';
import 'package:ateba_app/core/router/routes.dart';
import 'package:ateba_app/core/theme/style/color_palatte.dart';
import 'package:ateba_app/modules/home/bloc/home_bloc.dart';
import 'package:ateba_app/modules/home/ui/widgets/suggestion_chip.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class HomeSearchWidget extends StatelessWidget {
  const HomeSearchWidget({super.key});

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.only(top: 24),
        color: ColorPalette.of(context).midGrey,
        child: Column(
          children: [
            InkWell(
              onTap: () {
                context.goNamed(
                  Routes.fastSearchPage,
                );
              },
              child: TextFieldComponent(
                name: 'query',
                showLabel: false,
                hintText: context.select<HomeBloc, String>(
                  (bloc) => bloc.suggestions?.search_placeholder ?? '',
                ),
                enabled: false,
                textAlign: TextAlign.right,
                borderColor: Colors.white,
                prefixIcon: Icon(
                  Icons.search,
                  size: 22,
                  color: ColorPalette.of(context).textPrimary.withOpacity(0.5),
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            SizedBox(
              height: 32,
              width: double.infinity,
              child: Selector<HomeBloc, List<String>>(
                selector: (context, bloc) =>
                    bloc.suggestions?.query_suggestions ?? [],
                builder: (context, suggestios, child) => ListView.separated(
                  itemCount: suggestios.length,
                  scrollDirection: Axis.horizontal,
                  separatorBuilder: (_, __) => const SizedBox(
                    width: 6,
                  ),
                  itemBuilder: (context, index) => SuggestionChip(
                    suggestion: suggestios[index],
                  ),
                ),
              ),
            )
          ],
        ),
      );
}
