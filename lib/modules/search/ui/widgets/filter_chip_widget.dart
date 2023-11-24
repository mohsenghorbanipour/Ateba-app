import 'package:ateba_app/core/theme/style/color_palatte.dart';
import 'package:ateba_app/core/utils/text_input_formatters.dart';
import 'package:ateba_app/modules/search/bloc/search_bloc.dart';
import 'package:ateba_app/modules/search/data/models/filter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FilterChipWidget extends StatelessWidget {
  const FilterChipWidget({
    required this.filter,
    this.selected = false,
    super.key,
  });

  final Filter filter;
  final bool selected;

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: () {
          Provider.of<SearchBloc>(context, listen: false).selectedFilter =
              filter;
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color: selected ? ColorPalette.of(context).primary : null,
            borderRadius: BorderRadius.circular(100),
            border: Border.all(
              width: 1,
              color: ColorPalette.of(context).primary,
            ),
          ),
          child: Text(
            (filter.label ?? '') +
                ((filter.results_count ?? 0) > 0
                    ? TextInputFormatters.toPersianNumber(
                        ' (${filter.results_count})')
                    : ''),
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: selected ? ColorPalette.of(context).background : null,
                ),
          ),
        ),
      );
}
