import 'package:ateba_app/core/resources/assets/assets.dart';
import 'package:ateba_app/core/router/routes.dart';
import 'package:ateba_app/core/theme/style/color_palatte.dart';
import 'package:ateba_app/modules/fast%20search/data/models/fast_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class FastSearchResultWidget extends StatelessWidget {
  const FastSearchResultWidget({
    required this.results,
    super.key,
  });

  final List<FastSearch> results;
  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        child: Container(
          width: double.infinity,
          margin: const EdgeInsets.fromLTRB(16, 24, 16, 16),
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: ColorPalette.of(context).border,
            ),
            borderRadius: BorderRadius.circular(6),
            color: ColorPalette.of(context).background,
          ),
          child: ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: results.length,
            shrinkWrap: true,
            separatorBuilder: (_, __) => Divider(
              height: 0.5,
              indent: 16,
              endIndent: 16,
              color: ColorPalette.of(context).textPrimary.withOpacity(0.2),
            ),
            itemBuilder: (_, index) => InkWell(
              onTap: () {
                context.goNamed(
                  Routes.tutorialDetails,
                  pathParameters: {
                    'slug': results[index].link_to?.slug ?? '',
                  },
                );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                width: double.infinity,
                height: 38,
                child: Row(
                  children: [
                    SvgPicture.asset(
                      Assets.videoIc,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 6),
                      child: Text(
                        results[index].title ?? '',
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
}
