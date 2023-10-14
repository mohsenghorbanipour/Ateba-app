import 'package:ateba_app/core/resources/assets/assets.dart';
import 'package:ateba_app/core/theme/style/color_palatte.dart';
import 'package:ateba_app/core/utils/date_helper.dart';
import 'package:ateba_app/core/utils/text_input_formatters.dart';
import 'package:ateba_app/modules/tutorial%20details/data/models/comment.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ReplyCard extends StatelessWidget {
  const ReplyCard({
    required this.reply,
    super.key,
  });

  final Comment reply;

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: ColorPalette.of(context).error,
                      ),
                      child: Center(
                        child: SvgPicture.asset(
                          Assets.personUserIc,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 6),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                reply.user?.name ?? '',
                              ),
                              if (reply.is_pined ?? false)
                                Padding(
                                  padding: const EdgeInsets.only(right: 2),
                                  child: SvgPicture.asset(
                                    Assets.pinIc,
                                  ),
                                )
                            ],
                          ),
                          Text(
                            DateHelper.getDistanceWithToday(
                              reply.created_at ?? '',
                            ),
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium
                                ?.copyWith(fontSize: 10),
                          )
                        ],
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    InkWell(
                      onTap: () {},
                      child: Row(
                        children: [
                          if ((reply.likes_count ?? 0) > 0)
                            Padding(
                              padding: const EdgeInsets.only(left: 4),
                              child: Text(
                                TextInputFormatters.toPersianNumber(
                                    reply.likes_count.toString()),
                                style: Theme.of(context).textTheme.labelSmall,
                              ),
                            ),
                          SvgPicture.asset(
                            (reply.is_liked ?? false)
                                ? Assets.likeHandFillIc
                                : Assets.likeHandIc,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    SvgPicture.asset(
                      Assets.addIc,
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    Text(
                      'your_answer'.tr(),
                      style: Theme.of(context).textTheme.labelSmall,
                    )
                  ],
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                reply.content ?? '',
              ),
            ),
          ],
        ),
      );
}
