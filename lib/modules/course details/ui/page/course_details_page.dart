import 'package:ateba_app/core/base/enums/tab_state.dart';
import 'package:ateba_app/core/components/button_component.dart';
import 'package:ateba_app/core/resources/assets/assets.dart';
import 'package:ateba_app/core/theme/style/color_palatte.dart';
import 'package:ateba_app/core/utils/color_helper.dart';
import 'package:ateba_app/core/utils/text_input_formatters.dart';
import 'package:ateba_app/modules/cart/bloc/cart_bloc.dart';
import 'package:ateba_app/modules/course%20details/bloc/course_details_bloc.dart';
import 'package:ateba_app/modules/course%20details/ui/widgets/comments_widget.dart';
import 'package:ateba_app/modules/course%20details/ui/widgets/course_details_shimmer.dart';
import 'package:ateba_app/modules/course%20details/ui/widgets/description_widget.dart';
import 'package:ateba_app/modules/course%20details/ui/widgets/lessons_widget.dart';
import 'package:ateba_app/modules/course%20details/ui/widgets/tab_item_widget.dart';
import 'package:ateba_app/modules/course%20details/ui/widgets/teachers_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class CourseDetailsPage extends StatelessWidget {
  const CourseDetailsPage({
    required this.slug,
    super.key,
  });

  final String slug;

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => CourseDetailsBloc(slug),
        builder: (context, child) => Scaffold(
          backgroundColor: ColorPalette.of(context).scaffoldBackground,
          body: Stack(
            children: [
              if (context
                  .select<CourseDetailsBloc, bool>((bloc) => bloc.loading))
                const CourseDetailsShimmer()
              else
                CustomScrollView(
                  physics: const BouncingScrollPhysics(),
                  slivers: [
                    SliverAppBar(
                      backgroundColor: ColorHelper.getColorFromHexCode(
                          context.select<CourseDetailsBloc, String>(
                        (bloc) => bloc.courseDetails?.cover_color ?? '#ffffff',
                      )),
                      surfaceTintColor: ColorHelper.getColorFromHexCode(
                          context.select<CourseDetailsBloc, String>(
                        (bloc) => bloc.courseDetails?.cover_color ?? '#ffffff',
                      )),
                      leading: Row(
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: Container(
                              width: 32,
                              height: 32,
                              margin: const EdgeInsets.only(right: 16),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  width: 1,
                                  color: ColorPalette.of(context).textPrimary,
                                ),
                              ),
                              child: const Icon(
                                Icons.arrow_back_ios_rounded,
                                size: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                      actions: [
                        Container(
                          width: 32,
                          height: 32,
                          margin: const EdgeInsets.only(left: 12),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              width: 1,
                              color: ColorPalette.of(context).textPrimary,
                            ),
                          ),
                          child: Center(
                            child: SvgPicture.asset(
                              Assets.shareIc,
                              width: 16,
                            ),
                          ),
                        ),
                      ],
                      expandedHeight: 240,
                      floating: false,
                      pinned: true,
                      snap: false,
                      flexibleSpace: FlexibleSpaceBar(
                        background: Padding(
                          padding: EdgeInsets.only(
                              top: AppBar().preferredSize.height, bottom: 16),
                          child: Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 16),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'professional_course'.tr(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineMedium
                                            ?.copyWith(
                                              fontSize: 18,
                                            ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 8),
                                        child: Text(
                                          context.select<CourseDetailsBloc,
                                              String>(
                                            (bloc) =>
                                                bloc.courseDetails?.title ?? '',
                                          ),
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleLarge,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: CachedNetworkImage(
                                    imageUrl: context
                                        .select<CourseDetailsBloc, String>(
                                      (bloc) =>
                                          bloc.courseDetails?.cover_url ?? '',
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      bottom: PreferredSize(
                        preferredSize: const Size(double.infinity, 38),
                        child: Container(
                          width: double.infinity,
                          height: 38,
                          color: ColorPalette.of(context).darkSilver,
                          child: Row(
                            children: [
                              TabItemWidget(
                                title: 'lessones'.tr(),
                                onTap: () {
                                  Provider.of<CourseDetailsBloc>(context,
                                          listen: false)
                                      .tabState = TabState.lessons;
                                },
                                selected: context
                                    .select<CourseDetailsBloc, bool>((bloc) =>
                                        bloc.tabState == TabState.lessons),
                              ),
                              TabItemWidget(
                                title: 'descriptions'.tr(),
                                onTap: () {
                                  Provider.of<CourseDetailsBloc>(context,
                                          listen: false)
                                      .tabState = TabState.descriptions;
                                },
                                selected: context
                                    .select<CourseDetailsBloc, bool>((bloc) =>
                                        bloc.tabState == TabState.descriptions),
                              ),
                              TabItemWidget(
                                title: 'teachers'.tr(),
                                onTap: () {
                                  Provider.of<CourseDetailsBloc>(context,
                                          listen: false)
                                      .tabState = TabState.teachers;
                                },
                                selected: context
                                    .select<CourseDetailsBloc, bool>((bloc) =>
                                        bloc.tabState == TabState.teachers),
                              ),
                              TabItemWidget(
                                title: 'user_comment'.tr(),
                                onTap: () {
                                  Provider.of<CourseDetailsBloc>(context,
                                          listen: false)
                                      .tabState = TabState.comments;
                                },
                                selected: context
                                    .select<CourseDetailsBloc, bool>((bloc) =>
                                        bloc.tabState == TabState.comments),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SliverList(
                      delegate: SliverChildListDelegate(
                        [
                          if (context.select<CourseDetailsBloc, bool>(
                              (bloc) => bloc.tabState == TabState.lessons))
                            LessonsWidget(
                              slug: slug,
                            )
                          else if (context.select<CourseDetailsBloc, bool>(
                              (bloc) => bloc.tabState == TabState.descriptions))
                            const DescriptionWidget()
                          else if (context.select<CourseDetailsBloc, bool>(
                              (bloc) => bloc.tabState == TabState.teachers))
                            const TeachersWidget()
                          else
                            const CommentsWidget()
                        ],
                      ),
                    )
                  ],
                ),
              Positioned(
                left: 16,
                right: 16,
                bottom: 16,
                child: Container(
                  height: 48,
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                      color: ColorPalette.of(context).lightSilver,
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(
                        width: 1,
                        color: ColorPalette.of(context).border,
                      )),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: ButtonComponent(
                          onPressed: () {},
                          height: 32,
                          loading: context.select<CourseDetailsBloc, bool>(
                              (bloc) => bloc.loading),
                          color: Colors.transparent,
                          borderSide: BorderSide(
                            width: 1,
                            color: ColorPalette.of(context).textPrimary,
                          ),
                          child: Text(
                            'access_by_subscription'.tr(),
                            style: Theme.of(context).textTheme.labelMedium,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Expanded(
                        flex: 3,
                        child: ButtonComponent(
                          onPressed: () {
                            if (Provider.of<CartBloc>(context, listen: false)
                                .checkExistOrderInCart('course', slug)) {
                            } else {
                              Provider.of<CourseDetailsBloc>(context,
                                      listen: false)
                                  .orderCourse(slug);
                            }
                          },
                          loading: context.select<CourseDetailsBloc, bool>(
                              (bloc) => bloc.loading || bloc.orderLoading),
                          height: 32,
                          child: Text(
                            '${TextInputFormatters.toPersianNumber(context.select<CourseDetailsBloc, String>((bloc) => bloc.courseDetails?.price.toString() ?? '0'))}${'toman'.tr()} ${'add_to_basket'.tr()}',
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium
                                ?.copyWith(
                                  color: ColorPalette.of(context).white,
                                ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      );
}
