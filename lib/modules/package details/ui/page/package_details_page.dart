import 'package:ateba_app/core/base/enums/tab_state.dart';
import 'package:ateba_app/core/components/button_component.dart';
import 'package:ateba_app/core/components/shimmer_components.dart';
import 'package:ateba_app/core/components/toast_component.dart';
import 'package:ateba_app/core/resources/assets/assets.dart';
import 'package:ateba_app/core/theme/style/color_palatte.dart';
import 'package:ateba_app/core/utils/date_helper.dart';
import 'package:ateba_app/core/utils/text_input_formatters.dart';
import 'package:ateba_app/modules/cart/bloc/cart_bloc.dart';
import 'package:ateba_app/modules/course%20details/ui/widgets/tab_item_widget.dart';
import 'package:ateba_app/modules/package%20details/bloc/package_details_bloc.dart';
import 'package:ateba_app/modules/package%20details/ui/widgets/comments_widget.dart';
import 'package:ateba_app/modules/package%20details/ui/widgets/description_widget.dart';
import 'package:ateba_app/modules/package%20details/ui/widgets/lesson_widget.dart';
import 'package:ateba_app/modules/package%20details/ui/widgets/package_details_shimmer.dart';
import 'package:ateba_app/modules/package%20details/ui/widgets/teachers_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class PackageDetailsPage extends StatelessWidget {
  const PackageDetailsPage({
    required this.slug,
    super.key,
  });

  final String slug;

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => PackageDetailsBloc(slug),
        lazy: false,
        builder: (context, child) => GestureDetector(
          onTap: () {
            Provider.of<PackageDetailsBloc>(context, listen: false)
                .showOptions = false;
            Provider.of<PackageDetailsBloc>(context, listen: false)
                .selectedComment = null;
            Provider.of<PackageDetailsBloc>(context, listen: false)
                .selectedCommentIndex = null;
          },
          child: Scaffold(
            appBar: context
                    .select<PackageDetailsBloc, bool>((bloc) => bloc.showOptions)
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
                        Provider.of<PackageDetailsBloc>(context, listen: false)
                            .showOptions = false;
                        Provider.of<PackageDetailsBloc>(context, listen: false)
                            .selectedComment = null;
                        Provider.of<PackageDetailsBloc>(context, listen: false)
                            .selectedCommentIndex = null;
                      },
                      icon: const Icon(
                        CupertinoIcons.clear_thick,
                      ),
                    ),
                    actions: [
                      IconButton(
                        onPressed: () {
                          Provider.of<PackageDetailsBloc>(context, listen: false)
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
                    .select<PackageDetailsBloc, bool>((bloc) => bloc.loading))
                  const PackageDetailsShimmer()
                else
                  CustomScrollView(
                    physics: const BouncingScrollPhysics(),
                    slivers: [
                      SliverAppBar(
                        backgroundColor:
                            ColorPalette.of(context).scaffoldBackground,
                        surfaceTintColor:
                            ColorPalette.of(context).scaffoldBackground,
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
                                  color: ColorPalette.of(context).background,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    width: 1,
                                    color: ColorPalette.of(context).border,
                                  ),
                                ),
                                child: Icon(
                                  Icons.arrow_back_ios_rounded,
                                  size: 16,
                                  color: ColorPalette.of(context).primary,
                                ),
                              ),
                            ),
                          ],
                        ),
                        expandedHeight: 200,
                        floating: false,
                        pinned: true,
                        snap: false,
                        flexibleSpace: FlexibleSpaceBar(
                          background: Container(
                            color: ColorPalette.of(context).scaffoldBackground,
                            padding: const EdgeInsets.symmetric(
                                vertical: 24, horizontal: 18),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(6),
                                  child: CachedNetworkImage(
                                    width: 80,
                                    height: 80,
                                    imageUrl: context
                                        .select<PackageDetailsBloc, String>(
                                      (bloc) =>
                                          bloc.packageDetails?.thumbnail_url ??
                                          '',
                                    ),
                                    placeholder: (_, __) =>
                                        const ShimmerContainer(
                                      width: 80,
                                      height: 80,
                                      radius: 6,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 12,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      context
                                          .select<PackageDetailsBloc, String>(
                                        (bloc) =>
                                            bloc.packageDetails?.title ?? '',
                                      ),
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium,
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Row(
                                      children: [
                                        SvgPicture.asset(
                                          Assets.videoIc,
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 6),
                                          child: Text(
                                            TextInputFormatters.toPersianNumber(
                                                context
                                                    .select<PackageDetailsBloc,
                                                            int>(
                                                        (bloc) =>
                                                            bloc.packageDetails
                                                                ?.tutorials_count ??
                                                            0)
                                                    .toString()),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 16),
                                          child: Text(
                                            DateHelper.getDistanceWithToday(
                                              context.select<PackageDetailsBloc,
                                                  String>(
                                                (bloc) =>
                                                    bloc.packageDetails
                                                        ?.updated_at ??
                                                    '',
                                              ),
                                            ),
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelMedium
                                                ?.copyWith(
                                                  color:
                                                      ColorPalette.of(context)
                                                          .textPrimary
                                                          .withOpacity(0.8),
                                                ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                )
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
                                    Provider.of<PackageDetailsBloc>(context,
                                            listen: false)
                                        .tabState = TabState.lessons;
                                  },
                                  selected: context.select<PackageDetailsBloc,
                                          bool>(
                                      (bloc) =>
                                          bloc.tabState == TabState.lessons),
                                ),
                                TabItemWidget(
                                  title: 'descriptions'.tr(),
                                  onTap: () {
                                    Provider.of<PackageDetailsBloc>(context,
                                            listen: false)
                                        .tabState = TabState.descriptions;
                                  },
                                  selected:
                                      context.select<PackageDetailsBloc, bool>(
                                          (bloc) =>
                                              bloc.tabState ==
                                              TabState.descriptions),
                                ),
                                TabItemWidget(
                                  title: 'teachers'.tr(),
                                  onTap: () {
                                    Provider.of<PackageDetailsBloc>(context,
                                            listen: false)
                                        .tabState = TabState.teachers;
                                  },
                                  selected:
                                      context.select<PackageDetailsBloc, bool>(
                                          (bloc) =>
                                              bloc.tabState ==
                                              TabState.teachers),
                                ),
                                TabItemWidget(
                                  title: 'user_comment'.tr(),
                                  onTap: () {
                                    Provider.of<PackageDetailsBloc>(context,
                                            listen: false)
                                        .tabState = TabState.comments;
                                  },
                                  selected:
                                      context.select<PackageDetailsBloc, bool>(
                                          (bloc) =>
                                              bloc.tabState ==
                                              TabState.comments),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SliverList(
                        delegate: SliverChildListDelegate(
                          [
                            if (context.select<PackageDetailsBloc, bool>(
                                (bloc) => bloc.tabState == TabState.lessons))
                              LessonsWidget(
                                slug: slug,
                              )
                            else if (context.select<PackageDetailsBloc, bool>(
                                (bloc) =>
                                    bloc.tabState == TabState.descriptions))
                              const DescriptionWidget()
                            else if (context.select<PackageDetailsBloc, bool>(
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
                            loading: context.select<PackageDetailsBloc, bool>(
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
                                  .checkExistOrderInCart('package', slug)) {
                                ToastComponent.show(
                                  'package_exist_in_cart'.tr(),
                                  type: ToastType.info,
                                );
                              } else {
                                Provider.of<PackageDetailsBloc>(context,
                                        listen: false)
                                    .orderPackage(slug);
                              }
                            },
                            loading: context.select<PackageDetailsBloc, bool>(
                                (bloc) => bloc.loading || bloc.orderLoading),
                            height: 32,
                            child: Text(
                              '${TextInputFormatters.toPersianNumber(context.select<PackageDetailsBloc, String>((bloc) => bloc.packageDetails?.price.toString() ?? '0'))}${'toman'.tr()} ${'add_to_basket'.tr()}',
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
        ),
      );
}
