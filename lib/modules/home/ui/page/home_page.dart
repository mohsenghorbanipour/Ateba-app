import 'package:ateba_app/core/components/shimmer_components.dart';
import 'package:ateba_app/core/router/routes.dart';
import 'package:ateba_app/core/theme/style/color_palatte.dart';
import 'package:ateba_app/modules/categories/bloc/categories_bloc.dart';
import 'package:ateba_app/modules/categories/data/models/category.dart';
import 'package:ateba_app/modules/home/bloc/home_bloc.dart';
import 'package:ateba_app/modules/home/data/models/course.dart';
import 'package:ateba_app/modules/home/data/models/package.dart';
import 'package:ateba_app/modules/home/ui/widgets/banner_slider_widget.dart';
import 'package:ateba_app/modules/home/ui/widgets/course_card.dart';
import 'package:ateba_app/modules/home/ui/widgets/latest_tutorials_widget.dart';
import 'package:ateba_app/modules/home/ui/widgets/course_shimmer_card.dart';
import 'package:ateba_app/modules/home/ui/widgets/package_card.dart';
import 'package:ateba_app/modules/home/ui/widgets/package_shimmer_card.dart';
import 'package:ateba_app/modules/home/ui/widgets/view_more_widget.dart';
import 'package:ateba_app/modules/main/bloc/main_page_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:super_tooltip/super_tooltip.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final _tooltipController = SuperTooltipController();

  @override
  Widget build(BuildContext context) => RefreshIndicator(
        color: ColorPalette.of(context).primary,
        onRefresh: () async {
          await Provider.of<HomeBloc>(context, listen: false).loadData();
        },
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverList(
              delegate: SliverChildListDelegate([
                const BannerSliderWidget(),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 24, right: 16, bottom: 12),
                  child: Text(
                    'ateba_courses'.tr(),
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                if (!context
                    .select<HomeBloc, bool>((bloc) => bloc.coursesLoading))
                  SizedBox(
                    height: 190,
                    width: double.infinity,
                    child: Selector<HomeBloc, List<Course>>(
                      selector: (context, bloc) => bloc.courses,
                      builder: (context, courses, child) => ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        scrollDirection: Axis.horizontal,
                        itemCount: courses.length + 1,
                        shrinkWrap: true,
                        separatorBuilder: (_, __) => const SizedBox(
                          width: 12,
                        ),
                        itemBuilder: (context, index) => index == courses.length
                            ? ViewMoreWidget(
                                title: 'all_courses'.tr(),
                                onTap: () {
                                  MainPageBloc().changePage(2);
                                  Provider.of<CategoriesBloc>(context,
                                          listen: false)
                                      .tabState = TabState.clinicalPackages;
                                  Provider.of<CategoriesBloc>(context,
                                              listen: false)
                                          .categoriesDataType =
                                      CategoriesDataType.medicalCourses;
                                  Provider.of<CategoriesBloc>(context,
                                          listen: false)
                                      .loadCategoryData();
                                },
                              )
                            : CourseCard(
                                course: courses[index],
                              ),
                      ),
                    ),
                  )
                else
                  SizedBox(
                    height: 190,
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
                      itemBuilder: (context, index) =>
                          const CourseShimmerCard(),
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
                  InkWell(
                    onTap: () {
                      switch (Provider.of<HomeBloc>(context, listen: false)
                              .middleBanners
                              ?.type ??
                          '') {
                        case 'Tutorial':
                          context.goNamed(
                            Routes.tutorialDetails,
                            pathParameters: {
                              'slug':
                                  Provider.of<HomeBloc>(context, listen: false)
                                          .middleBanners
                                          ?.slug ??
                                      '',
                            },
                          );
                        case 'Course':
                          context.goNamed(
                            Routes.courseDetails,
                            pathParameters: {
                              'slug':
                                  Provider.of<HomeBloc>(context, listen: false)
                                          .middleBanners
                                          ?.slug ??
                                      '',
                            },
                          );
                        case 'Package':
                          context.goNamed(
                            Routes.packageDetails,
                            pathParameters: {
                              'slug':
                                  Provider.of<HomeBloc>(context, listen: false)
                                          .middleBanners
                                          ?.slug ??
                                      '',
                            },
                          );
                        case 'Category':
                          context.goNamed(
                            Routes.categoryDetials,
                            pathParameters: {
                              'slug':
                                  Provider.of<HomeBloc>(context, listen: false)
                                          .middleBanners
                                          ?.slug ??
                                      '',
                            },
                            extra: Category(),
                          );
                      }
                    },
                    child: CachedNetworkImage(
                      width: double.infinity,
                      imageUrl: context.select<HomeBloc, String>(
                          (bloc) => bloc.middleBanners?.image_url ?? ''),
                      fit: BoxFit.cover,
                      placeholder: (_, __) => const ShimmerContainer(
                        radius: 0,
                        height: 160,
                        width: double.infinity,
                      ),
                    ),
                  ),
                Padding(
                  padding:
                      const EdgeInsets.only(right: 16, top: 28, bottom: 16),
                  child: Row(
                    children: [
                      Text(
                        'training_packages'.tr(),
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      InkWell(
                        onTap: () {
                          _tooltipController.showTooltip();
                        },
                        child: SuperTooltip(
                          controller: _tooltipController,
                          hasShadow: true,
                          shadowBlurRadius: 10,
                          shadowSpreadRadius: 10,
                          shadowColor:
                              ColorPalette.of(context).black.withOpacity(0.05),
                          barrierColor: Colors.transparent,
                          borderWidth: 0.5,
                          arrowLength: 10,
                          borderColor: ColorPalette.of(context).border,
                          content: Text(
                            'packages_tooltip'.tr(),
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                          elevation: 1,
                          child: const Icon(
                            Icons.info_outline_rounded,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                if (!context
                    .select<HomeBloc, bool>((bloc) => bloc.packagesLoading))
                  Selector<HomeBloc, List<Package>>(
                    selector: (context, bloc) => bloc.packages,
                    builder: (context, packages, child) => SizedBox(
                      height: 228,
                      width: double.infinity,
                      child: ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        itemCount: packages.length + 1,
                        scrollDirection: Axis.horizontal,
                        separatorBuilder: (_, __) => const SizedBox(
                          width: 12,
                        ),
                        shrinkWrap: true,
                        itemBuilder: (_, index) => index == packages.length
                            ? ViewMoreWidget(
                                title: 'all_packages'.tr(),
                                onTap: () {
                                  MainPageBloc().changePage(2);
                                  Provider.of<CategoriesBloc>(context,
                                          listen: false)
                                      .tabState = TabState.clinicalPackages;
                                  Provider.of<CategoriesBloc>(context,
                                              listen: false)
                                          .categoriesDataType =
                                      CategoriesDataType.educationalPackages;
                                  Provider.of<CategoriesBloc>(context,
                                          listen: false)
                                      .loadCategoryData();
                                },
                              )
                            : PackageCard(
                                package: packages[index],
                              ),
                      ),
                    ),
                  )
                else
                  SizedBox(
                    height: 228,
                    width: double.infinity,
                    child: ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: 5,
                      scrollDirection: Axis.horizontal,
                      separatorBuilder: (_, __) => const SizedBox(
                        width: 12,
                      ),
                      shrinkWrap: true,
                      itemBuilder: (_, __) => const PackageShimmerCard(),
                    ),
                  ),
                const SizedBox(
                  height: 24,
                )
              ]),
            )
          ],
        ),
      );
}
