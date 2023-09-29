import 'package:ateba_app/core/resources/assets/assets.dart';
import 'package:ateba_app/core/theme/style/color_palatte.dart';
import 'package:ateba_app/modules/tutorial%20details/bloc/tutorial_details_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class TutorialDetailsPage extends StatelessWidget {
  const TutorialDetailsPage({
    required this.slug,
    super.key,
  });

  final String slug;

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => TutorialDetaialsBloc()..loadToturialDetials(slug),
        lazy: false,
        builder: (context, child) => Scaffold(
          backgroundColor: ColorPalette.of(context).scaffoldBackground,
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        context.pop();
                      },
                      child: Container(
                        width: 32,
                        height: 32,
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
                    Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: ColorPalette.of(context).background,
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(
                          width: 1,
                          color: ColorPalette.of(context).border,
                        ),
                      ),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            Assets.bookmarkIc,
                            width: 16,
                            color: ColorPalette.of(context).primary,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 4),
                            child: Text(
                              'add_to_list'.tr(),
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      );
}
