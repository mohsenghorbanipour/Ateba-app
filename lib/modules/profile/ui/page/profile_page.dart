import 'package:ateba_app/core/resources/assets/assets.dart';
import 'package:ateba_app/core/router/routes.dart';
import 'package:ateba_app/core/theme/style/color_palatte.dart';
import 'package:ateba_app/core/utils/logger_helper.dart';
import 'package:ateba_app/core/utils/text_input_formatters.dart';
import 'package:ateba_app/modules/auth/bloc/auth_bloc.dart';
import 'package:ateba_app/modules/profile/ui/widgets/profile_tile.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) => ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          Container(
            width: double.infinity,
            margin: const EdgeInsets.fromLTRB(16, 24, 16, 32),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: ColorPalette.of(context).background,
              border: Border.all(
                width: 1,
                color: ColorPalette.of(context).border,
              ),
            ),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(40),
                  child: CachedNetworkImage(
                    imageUrl:
                        'https://images.squarespace-cdn.com/content/v1/5a1c2452268b96d901cd3471/1546637246803-H5RMXRRU7TN92M7PJAE5/beautiful-boy1.jpg?format=2500w',
                    width: 40,
                    height: 40,
                    fit: BoxFit.cover,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          context.select<AuthBloc, String>(
                              (bloc) => bloc.userProfile?.name ?? ''),
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        const SizedBox(
                          height: 2,
                        ),
                        Text(
                          TextInputFormatters.toPersianNumber(
                            context.select<AuthBloc, String>(
                              (bloc) =>
                                  bloc.userProfile?.phone?.startsWith('0098') ??
                                          false
                                      ? bloc.userProfile?.phone
                                              ?.replaceFirst('0098', '0') ??
                                          ''
                                      : bloc.userProfile?.phone ?? '',
                            ),
                          ),
                          style: Theme.of(context).textTheme.labelMedium,
                        )
                      ],
                    ),
                  ),
                ),
                SvgPicture.asset(
                  Assets.editWriteIc,
                )
              ],
            ),
          ),
          InkWell(
            onTap: () {
              if (Provider.of<AuthBloc>(context, listen: false)
                      .subscriptionExpireDate ==
                  null) {
                context.goNamed(
                  Routes.subscription,
                );
              }
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: ColorPalette.of(context).background,
                border: Border.all(
                  width: 1,
                  color: ColorPalette.of(context).border,
                ),
              ),
              child: context.select<AuthBloc, bool>(
                      (bloc) => bloc.subscriptionExpireDate != null)
                  ? Text(
                      '${'subscription_expire_date'.tr()} : ${context.select<AuthBloc, String>((bloc) => '${bloc.subscriptionExpireDate!.formatter.dd} ${bloc.subscriptionExpireDate!.formatter.mN} ${bloc.subscriptionExpireDate!.formatter.yyyy}')}',
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset(
                              Assets.starIc,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 4),
                              child: Text(
                                'buy_a_subscription'.tr(),
                              ),
                            )
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: ColorPalette.of(context).lightGrey,
                          ),
                          child: Text(
                            'اشتراک فعلی وجود ندارد',
                            style: Theme.of(context).textTheme.labelSmall,
                          ),
                        )
                      ],
                    ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            margin: const EdgeInsets.fromLTRB(16, 16, 16, 48),
            decoration: BoxDecoration(
              color: ColorPalette.of(context).background,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(
                width: 1,
                color: ColorPalette.of(context).border,
              ),
            ),
            child: Column(
              children: [
                ProfileTile(
                  title: 'notifications',
                  onTap: () {},
                  icon: Assets.notificationIc,
                ),
                Divider(
                  height: 0.5,
                  color: ColorPalette.of(context).textPrimary.withOpacity(0.2),
                  indent: 4,
                  endIndent: 4,
                ),
                ProfileTile(
                  title: 'purchase_history',
                  onTap: () {
                    context.goNamed(
                      Routes.transactions,
                    );
                  },
                  icon: Assets.historyIc,
                ),
                Divider(
                  height: 0.5,
                  color: ColorPalette.of(context).textPrimary.withOpacity(0.2),
                  indent: 4,
                  endIndent: 4,
                ),
                ProfileTile(
                  title: 'frequently_asked_questions',
                  onTap: () {},
                  icon: Assets.questionIc,
                ),
                Divider(
                  height: 0.5,
                  color: ColorPalette.of(context).textPrimary.withOpacity(0.2),
                  indent: 4,
                  endIndent: 4,
                ),
                ProfileTile(
                  title: 'terms_and_conditions',
                  onTap: () {},
                  icon: Assets.rulesIc,
                ),
                Divider(
                  height: 0.5,
                  color: ColorPalette.of(context).textPrimary.withOpacity(0.2),
                  indent: 4,
                  endIndent: 4,
                ),
                ProfileTile(
                  title: 'about_us',
                  onTap: () {},
                  icon: Assets.infoIc,
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            height: 40,
            margin: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              border: Border.all(
                width: 1.5,
                color: ColorPalette.of(context).primary,
              ),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  Assets.musicIc,
                  color: ColorPalette.of(context).textPrimary,
                  width: 16,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 5),
                  child: Text(
                    'support'.tr(),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 32,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                SvgPicture.asset(
                  Assets.exitIc,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 6),
                  child: Text(
                    'logout_from_account'.tr(),
                  ),
                )
              ],
            ),
          )
        ],
      );
}
