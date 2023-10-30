import 'package:ateba_app/core/components/shimmer_components.dart';
import 'package:ateba_app/core/resources/assets/assets.dart';
import 'package:ateba_app/core/theme/style/color_palatte.dart';
import 'package:ateba_app/core/utils/text_input_formatters.dart';
import 'package:ateba_app/modules/categories/data/models/category.dart';
import 'package:ateba_app/modules/category%20details/bloc/category_details_bloc.dart';
import 'package:ateba_app/modules/category%20details/ui/widgets/category_tutorials_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class CategoryDetailsPage extends StatelessWidget {
  const CategoryDetailsPage({
    required this.slug,
    required this.category,
    super.key,
  });

  final String slug;
  final Category category;

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => CategoryDetailsBloc(slug),
        lazy: false,
        builder: (context, child) => Scaffold(
          backgroundColor: ColorPalette.of(context).scaffoldBackground,
          body: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 24),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
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
                          color: ColorPalette.of(context).background,
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
                    Padding(
                      padding: const EdgeInsets.only(right: 6),
                      child: Text(
                        '${'tutorials'.tr()} ${category.title ?? ''}',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 32),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: CachedNetworkImage(
                            imageUrl: category.thumbnail_url ?? '',
                            fit: BoxFit.cover,
                            width: 72,
                            height: 72,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          Assets.videoIc,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 4),
                          child: context.select<CategoryDetailsBloc, bool>(
                                  (bloc) => bloc.loading)
                              ? const ShimmerContainer(
                                  width: 18,
                                  height: 18,
                                )
                              : Text(
                                  TextInputFormatters.toPersianNumber(
                                    context
                                        .select<CategoryDetailsBloc, int>(
                                            (bloc) => bloc.withSubCategory
                                                ? bloc.categoryTutorials.length
                                                : bloc.tutorials.length)
                                        .toString(),
                                  ),
                                ),
                        )
                      ],
                    ),
                    // Consumer<CategoryDetailsBloc>(
                    //   builder: (context, bloc, child) => bloc.loading
                    //       ? ListView.separated(
                    //           padding: const EdgeInsets.only(
                    //               top: 35, left: 16, right: 16),
                    //           physics: const NeverScrollableScrollPhysics(),
                    //           separatorBuilder: (_, __) => const SizedBox(
                    //             height: 12,
                    //           ),
                    //           shrinkWrap: true,
                    //           itemCount: 10,
                    //           itemBuilder: (_, __) => const ShimmerContainer(
                    //             width: double.infinity,
                    //             height: 48,
                    //             radius: 6,
                    //           ),
                    //         )
                    //       : !bloc.withSubCategory
                    //           ? const CategoryTutorialsWidget()
                    //           : ListView.separated(
                    //               itemBuilder: itemBuilder,
                    //               separatorBuilder: separatorBuilder,
                    //               itemCount: itemCount,
                    //             ),
                    // )
                  ],
                ),
              ),
              // ListView.separated(
              //   itemBuilder: itemBuilder,
              //   separatorBuilder: separatorBuilder,
              //   itemCount: itemCount,
              // )
            ],
          ),
        ),
      );
}
