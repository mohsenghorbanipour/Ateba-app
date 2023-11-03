import 'package:ateba_app/core/components/button_component.dart';
import 'package:ateba_app/core/components/textfiled_component.dart';
import 'package:ateba_app/core/theme/style/color_palatte.dart';
import 'package:ateba_app/modules/course%20details/bloc/course_details_bloc.dart';
import 'package:ateba_app/modules/tutorial%20details/data/models/comment.dart';
import 'package:ateba_app/modules/tutorial%20details/ui/modals/send_comment_modals.dart';
import 'package:ateba_app/modules/tutorial%20details/ui/widgets/comment_card.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CommentsWidget extends StatelessWidget {
  const CommentsWidget({
    super.key,
    required this.slug,
  });

  final String slug;

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 32, 16, 16),
            child: TextFieldComponent(
              controller:
                  context.select<CourseDetailsBloc, TextEditingController>(
                      (bloc) => bloc.commentController),
              labelText: 'your_comment'.tr(),
              name: 'comment',
              maxLines: 2,
              onChanged: (val) {
                Provider.of<CourseDetailsBloc>(context, listen: false).comment =
                    val;
              },
              textAlign: TextAlign.right,
              hintText: 'comment_hint'.tr(),
            ),
          ),
          ButtonComponent(
            onPressed: () {
              if (Provider.of<CourseDetailsBloc>(context, listen: false)
                  .comment
                  .isNotEmpty) {
                Provider.of<CourseDetailsBloc>(context, listen: false)
                    .sendComment(
                  context,
                  slug,
                );
              }
            },
            loadingColor: ColorPalette.of(context).primary,
            loading: context.select<CourseDetailsBloc, bool>(
                (bloc) => bloc.sendCommentLoading),
            color: Colors.transparent,
            borderSide: BorderSide(
              width: 1.5,
              color: ColorPalette.of(context).primary,
            ),
            margin: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'send'.tr(),
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(
                  width: 4,
                ),
                Icon(
                  Icons.arrow_forward_rounded,
                  size: 18,
                  color: ColorPalette.of(context).textPrimary,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 16, top: 32),
            child: Text(
              'opinions_of_other_users'.tr(),
              style: Theme.of(context).textTheme.labelLarge,
            ),
          ),
          if (!context
              .select<CourseDetailsBloc, bool>((bloc) => bloc.commentLoading))
            Consumer<CourseDetailsBloc>(
              builder: (context, bloc, child) => bloc.comments.isEmpty
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 32),
                          child: Text(
                            'no_commented_yet'.tr(),
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                      ],
                    )
                  : ListView.separated(
                      padding: const EdgeInsets.fromLTRB(0, 16, 0, 24),
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: bloc.comments.length,
                      shrinkWrap: true,
                      separatorBuilder: (_, __) => const SizedBox(
                        height: 16,
                      ),
                      itemBuilder: (context, index) => CommentCard(
                        comment: bloc.comments[index],
                        commentIdForShowReplies: bloc.commentIdForShowReplies,
                        replies: bloc.replies,
                        likeTap: () {
                          if (bloc.comments[index].is_liked ?? false) {
                            bloc.unlikeComment(
                              bloc.comments[index].id.toString(),
                              index,
                            );
                          } else {
                            bloc.likeComment(
                              bloc.comments[index].id.toString(),
                              index,
                            );
                          }
                        },
                        onLongPress: () {
                          bloc.showOptions = true;
                          bloc.selectedComment = bloc.comments[index].id;
                          bloc.selectedCommentIndex = index;
                        },
                        showReplies: () {
                          if (bloc.replies.isNotEmpty &&
                              (bloc.commentIdForShowReplies?.isNotEmpty ??
                                  false)) {
                            if (bloc.commentIdForShowReplies ==
                                bloc.comments[index].id) {
                              bloc.hideReplies();
                            } else {
                              bloc.loadReplies(bloc.comments[index].id ?? '');
                            }
                          } else {
                            bloc.loadReplies(
                              bloc.comments[index].id ?? '',
                            );
                          }
                        },
                        sendCommentFunction: () {
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
                                  await bloc.sendReply(context, slug,
                                      bloc.comments[index].id ?? '', index);
                                },
                                onChange: (val) {
                                  bloc.comment = val;
                                },
                                onWillPop: () async {
                                  bloc.comment = '';
                                  return true;
                                },
                                commentEmpty:
                                    context.select<CourseDetailsBloc, bool>(
                                        (bloc) => bloc.comment.isEmpty),
                                controller: context.select<CourseDetailsBloc,
                                    TextEditingController>(
                                  (bloc) => bloc.replayController,
                                ),
                                loading:
                                    context.select<CourseDetailsBloc, bool>(
                                        (bloc) => bloc.sendReplyLoading),
                                replayTo: bloc.comments[index].user?.name ?? '',
                                isReplay: true,
                              ),
                            ),
                          );
                        },
                        selected: (bloc.selectedComment != null)
                            ? bloc.comments[index].id == bloc.selectedComment
                            : false,
                      ),
                    ),
            ),
        ],
      );
}
