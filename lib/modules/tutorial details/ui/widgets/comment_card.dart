import 'package:ateba_app/core/resources/assets/assets.dart';
import 'package:ateba_app/core/theme/style/color_palatte.dart';
import 'package:ateba_app/core/utils/date_helper.dart';
import 'package:ateba_app/modules/tutorial%20details/data/models/comment.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CommentCard extends StatelessWidget {
  const CommentCard({
    required this.comment,
    super.key,
  });

  final Comment comment;

  @override
  Widget build(BuildContext context) => Column(
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
                        Text(
                          comment.user?.name ?? '',
                        ),
                        Text(
                          DateHelper.getDistanceWithToday(
                            comment.created_at ?? '',
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
                  SvgPicture.asset(
                    Assets.likeHandIc,
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
              comment.content ?? '',
            ),
          )
        ],
      );
}
