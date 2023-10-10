import 'package:ateba_app/core/components/shimmer_components.dart';
import 'package:ateba_app/modules/home/bloc/home_bloc.dart';
import 'package:ateba_app/modules/home/data/models/course.dart';
import 'package:ateba_app/modules/home/ui/widgets/banner_slider_widget.dart';
import 'package:ateba_app/modules/home/ui/widgets/course_card.dart';
import 'package:ateba_app/modules/home/ui/widgets/latest_tutorials_widget.dart';
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
                'ateba_courses'.tr(),
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            if (!context.select<HomeBloc, bool>((bloc) => bloc.coursesLoading))
              SizedBox(
                height: 180,
                width: double.infinity,
                child: Selector<HomeBloc, List<Course>>(
                  selector: (context, bloc) => bloc.courses,
                  builder: (context, courses, child) => ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    scrollDirection: Axis.horizontal,
                    itemCount: courses.length,
                    shrinkWrap: true,
                    separatorBuilder: (_, __) => const SizedBox(
                      width: 12,
                    ),
                    itemBuilder: (context, index) => CourseCard(
                      course: courses[index],
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
                  itemBuilder: (context, index) => const CourseShimmerCard(),
                ),
              ),
            const LatestTutorialsWidget(),
            if (context
                .select<HomeBloc, bool>((bloc) => bloc.middleBannerLoading))
              const ShimmerContainer(
                radius: 0,
                height: 160,
                width: double.infinity,
              )
            else
              CachedNetworkImage(
                width: double.infinity,
                imageUrl: context.select<HomeBloc, String>(
                    (bloc) => bloc.middleBanners?.image_url ?? ''),
                fit: BoxFit.cover,
              ),
          ],
        ),
      );
}
