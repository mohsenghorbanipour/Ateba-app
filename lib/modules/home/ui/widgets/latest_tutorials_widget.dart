import 'package:ateba_app/core/theme/style/color_palatte.dart';
import 'package:ateba_app/modules/home/bloc/home_bloc.dart';
import 'package:ateba_app/modules/home/data/models/course.dart';
import 'package:ateba_app/modules/home/data/models/tutorial.dart';
import 'package:ateba_app/modules/home/ui/widgets/tutorial_card.dart';
import 'package:ateba_app/modules/home/ui/widgets/latest_toturial_shimmer_card.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LatestTutorialsWidget extends StatelessWidget {
  const LatestTutorialsWidget({super.key});

  @override
  Widget build(BuildContext context) => Container(
        width: double.infinity,
        height: 221,
        margin: const EdgeInsets.only(top: 24),
        padding: const EdgeInsets.only(top: 8, bottom: 24),
        color: ColorPalette.of(context).midGrey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 16, bottom: 12),
              child: Text(
                'latest_tutorials'.tr(),
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            if (context.select<HomeBloc, bool>((bloc) => bloc.toturialsLoading))
              Expanded(
                child: ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  separatorBuilder: (_, __) => const SizedBox(
                    width: 12,
                  ),
                  itemBuilder: (context, index) =>
                      const LatestTutorialShimmerCard(),
                ),
              )
            else
              Expanded(
                child: Selector<HomeBloc, List<Tutorial>>(
                  selector: (context, bloc) => bloc.tutorials,
                  builder: (context, tutorials, child) => ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    scrollDirection: Axis.horizontal,
                    itemCount: tutorials.length,
                    separatorBuilder: (_, __) => const SizedBox(
                      width: 12,
                    ),
                    itemBuilder: (context, index) => TutorialCard(
                      tutorial: tutorials[index],
                    ),
                  ),
                ),
              ),
          ],
        ),
      );
}
