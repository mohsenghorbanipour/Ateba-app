import 'package:ateba_app/core/components/button_component.dart';
import 'package:ateba_app/core/resources/assets/assets.dart';
import 'package:ateba_app/core/theme/style/color_palatte.dart';
import 'package:ateba_app/modules/package%20details/bloc/package_details_bloc.dart';
import 'package:ateba_app/modules/package%20details/ui/widgets/description_widget.dart';
import 'package:ateba_app/modules/package%20details/ui/widgets/package_lesson_card.dart';
import 'package:ateba_app/modules/package%20details/ui/widgets/lessons_widget.dart';
import 'package:ateba_app/modules/package%20details/ui/widgets/tab_item_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class PackageDetailsPage extends StatelessWidget {
  const PackageDetailsPage({super.key});

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => PackageDetailsBloc(),
        builder: (context, child) => Scaffold(
          backgroundColor: ColorPalette.of(context).scaffoldBackground,
          body: Stack(
            children: [
              CustomScrollView(
                slivers: [
                  SliverAppBar(
                    backgroundColor: ColorPalette.of(context).lightPrimary,
                    surfaceTintColor: ColorPalette.of(context).lightPrimary,
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
                      Container(
                        width: 32,
                        height: 32,
                        margin: const EdgeInsets.only(left: 16),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            width: 1,
                            color: ColorPalette.of(context).textPrimary,
                          ),
                        ),
                        child: Center(
                          child: SvgPicture.asset(
                            Assets.bookmarkIc,
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'پکیج تخصصی',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineMedium
                                          ?.copyWith(
                                            fontSize: 18,
                                          ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8),
                                      child: Text('اورولوژی، درمان',
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleLarge),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: SvgPicture.asset(
                                  Assets.test2Ic,
                                  // width: ,
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
                                Provider.of<PackageDetailsBloc>(context,
                                        listen: false)
                                    .tabState = TabState.lessons;
                              },
                              selected: context
                                  .select<PackageDetailsBloc, bool>((bloc) =>
                                      bloc.tabState == TabState.lessons),
                            ),
                            TabItemWidget(
                              title: 'descriptions'.tr(),
                              onTap: () {
                                Provider.of<PackageDetailsBloc>(context,
                                        listen: false)
                                    .tabState = TabState.descriptions;
                              },
                              selected: context
                                  .select<PackageDetailsBloc, bool>((bloc) =>
                                      bloc.tabState == TabState.descriptions),
                            ),
                            TabItemWidget(
                              title: 'teachers'.tr(),
                              onTap: () {
                                Provider.of<PackageDetailsBloc>(context,
                                        listen: false)
                                    .tabState = TabState.teachers;
                              },
                              selected: context
                                  .select<PackageDetailsBloc, bool>((bloc) =>
                                      bloc.tabState == TabState.teachers),
                            ),
                            TabItemWidget(
                              title: 'user_comment'.tr(),
                              onTap: () {
                                Provider.of<PackageDetailsBloc>(context,
                                        listen: false)
                                    .tabState = TabState.comments;
                              },
                              selected: context
                                  .select<PackageDetailsBloc, bool>((bloc) =>
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
                        if (context.select<PackageDetailsBloc, bool>(
                            (bloc) => bloc.tabState == TabState.lessons))
                          const LessonsWidget()
                        else if (context.select<PackageDetailsBloc, bool>(
                            (bloc) => bloc.tabState == TabState.descriptions))
                          const DescriptionWidget(),
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
                          color: Colors.transparent,
                          borderSide: BorderSide(
                            width: 1,
                            color: ColorPalette.of(context).textPrimary,
                          ),
                          child: Text(
                            'دسترسی با اشتراک',
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
                          onPressed: () {},
                          height: 32,
                          child: Text(
                            '79,500 تومان  افزودن به سبد',
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
