import 'package:ateba_app/core/components/shimmer_components.dart';
import 'package:ateba_app/modules/home/bloc/home_bloc.dart';
import 'package:ateba_app/modules/home/data/models/package.dart';
import 'package:ateba_app/modules/home/ui/widgets/banner_slider_widget.dart';
import 'package:ateba_app/modules/home/ui/widgets/latest_tutorials_widget.dart';
import 'package:ateba_app/modules/home/ui/widgets/package_card.dart';
import 'package:ateba_app/modules/home/ui/widgets/package_shimmer_card.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const BannerSliderWidget(),
            Padding(
              padding: const EdgeInsets.only(top: 24, right: 16, bottom: 12),
              child: Text(
                'ateba_packages'.tr(),
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            if (!context.select<HomeBloc, bool>((bloc) => bloc.packagesLoading))
              SizedBox(
                height: 180,
                width: double.infinity,
                child: Selector<HomeBloc, List<Package>>(
                  selector: (context, bloc) => bloc.packages,
                  builder: (context, packages, child) => ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    scrollDirection: Axis.horizontal,
                    itemCount: packages.length,
                    shrinkWrap: true,
                    separatorBuilder: (_, __) => const SizedBox(
                      width: 12,
                    ),
                    itemBuilder: (context, index) => PackageCard(
                      package: packages[index],
                    ),
                  ),
                ),
              )
            else
              SizedBox(
                height: 180,
                width: double.infinity,
                child: ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  shrinkWrap: true,
                  separatorBuilder: (_, __) => const SizedBox(
                    width: 12,
                  ),
                  itemBuilder: (context, index) => const PackageShimmerCard(),
                ),
              ),
            const LatestTutorialsWidget(),
            if (context
                .select<HomeBloc, bool>((bloc) => bloc.bottomBannerLoading))
              const ShimmerContainer(
                radius: 0,
                height: 160,
                width: double.infinity,
              )
            else
              CachedNetworkImage(
                width: double.infinity,
                imageUrl: context.select<HomeBloc, String>(
                    (bloc) => bloc.bottomBanner?.cover ?? ''),
                fit: BoxFit.cover,
              ),
          ],
        ),
      );
}
