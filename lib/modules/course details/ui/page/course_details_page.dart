import 'package:ateba_app/core/base/enums/tab_state.dart';
import 'package:ateba_app/core/components/button_component.dart';
import 'package:ateba_app/core/resources/assets/assets.dart';
import 'package:ateba_app/core/router/routes.dart';
import 'package:ateba_app/core/theme/style/color_palatte.dart';
import 'package:ateba_app/core/utils/color_helper.dart';
import 'package:ateba_app/core/utils/text_input_formatters.dart';
import 'package:ateba_app/modules/auth/bloc/auth_bloc.dart';
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
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:ateba_app/core/utils/price_ext.dart';

class CourseDetailsPage extends StatelessWidget {
  const CourseDetailsPage({
    required this.slug,
    super.key,
  });

  final String slug;

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => CourseDetailsBloc(slug),
        builder: (context, child) => GestureDetector(
          onTap: () {
            Provider.of<CourseDetailsBloc>(context, listen: false).showOptions =
                false;
            Provider.of<CourseDetailsBloc>(context, listen: false)
                .selectedComment = null;
            Provider.of<CourseDetailsBloc>(context, listen: false)
                .selectedCommentIndex = null;
          },
          child: Scaffold(
            appBar: context
                    .select<CourseDetailsBloc, bool>((bloc) => bloc.showOptions)
                ? AppBar(
                    backgroundColor:
                        ColorPalette.of(context).scaffoldBackground,
                    surfaceTintColor:
                        ColorPalette.of(context).scaffoldBackground,
                    automaticallyImplyLeading: false,
                    elevation: 1,
                    shadowColor: ColorPalette.of(context).shadow,
                    leading: IconButton(
                      onPressed: () {
                        Provider.of<CourseDetailsBloc>(context, listen: false)
                            .showOptions = false;
                        Provider.of<CourseDetailsBloc>(context, listen: false)
                            .selectedComment = null;
                        Provider.of<CourseDetailsBloc>(context, listen: false)
                            .selectedCommentIndex = null;
                      },
                      icon: const Icon(
                        CupertinoIcons.clear_thick,
                      ),
                    ),
                    actions: [
                      IconButton(
                        onPressed: () {
                          Provider.of<CourseDetailsBloc>(context, listen: false)
                              .deleteComment();
                        },
                        icon: const Icon(
                          CupertinoIcons.delete_simple,
                        ),
                      )
                    ],
                  )
                : null,
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
                          (bloc) =>
                              bloc.courseDetails?.cover_color ?? '#ffffff',
                        )),
                        surfaceTintColor: ColorHelper.getColorFromHexCode(
                            context.select<CourseDetailsBloc, String>(
                          (bloc) =>
                              bloc.courseDetails?.cover_color ?? '#ffffff',
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
                              top: AppBar().preferredSize.height - 40,
                              bottom: 16,
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 16),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                          padding:
                                              const EdgeInsets.only(top: 8),
                                          child: Text(
                                            context.select<CourseDetailsBloc,
                                                String>(
                                              (bloc) =>
                                                  bloc.courseDetails?.title ??
                                                  '',
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
                            height: 40,
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
                                          bloc.tabState ==
                                          TabState.descriptions),
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
                                (bloc) =>
                                    bloc.tabState == TabState.descriptions))
                              const DescriptionWidget()
                            else if (context.select<CourseDetailsBloc, bool>(
                                (bloc) => bloc.tabState == TabState.teachers))
                              const TeachersWidget()
                            else
                              CommentsWidget(
                                slug: slug,
                              )
                          ],
                        ),
                      )
                    ],
                  ),
                if (context.select<CourseDetailsBloc, bool>(
                    (bloc) => !(bloc.courseDetails?.has_bought ?? false)))
                  Positioned(
                    left: 16,
                    right: 16,
                    bottom: 16,
                    child: Container(
                      height: 48,
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                          color: ColorPalette.of(context).lightSilver,
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(
                            width: 1,
                            color: ColorPalette.of(context).border,
                          )),
                      child: Row(
                        children: [
                          if (context.select<AuthBloc, bool>(
                              (bloc) => bloc.subscriptionExpireDate == null))
                            Expanded(
                              flex: 4,
                              child: ButtonComponent(
                                onPressed: () {},
                                margin: const EdgeInsets.only(left: 12),
                                height: 32,
                                loading:
                                    context.select<CourseDetailsBloc, bool>(
                                        (bloc) => bloc.loading),
                                color: Colors.transparent,
                                borderSide: BorderSide(
                                  width: 1,
                                  color: ColorPalette.of(context).textPrimary,
                                ),
                                child: Text(
                                  'access_by_subscription'.tr(),
                                  style:
                                      Theme.of(context).textTheme.labelMedium,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          Expanded(
                            flex: 5,
                            child: ButtonComponent(
                              onPressed: () {
                                if (Provider.of<CartBloc>(context,
                                        listen: false)
                                    .checkExistOrderInCart('course', slug)) {
                                  context.goNamed(
                                    Routes.cart,
                                  );
                                } else {
                                  Provider.of<CourseDetailsBloc>(context,
                                          listen: false)
                                      .orderCourse(slug);
                                }
                              },
                              loading: context.select<CourseDetailsBloc, bool>(
                                  (bloc) => bloc.loading || bloc.orderLoading),
                              height: 32,
                              child: context.select<CartBloc, bool>((bloc) =>
                                      bloc.checkExistOrderInCart(
                                          'course', slug))
                                  ? Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'complete_buying'.tr(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelMedium
                                              ?.copyWith(
                                                color: ColorPalette.of(context)
                                                    .white,
                                              ),
                                        ),
                                        const Padding(
                                          padding: EdgeInsets.only(right: 4),
                                          child: Icon(
                                            Icons.arrow_back_ios_new_rounded,
                                            size: 12,
                                          ),
                                        )
                                      ],
                                    )
                                  : Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        if (context.select<AuthBloc, bool>(
                                            (bloc) =>
                                                bloc.subscriptionExpireDate ==
                                                null))
                                          Expanded(
                                            child: RichText(
                                              overflow: TextOverflow.ellipsis,
                                              text: TextSpan(
                                                text: TextInputFormatters
                                                    .toPersianNumber(
                                                  '${context.select<CourseDetailsBloc, String>((bloc) => bloc.courseDetails?.price?.withPriceLable ?? '')}${'toman'.tr()}',
                                                ),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .labelSmall
                                                    ?.copyWith(
                                                      color: ColorPalette.of(
                                                              context)
                                                          .white,
                                                    ),
                                                children: [
                                                  TextSpan(
                                                    text:
                                                        ' ${'add_to_basket'.tr()}',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .labelMedium
                                                        ?.copyWith(
                                                          color:
                                                              ColorPalette.of(
                                                                      context)
                                                                  .white,
                                                        ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          )
                                        else
                                          RichText(
                                            overflow: TextOverflow.ellipsis,
                                            text: TextSpan(
                                              text: TextInputFormatters
                                                  .toPersianNumber(
                                                '${context.select<CourseDetailsBloc, String>((bloc) => bloc.courseDetails?.price?.withPriceLable ?? '')}${'toman'.tr()}',
                                              ),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelSmall
                                                  ?.copyWith(
                                                    color:
                                                        ColorPalette.of(context)
                                                            .white,
                                                  ),
                                              children: [
                                                TextSpan(
                                                  text:
                                                      ' ${'add_to_basket'.tr()}',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .labelMedium
                                                      ?.copyWith(
                                                        color: ColorPalette.of(
                                                                context)
                                                            .white,
                                                      ),
                                                )
                                              ],
                                            ),
                                          ),
                                      ],
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
        ),
      );
}
