import 'package:ateba_app/core/components/button_component.dart';
import 'package:ateba_app/core/components/textfiled_component.dart';
import 'package:ateba_app/core/theme/style/color_palatte.dart';
import 'package:ateba_app/modules/course%20details/bloc/course_details_bloc.dart';
import 'package:ateba_app/modules/tutorial%20details/data/models/comment.dart';
import 'package:ateba_app/modules/tutorial%20details/ui/widgets/comment_card.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CommentsWidget extends StatelessWidget {
  const CommentsWidget({super.key});

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 32, 16, 16),
            child: TextFieldComponent(
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
                  '',
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
            Selector<CourseDetailsBloc, List<Comment>>(
              selector: (context, bloc) => bloc.comments,
              builder: (context, comments, child) => comments.isEmpty
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
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: comments.length,
                      shrinkWrap: true,
                      separatorBuilder: (_, __) => const SizedBox(
                        height: 16,
                      ),
                      itemBuilder: (context, index) => CommentCard(
                        comment: comments[index],
                        likeTap: () {},
                        onLongPress: () {},
                        sendCommentFunction: () {},
                        selected: false,
                      ),
                    ),
            ),
        ],
      );
}
