// ignore_for_file: use_build_context_synchronously

import 'package:ateba_app/core/base/base_comment_page.dart';
import 'package:ateba_app/core/components/textfiled_component.dart';
import 'package:ateba_app/core/resources/assets/assets.dart';
import 'package:ateba_app/core/router/routes.dart';
import 'package:ateba_app/core/theme/style/color_palatte.dart';
import 'package:ateba_app/core/utils/date_helper.dart';
import 'package:ateba_app/core/utils/text_input_formatters.dart';
import 'package:ateba_app/core/widgets/no_active_subscription_dialog.dart';
import 'package:ateba_app/modules/auth/bloc/auth_bloc.dart';
import 'package:ateba_app/modules/tutorial%20details/bloc/tutorial_details_bloc.dart';
import 'package:ateba_app/modules/tutorial%20details/data/models/attachment.dart';
import 'package:ateba_app/modules/tutorial%20details/data/models/video.dart';
import 'package:ateba_app/modules/tutorial%20details/ui/modals/send_comment_modals.dart';
import 'package:ateba_app/modules/tutorial%20details/ui/widgets/attachment_tile.dart';
import 'package:ateba_app/modules/tutorial%20details/ui/widgets/comment_card.dart';
import 'package:ateba_app/modules/tutorial%20details/ui/widgets/tutorial_details_shimmer.dart';
import 'package:ateba_app/modules/tutorial%20details/ui/widgets/tutorial_download_widget.dart';
import 'package:ateba_app/modules/tutorial%20details/ui/widgets/tutorial_video_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:styled_text/styled_text.dart';

class TutorialDetailsPage extends StatelessWidget {
  const TutorialDetailsPage({
    required this.slug,
    super.key,
  });

  final String slug;

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => TutorialDetaialsBloc(slug),
        lazy: false,
        builder: (context, child) => GestureDetector(
          onTap: () {
            Provider.of<TutorialDetaialsBloc>(context, listen: false)
                .showOptions = false;
            Provider.of<TutorialDetaialsBloc>(context, listen: false)
                .selectedComment = null;
            Provider.of<TutorialDetaialsBloc>(context, listen: false)
                .selectedCommentIndex = null;
          },
          child: Scaffold(
            appBar: context.select<TutorialDetaialsBloc, bool>(
                    (bloc) => bloc.showOptions)
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
                        Provider.of<TutorialDetaialsBloc>(context,
                                listen: false)
                            .showOptions = false;
                        Provider.of<TutorialDetaialsBloc>(context,
                                listen: false)
                            .selectedComment = null;
                        Provider.of<TutorialDetaialsBloc>(context,
                                listen: false)
                            .selectedCommentIndex = null;
                      },
                      icon: const Icon(
                        CupertinoIcons.clear_thick,
                      ),
                    ),
                    actions: [
                      IconButton(
                        onPressed: () {
                          Provider.of<TutorialDetaialsBloc>(context,
                                  listen: false)
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
            body: context.select<TutorialDetaialsBloc, bool>(
                    (bloc) => bloc.loading || bloc.commentLoading)
                ? const TutorialDetailsShimmer()
                : LazyLoadScrollView(
                    onEndOfPage: () {
                      if (Provider.of<TutorialDetaialsBloc>(context,
                              listen: false)
                          .canLoadMoreComment) {
                        Provider.of<TutorialDetaialsBloc>(context,
                                listen: false)
                            .loadMoreComments(slug);
                      }
                    },
                    isLoading: context.select<TutorialDetaialsBloc, bool>(
                        (bloc) => bloc.isLoadingMoreComments),
                    child: ListView(
                      physics: const BouncingScrollPhysics(),
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
                              InkWell(
                                onTap: () {
                                  if (Provider.of<TutorialDetaialsBloc>(context,
                                              listen: false)
                                          .tutorialDetaials
                                          ?.is_bookmarked ??
                                      false) {
                                    Provider.of<TutorialDetaialsBloc>(context,
                                            listen: false)
                                        .unBookmarkTutorial(slug);
                                  } else {
                                    Provider.of<TutorialDetaialsBloc>(context,
                                            listen: false)
                                        .bookmarkTutorial(slug);
                                  }
                                },
                                child: Container(
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
                                      if (context.select<TutorialDetaialsBloc,
                                          bool>((bloc) => bloc.bookmarkLoading))
                                        SizedBox(
                                          width: 16,
                                          height: 16,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 1.5,
                                            color: ColorPalette.of(context)
                                                .primary,
                                          ),
                                        )
                                      else
                                        SvgPicture.asset(
                                          context.select<TutorialDetaialsBloc,
                                                      bool>(
                                                  (bloc) =>
                                                      bloc.tutorialDetaials
                                                          ?.is_bookmarked ??
                                                      false)
                                              ? Assets.bookmarkFillIc
                                              : Assets.bookmarkIc,
                                          width: 16,
                                          color:
                                              ColorPalette.of(context).primary,
                                        ),
                                      if (!context
                                          .select<TutorialDetaialsBloc, bool>(
                                              (bloc) =>
                                                  bloc.tutorialDetaials
                                                      ?.is_bookmarked ??
                                                  false))
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 4),
                                          child: Text(
                                            'bookmarking'.tr(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelMedium,
                                          ),
                                        )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        TutorialVideoWidget(
                          videos: context.select<TutorialDetaialsBloc, dynamic>(
                              (bloc) => bloc.tutorialDetaials?.videos),
                          coverUrl: context
                              .select<TutorialDetaialsBloc, String>((bloc) =>
                                  bloc.tutorialDetaials?.cover_url ?? ''),
                          slug: slug,
                          hasAccess: context.select<TutorialDetaialsBloc, bool>(
                              (bloc) =>
                                  bloc.tutorialDetaials?.has_access ?? false),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  context.select<TutorialDetaialsBloc, String>(
                                    (bloc) =>
                                        '${(bloc.tutorialDetaials?.videos?.length ?? 0) > 1 ? '${TextInputFormatters.toPersianNumber(
                                            (bloc.tutorialDetaials?.videos
                                                        ?.length ??
                                                    0)
                                                .toString(),
                                          )} / ${TextInputFormatters.toPersianNumber((bloc.selectedVideoIndex! + 1).toString())}.' : ''} ${bloc.tutorialDetaials?.title ?? ''} - ${bloc.tutorialDetaials?.teacher?.name ?? ''}',
                                  ),
                                  maxLines: 2,
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              const SizedBox(
                                width: 24,
                              ),
                              Row(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      if (Provider.of<TutorialDetaialsBloc>(
                                                  context,
                                                  listen: false)
                                              .tutorialDetaials
                                              ?.is_liked ??
                                          false) {
                                        Provider.of<TutorialDetaialsBloc>(
                                                context,
                                                listen: false)
                                            .unlikeTutorial(
                                          slug,
                                        );
                                      } else {
                                        Provider.of<TutorialDetaialsBloc>(
                                                context,
                                                listen: false)
                                            .likeTutorial(
                                          slug,
                                        );
                                      }
                                    },
                                    child: Container(
                                      height: 24,
                                      padding: const EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                        color: ColorPalette.of(context).border,
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: Row(
                                        children: [
                                          if (context.select<
                                              TutorialDetaialsBloc, bool>(
                                            (bloc) =>
                                                bloc.tutorialDetaials
                                                        ?.likes_count !=
                                                    null &&
                                                (bloc.tutorialDetaials
                                                            ?.likes_count ??
                                                        0) >
                                                    0,
                                          ))
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 4),
                                              child: Text(
                                                context.select<
                                                    TutorialDetaialsBloc,
                                                    String>(
                                                  (bloc) =>
                                                      bloc.tutorialDetaials
                                                          ?.likes_count
                                                          .toString() ??
                                                      '0',
                                                ),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .labelMedium,
                                              ),
                                            ),
                                          if (context.select<
                                              TutorialDetaialsBloc,
                                              bool>((bloc) => bloc.likeLoading))
                                            SizedBox(
                                              width: 16,
                                              height: 16,
                                              child: CircularProgressIndicator(
                                                strokeWidth: 1.5,
                                                color: ColorPalette.of(context)
                                                    .primary,
                                              ),
                                            )
                                          else
                                            SvgPicture.asset(
                                              context.select<
                                                          TutorialDetaialsBloc,
                                                          bool>(
                                                      (bloc) =>
                                                          bloc.tutorialDetaials
                                                              ?.is_liked ??
                                                          false)
                                                  ? Assets.likeFillIc
                                                  : Assets.likeIc,
                                            )
                                        ],
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Share.share(
                                        Provider.of<TutorialDetaialsBloc>(
                                                    context,
                                                    listen: false)
                                                .tutorialDetaials
                                                ?.share
                                                ?.link ??
                                            '',
                                      );
                                    },
                                    child: Container(
                                      height: 24,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 4),
                                      margin: const EdgeInsets.only(right: 12),
                                      decoration: BoxDecoration(
                                        color: ColorPalette.of(context).border,
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: SvgPicture.asset(
                                        Assets.shareIc,
                                      ),
                                    ),
                                  ),
                                  TutorialDownloadWidget(
                                    slug: slug,
                                    video: context
                                        .select<TutorialDetaialsBloc, Video>(
                                      (bloc) => bloc.getVideo() ?? Video(),
                                    ),
                                    hasAccess: context
                                        .select<TutorialDetaialsBloc, bool>(
                                            (bloc) =>
                                                bloc.tutorialDetaials
                                                    ?.has_access ??
                                                false),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                Assets.visibilityIc,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 4),
                                child: Text(
                                  TextInputFormatters.toPersianNumber(
                                    context
                                        .select<TutorialDetaialsBloc, String>(
                                      (bloc) =>
                                          bloc.tutorialDetaials?.views_count
                                              .toString() ??
                                          '0',
                                    ),
                                  ),
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelMedium
                                      ?.copyWith(
                                        color: ColorPalette.of(context)
                                            .textPrimary
                                            .withOpacity(0.88),
                                      ),
                                ),
                              ),
                              const SizedBox(
                                width: 16,
                              ),
                              SvgPicture.asset(
                                Assets.clockIc,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 4),
                                child: Text(
                                  TextInputFormatters.toPersianNumber(
                                    context
                                        .select<TutorialDetaialsBloc, String>(
                                      (bloc) =>
                                          bloc.tutorialDetaials?.duration ??
                                          '0',
                                    ),
                                  ),
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelMedium
                                      ?.copyWith(
                                        color: ColorPalette.of(context)
                                            .textPrimary
                                            .withOpacity(0.88),
                                      ),
                                ),
                              ),
                              const SizedBox(
                                width: 16,
                              ),
                              SvgPicture.asset(
                                Assets.refreshIc,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 4),
                                child: Text(
                                  DateHelper.getDistanceWithToday(
                                    context
                                        .select<TutorialDetaialsBloc, String>(
                                      (bloc) =>
                                          bloc.tutorialDetaials?.updated_at ??
                                          '',
                                    ),
                                  ),
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelMedium
                                      ?.copyWith(
                                        color: ColorPalette.of(context)
                                            .textPrimary
                                            .withOpacity(0.88),
                                      ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 12, 16, 26),
                          child: StyledText(
                            text: context.select<TutorialDetaialsBloc, String>(
                                (bloc) =>
                                    bloc.tutorialDetaials?.description ?? ''),
                            tags: {
                              'p': StyledTextTag(
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: ColorPalette.of(context).textPrimary,
                                  fontSize: 14,
                                ),
                              ),
                            },
                            textAlign: TextAlign.justify,
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                        ),
                        Selector<TutorialDetaialsBloc, List<Attachment>>(
                          selector: (context, bloc) =>
                              bloc.tutorialDetaials?.attachments ?? [],
                          builder: (context, attachments, child) =>
                              ListView.separated(
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: attachments.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) => AttachmentTile(
                              attachment: attachments[index],
                            ),
                            separatorBuilder: (_, __) => const SizedBox(
                              height: 16,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
                          margin: const EdgeInsets.only(top: 28),
                          color: ColorPalette.of(context).lightSilver,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // if (context.select<TutorialDetaialsBloc, bool>(
                              //     (bloc) =>
                              //         bloc.tutorialDetaials?.comment_counts !=
                              //         null))
                              Text(
                                '${'comments'.tr()} (${TextInputFormatters.toPersianNumber(
                                  context.select<TutorialDetaialsBloc, String>(
                                    (bloc) =>
                                        bloc.tutorialDetaials?.comments_count
                                            .toString() ??
                                        '0',
                                  ),
                                )})',
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              InkWell(
                                onTap: () {
                                  showModalBottomSheet(
                                    context: context,
                                    barrierColor: Colors.transparent,
                                    backgroundColor: Colors.transparent,
                                    elevation: 0,
                                    useSafeArea: true,
                                    constraints: BoxConstraints(
                                      maxHeight:
                                          MediaQuery.of(context).size.height,
                                      minHeight:
                                          MediaQuery.of(context).size.height,
                                    ),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(0)),
                                    isScrollControlled: true,
                                    enableDrag: false,
                                    useRootNavigator: true,
                                    builder: (ctx) =>
                                        ChangeNotifierProvider.value(
                                      value: Provider.of<TutorialDetaialsBloc>(
                                          context,
                                          listen: false),
                                      builder: (context, child) =>
                                          SendCommentModals(
                                        sendComment: () async {
                                          await Provider.of<
                                                      TutorialDetaialsBloc>(
                                                  context,
                                                  listen: false)
                                              .sendComment(context, slug);
                                        },
                                        onChange: (val) {
                                          Provider.of<TutorialDetaialsBloc>(
                                                  context,
                                                  listen: false)
                                              .comment = val;
                                        },
                                        onWillPop: () async {
                                          Provider.of<TutorialDetaialsBloc>(
                                                  context,
                                                  listen: false)
                                              .comment = '';
                                          Provider.of<TutorialDetaialsBloc>(
                                                  context,
                                                  listen: false)
                                              .commentController
                                              .clear();

                                          return true;
                                        },
                                        controller: context.select<
                                            TutorialDetaialsBloc,
                                            TextEditingController>(
                                          (bloc) => bloc.commentController,
                                        ),
                                        commentEmpty: context
                                            .select<TutorialDetaialsBloc, bool>(
                                                (bloc) => bloc.comment.isEmpty),
                                        loading: context.select<
                                                TutorialDetaialsBloc, bool>(
                                            (bloc) => bloc.sendCommentLoading),
                                      ),
                                    ),
                                  );
                                },
                                child: TextFieldComponent(
                                  name: '',
                                  showLabel: false,
                                  textAlign: TextAlign.right,
                                  enabled: false,
                                  hintText: 'your_comment_about_comment'.tr(),
                                ),
                              )
                            ],
                          ),
                        ),
                        Consumer<TutorialDetaialsBloc>(
                          builder: (context, bloc, child) => ListView.builder(
                            padding: const EdgeInsets.only(top: 8, bottom: 16),
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: bloc.comments.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) => CommentCard(
                              comment: bloc.comments[index],
                              likeCommentLoading: bloc.commentLikeLoading,
                              likedCommentId: bloc.likedCommentId,
                              baseCommentPage:
                                  BaseCommentPage.tutorialDetaialsPage,
                              repliesLoading: bloc.repliesLoading &&
                                  bloc.commentIdForShowReplies ==
                                      bloc.comments[index].id,
                              commentIdForShowReplies:
                                  bloc.commentIdForShowReplies,
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
                              showReplies: () {
                                if (bloc.replies.isNotEmpty &&
                                    (bloc.commentIdForShowReplies?.isNotEmpty ??
                                        false)) {
                                  if (bloc.commentIdForShowReplies ==
                                      bloc.comments[index].id) {
                                    bloc.hideReplies();
                                  } else {
                                    bloc.loadReplies(
                                        bloc.comments[index].id ?? '');
                                  }
                                } else {
                                  bloc.loadReplies(
                                    bloc.comments[index].id ?? '',
                                  );
                                }
                              },
                              onLongPress: () {
                                if (bloc.comments[index].user?.id ==
                                    AuthBloc().userProfile?.id) {
                                  bloc.showOptions = true;
                                  bloc.selectedComment =
                                      bloc.comments[index].id;
                                  bloc.selectedCommentIndex = index;
                                }
                              },
                              selected: (bloc.selectedComment != null)
                                  ? bloc.comments[index].id ==
                                      bloc.selectedComment
                                  : false,
                              sendCommentFunction: () {
                                showModalBottomSheet(
                                  context: context,
                                  barrierColor: Colors.transparent,
                                  backgroundColor: Colors.transparent,
                                  elevation: 0,
                                  useSafeArea: true,
                                  constraints: BoxConstraints(
                                    maxHeight:
                                        MediaQuery.of(context).size.height,
                                    minHeight:
                                        MediaQuery.of(context).size.height,
                                  ),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(0)),
                                  isScrollControlled: true,
                                  enableDrag: false,
                                  useRootNavigator: true,
                                  builder: (ctx) =>
                                      ChangeNotifierProvider.value(
                                    value: Provider.of<TutorialDetaialsBloc>(
                                        context,
                                        listen: false),
                                    builder: (context, child) =>
                                        SendCommentModals(
                                      sendComment: () async {
                                        await Provider.of<TutorialDetaialsBloc>(
                                                context,
                                                listen: false)
                                            .sendReply(
                                                context,
                                                slug,
                                                bloc.comments[index].id ?? '',
                                                index);
                                      },
                                      onChange: (val) {
                                        Provider.of<TutorialDetaialsBloc>(
                                                context,
                                                listen: false)
                                            .comment = val;
                                      },
                                      onWillPop: () async {
                                        Provider.of<TutorialDetaialsBloc>(
                                                context,
                                                listen: false)
                                            .comment = '';
                                        return true;
                                      },
                                      commentEmpty: context.select<
                                          TutorialDetaialsBloc,
                                          bool>((bloc) => bloc.comment.isEmpty),
                                      controller: context.select<
                                          TutorialDetaialsBloc,
                                          TextEditingController>(
                                        (bloc) => bloc.commentController,
                                      ),
                                      loading: context.select<
                                              TutorialDetaialsBloc, bool>(
                                          (bloc) => bloc.sendCommentLoading),
                                      replayTo:
                                          bloc.comments[index].user?.name ?? '',
                                      isReplay: true,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
          ),
        ),
      );
}
