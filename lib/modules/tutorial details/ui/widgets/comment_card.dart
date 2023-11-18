import 'package:ateba_app/core/base/base_comment_page.dart';
import 'package:ateba_app/core/resources/assets/assets.dart';
import 'package:ateba_app/core/theme/style/color_palatte.dart';
import 'package:ateba_app/core/utils/date_helper.dart';
import 'package:ateba_app/core/utils/text_input_formatters.dart';
import 'package:ateba_app/modules/course%20details/bloc/course_details_bloc.dart';
import 'package:ateba_app/modules/package%20details/bloc/package_details_bloc.dart';
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
    required this.showReplies,
    required this.baseCommentPage,
    this.commentIdForShowReplies,
    this.selected = false,
    this.repliesLoading = false,
    this.replies,
    super.key,
  });

  final Comment comment;
  final Function() likeTap;
  final Function() onLongPress;
  final Function() sendCommentFunction;
  final Function() showReplies;
  final BaseCommentPage baseCommentPage;
  final bool selected;
  final String? commentIdForShowReplies;
  final List<Comment>? replies;
  final bool repliesLoading;

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
                        width: 40,
                        height: 40,
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
                                  style: Theme.of(context).textTheme.bodyMedium,
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
                              DateHelper.getRealDate(
                                comment.created_at ?? '',
                              ),
                              style: Theme.of(context).textTheme.labelMedium,
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
                                  style:
                                      Theme.of(context).textTheme.labelMedium,
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
                              style: Theme.of(context).textTheme.labelMedium,
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
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ),
              if ((comment.replies_count ?? 0) > 0)
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: InkWell(
                    onTap: showReplies,
                    child: Row(
                      children: [
                        Container(
                          height: 0.5,
                          width: 40,
                          color: ColorPalette.of(context).textPrimary,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 4),
                          child: Row(
                            children: [
                              Text(
                                ((commentIdForShowReplies?.isNotEmpty ??
                                            false) &&
                                        (replies?.isNotEmpty ?? false) &&
                                        commentIdForShowReplies == comment.id)
                                    ? '${'hide_answers'.tr()} (${TextInputFormatters.toPersianNumber(comment.replies_count.toString())})'
                                    : '${'show_comments'.tr()} (${TextInputFormatters.toPersianNumber(comment.replies_count.toString())})',
                                style: Theme.of(context).textTheme.labelSmall,
                              ),
                              if (repliesLoading)
                                Padding(
                                  padding: const EdgeInsets.only(right: 6),
                                  child: SizedBox(
                                    width: 10,
                                    height: 10,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 1.3,
                                      color: ColorPalette.of(context).primary,
                                    ),
                                  ),
                                )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              if ((commentIdForShowReplies?.isNotEmpty ?? false) &&
                  (replies?.isNotEmpty ?? false) &&
                  commentIdForShowReplies == comment.id)
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: replies?.length,
                  shrinkWrap: true,
                  padding: const EdgeInsets.only(right: 12),
                  itemBuilder: (context, index) => ReplyCard(
                    reply: replies?[index] ?? Comment(),
                    replyTap: () {
                      switch (baseCommentPage) {
                        case BaseCommentPage.tutorialDetaialsPage:
                          showModalBottomSheet(
                            context: context,
                            barrierColor: Colors.transparent,
                            backgroundColor: Colors.transparent,
                            elevation: 0,
                            useSafeArea: true,
                            constraints: BoxConstraints(
                              maxHeight: MediaQuery.of(context).size.height,
                              minHeight: MediaQuery.of(context).size.height,
                            ),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(0)),
                            isScrollControlled: true,
                            enableDrag: false,
                            useRootNavigator: true,
                            builder: (ctx) => ChangeNotifierProvider.value(
                              value: Provider.of<TutorialDetaialsBloc>(context,
                                  listen: false),
                              builder: (context, child) => SendCommentModals(
                                sendComment: () async {
                                  await Provider.of<TutorialDetaialsBloc>(
                                          context,
                                          listen: false)
                                      .sendReply(
                                    context,
                                    Provider.of<TutorialDetaialsBloc>(context,
                                                listen: false)
                                            .tutorialDetaials
                                            ?.slug ??
                                        '',
                                    replies?[index].id ?? '',
                                    index,
                                    replyToReply: true,
                                  );
                                },
                                onChange: (val) {
                                  Provider.of<TutorialDetaialsBloc>(context,
                                          listen: false)
                                      .comment = val;
                                },
                                onWillPop: () async {
                                  Provider.of<TutorialDetaialsBloc>(context,
                                          listen: false)
                                      .comment = '';
                                  return true;
                                },
                                commentEmpty:
                                    context.select<TutorialDetaialsBloc, bool>(
                                        (bloc) => bloc.comment.isEmpty),
                                controller: context.select<TutorialDetaialsBloc,
                                    TextEditingController>(
                                  (bloc) => bloc.commentController,
                                ),
                                loading:
                                    context.select<TutorialDetaialsBloc, bool>(
                                        (bloc) => bloc.sendCommentLoading),
                                replayTo: replies?[index].user?.name ?? '',
                                isReplay: true,
                              ),
                            ),
                          );
                          break;
                        case BaseCommentPage.courseDetailsPage:
                          showModalBottomSheet(
                            context: context,
                            barrierColor: Colors.transparent,
                            backgroundColor: Colors.transparent,
                            elevation: 0,
                            useSafeArea: true,
                            constraints: BoxConstraints(
                              maxHeight: MediaQuery.of(context).size.height,
                              minHeight: MediaQuery.of(context).size.height,
                            ),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(0)),
                            isScrollControlled: true,
                            enableDrag: false,
                            useRootNavigator: true,
                            builder: (ctx) => ChangeNotifierProvider.value(
                              value: Provider.of<CourseDetailsBloc>(context,
                                  listen: false),
                              builder: (context, child) => SendCommentModals(
                                sendComment: () async {
                                  await Provider.of<CourseDetailsBloc>(context,
                                          listen: false)
                                      .sendReply(
                                    context,
                                    Provider.of<CourseDetailsBloc>(context,
                                                listen: false)
                                            .courseDetails
                                            ?.slug ??
                                        '',
                                    replies?[index].id ?? '',
                                    index,
                                    replyToReply: true,
                                  );
                                },
                                onChange: (val) {
                                  Provider.of<CourseDetailsBloc>(context,
                                          listen: false)
                                      .comment = val;
                                },
                                onWillPop: () async {
                                  Provider.of<CourseDetailsBloc>(context,
                                          listen: false)
                                      .comment = '';
                                  return true;
                                },
                                commentEmpty:
                                    context.select<CourseDetailsBloc, bool>(
                                        (bloc) => bloc.comment.isEmpty),
                                controller: context.select<CourseDetailsBloc,
                                    TextEditingController>(
                                  (bloc) => bloc.commentController,
                                ),
                                loading:
                                    context.select<CourseDetailsBloc, bool>(
                                        (bloc) => bloc.sendReplyLoading),
                                replayTo: replies?[index].user?.name ?? '',
                                isReplay: true,
                              ),
                            ),
                          );
                          break;
                        case BaseCommentPage.packageDetailsPage:
                          showModalBottomSheet(
                            context: context,
                            barrierColor: Colors.transparent,
                            backgroundColor: Colors.transparent,
                            elevation: 0,
                            useSafeArea: true,
                            constraints: BoxConstraints(
                              maxHeight: MediaQuery.of(context).size.height,
                              minHeight: MediaQuery.of(context).size.height,
                            ),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(0)),
                            isScrollControlled: true,
                            enableDrag: false,
                            useRootNavigator: true,
                            builder: (ctx) => ChangeNotifierProvider.value(
                              value: Provider.of<PackageDetailsBloc>(context,
                                  listen: false),
                              builder: (context, child) => SendCommentModals(
                                sendComment: () async {
                                  await Provider.of<PackageDetailsBloc>(context,
                                          listen: false)
                                      .sendReply(
                                    context,
                                    Provider.of<PackageDetailsBloc>(context,
                                                listen: false)
                                            .packageDetails
                                            ?.slug ??
                                        '',
                                    replies?[index].id ?? '',
                                    index,
                                    replyToReply: true,
                                  );
                                },
                                onChange: (val) {
                                  Provider.of<PackageDetailsBloc>(context,
                                          listen: false)
                                      .comment = val;
                                },
                                onWillPop: () async {
                                  Provider.of<PackageDetailsBloc>(context,
                                          listen: false)
                                      .comment = '';
                                  return true;
                                },
                                commentEmpty:
                                    context.select<PackageDetailsBloc, bool>(
                                        (bloc) => bloc.comment.isEmpty),
                                controller: context.select<PackageDetailsBloc,
                                    TextEditingController>(
                                  (bloc) => bloc.commentController,
                                ),
                                loading:
                                    context.select<PackageDetailsBloc, bool>(
                                        (bloc) => bloc.sendReplyLoading),
                                replayTo: replies?[index].user?.name ?? '',
                                isReplay: true,
                              ),
                            ),
                          );
                          break;
                      }
                    },
                    likeTap: () {
                      switch (baseCommentPage) {
                        case BaseCommentPage.tutorialDetaialsPage:
                          if (replies?[index].is_liked ?? false) {
                            Provider.of<TutorialDetaialsBloc>(context,
                                    listen: false)
                                .unlikeComment(
                              replies?[index].id ?? '',
                              index,
                              likeReply: true,
                            );
                          } else {
                            Provider.of<TutorialDetaialsBloc>(context,
                                    listen: false)
                                .likeComment(
                              replies?[index].id ?? '',
                              index,
                              likeReply: true,
                            );
                          }
                          break;
                        case BaseCommentPage.courseDetailsPage:
                          if (replies?[index].is_liked ?? false) {
                            Provider.of<CourseDetailsBloc>(context,
                                    listen: false)
                                .unlikeComment(
                              replies?[index].id ?? '',
                              index,
                              likeReply: true,
                            );
                          } else {
                            Provider.of<CourseDetailsBloc>(context,
                                    listen: false)
                                .likeComment(
                              replies?[index].id ?? '',
                              index,
                              likeReply: true,
                            );
                          }
                          break;
                        case BaseCommentPage.packageDetailsPage:
                          if (replies?[index].is_liked ?? false) {
                            Provider.of<PackageDetailsBloc>(context,
                                    listen: false)
                                .unlikeComment(
                              replies?[index].id ?? '',
                              index,
                              likeReply: true,
                            );
                          } else {
                            Provider.of<PackageDetailsBloc>(context,
                                    listen: false)
                                .likeComment(
                              replies?[index].id ?? '',
                              index,
                              likeReply: true,
                            );
                          }
                          break;
                      }
                    },
                  ),
                ),
            ],
          ),
        ),
      );
}
