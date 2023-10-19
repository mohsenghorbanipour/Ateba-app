import 'package:ateba_app/core/resources/assets/assets.dart';
import 'package:ateba_app/core/theme/style/color_palatte.dart';
import 'package:ateba_app/core/utils/date_helper.dart';
import 'package:ateba_app/core/utils/text_input_formatters.dart';
import 'package:ateba_app/modules/tutorial%20details/bloc/tutorial_details_bloc.dart';
import 'package:ateba_app/modules/tutorial%20details/data/models/comment.dart';
import 'package:ateba_app/modules/tutorial%20details/ui/modals/send_comment_modals.dart';
import 'package:ateba_app/modules/tutorial%20details/ui/widgets/reply_card.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class CommentCard extends StatelessWidget {
  const CommentCard({
    required this.comment,
    required this.likeTap,
    required this.onLongPress,
    required this.sendCommentFunction,
    this.selected = false,
    super.key,
  });

  final Comment comment;
  final Function() likeTap;
  final Function() onLongPress;
  final Function() sendCommentFunction;
  final bool selected;

  @override
  Widget build(BuildContext context) => InkWell(
        onLongPress: onLongPress,
        child: Container(
          color: selected
              ? ColorPalette.of(context).primary.withOpacity(0.1)
              : null,
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
                                  comment.user?.name ?? '',
                                ),
                                if (comment.is_pined ?? false)
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
                      InkWell(
                        onTap: likeTap,
                        child: Row(
                          children: [
                            if ((comment.likes_count ?? 0) > 0)
                              Padding(
                                padding: const EdgeInsets.only(left: 4),
                                child: Text(
                                  TextInputFormatters.toPersianNumber(
                                      comment.likes_count.toString()),
                                  style: Theme.of(context).textTheme.labelSmall,
                                ),
                              ),
                            SvgPicture.asset(
                              (comment.is_liked ?? false)
                                  ? Assets.likeHandFillIc
                                  : Assets.likeHandIc,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      InkWell(
                        onTap: sendCommentFunction,
                        child: Row(
                          children: [
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
              ),
              if ((comment.replies_count ?? 0) > 0)
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: InkWell(
                    onTap: () {
                      Provider.of<TutorialDetaialsBloc>(context, listen: false)
                          .loadReplies(
                        comment.id!,
                      );
                    },
                    child: Row(
                      children: [
                        Container(
                          height: 0.5,
                          width: 40,
                          color: ColorPalette.of(context).textPrimary,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 4),
                          child: Text(
                            '${'show_comments'.tr()} (${TextInputFormatters.toPersianNumber(comment.replies_count.toString())})',
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall
                                ?.copyWith(fontSize: 8),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              if (context.select<TutorialDetaialsBloc, bool>((bloc) =>
                  bloc.commentIdForShowReplies != null &&
                  bloc.replies.isNotEmpty &&
                  bloc.commentIdForShowReplies == comment.id))
                Selector<TutorialDetaialsBloc, List<Comment>>(
                  selector: (context, bloc) => bloc.replies,
                  builder: (context, replies, child) => ListView.builder(
                    itemCount: replies.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) => ReplyCard(
                      reply: replies[index],
                    ),
                  ),
                )
            ],
          ),
        ),
      );
}
