import 'package:ateba_app/core/components/shimmer_components.dart';
import 'package:ateba_app/core/components/textfiled_component.dart';
import 'package:ateba_app/core/resources/assets/assets.dart';
import 'package:ateba_app/core/theme/style/color_palatte.dart';
import 'package:ateba_app/core/utils/date_helper.dart';
import 'package:ateba_app/core/utils/text_input_formatters.dart';
import 'package:ateba_app/modules/tutorial%20details/bloc/tutorial_details_bloc.dart';
import 'package:ateba_app/modules/tutorial%20details/data/models/attachment.dart';
import 'package:ateba_app/modules/tutorial%20details/ui/widgets/attachment_tile.dart';
import 'package:ateba_app/modules/tutorial%20details/ui/widgets/tutorial_details_shimmer.dart';
import 'package:cached_network_image/cached_network_image.dart';
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
        create: (context) => TutorialDetaialsBloc(slug),
        lazy: false,
        builder: (context, child) => Scaffold(
          backgroundColor: ColorPalette.of(context).scaffoldBackground,
          body: context
                  .select<TutorialDetaialsBloc, bool>((bloc) => bloc.loading)
              ? const TutorialDetailsShimmer()
              : SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelMedium,
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        height: 150,
                        margin: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            8,
                          ),
                          image: DecorationImage(
                            image: CachedNetworkImageProvider(
                              context.select<TutorialDetaialsBloc, String>(
                                  (bloc) =>
                                      bloc.tutorialDetaials?.cover_url ?? ''),
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Center(
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: ColorPalette.of(context).error,
                            ),
                            child: Center(
                              child: Icon(
                                Icons.play_arrow_rounded,
                                color: ColorPalette.light.background,
                                size: 24,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                context.select<TutorialDetaialsBloc, String>(
                                  (bloc) =>
                                      '${bloc.tutorialDetaials?.title ?? ''} - ${bloc.tutorialDetaials?.teacher?.name ?? ''}',
                                ),
                                style: Theme.of(context).textTheme.titleMedium,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const SizedBox(
                              width: 24,
                            ),
                            Row(
                              children: [
                                Container(
                                  height: 24,
                                  padding: const EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    color: ColorPalette.of(context).border,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Row(
                                    children: [
                                      Text(
                                        context.select<TutorialDetaialsBloc,
                                            String>(
                                          (bloc) =>
                                              bloc.tutorialDetaials?.like_count
                                                  .toString() ??
                                              '',
                                        ),
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelMedium,
                                      ),
                                      const SizedBox(
                                        width: 4,
                                      ),
                                      SvgPicture.asset(
                                        Assets.likeFillIc,
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  height: 24,
                                  padding: const EdgeInsets.all(4),
                                  margin: const EdgeInsets.only(right: 12),
                                  decoration: BoxDecoration(
                                    color: ColorPalette.of(context).border,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: SvgPicture.asset(
                                    Assets.downloadIc,
                                  ),
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
                                  context.select<TutorialDetaialsBloc, String>(
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
                                      fontSize: 10,
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
                                  context.select<TutorialDetaialsBloc, String>(
                                    (bloc) =>
                                        bloc.tutorialDetaials?.duration ?? '0',
                                  ),
                                ),
                                style: Theme.of(context)
                                    .textTheme
                                    .labelMedium
                                    ?.copyWith(
                                      fontSize: 10,
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
                              Assets.calendarIc,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 4),
                              child: Text(
                                DateHelper.getDistanceWithToday(
                                  context.select<TutorialDetaialsBloc, String>(
                                    (bloc) =>
                                        bloc.tutorialDetaials?.updated_at ?? '',
                                  ),
                                ),
                                style: Theme.of(context)
                                    .textTheme
                                    .labelMedium
                                    ?.copyWith(
                                      fontSize: 10,
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
                        padding: const EdgeInsets.only(top: 24, right: 16),
                        child: Text(
                          'summary_of_tutorial'.tr(),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 6, 16, 26),
                        child: Text(
                          context.select<TutorialDetaialsBloc, String>((bloc) =>
                              bloc.tutorialDetaials?.description ?? ''),
                          textAlign: TextAlign.justify,
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                      ),
                      Selector<TutorialDetaialsBloc, List<Attachment>>(
                        selector: (context, bloc) =>
                            bloc.tutorialDetaials?.attachments ?? [],
                        builder: (context, attachments, child) =>
                            ListView.separated(
                          physics: const NeverScrollableScrollPhysics(),
                          padding: const EdgeInsets.symmetric(horizontal: 16),
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
                            Text(
                              '${'comments'.tr()} (${TextInputFormatters.toPersianNumber(
                                context.select<TutorialDetaialsBloc, String>(
                                  (bloc) =>
                                      bloc.tutorialDetaials?.comment_counts
                                          .toString() ??
                                      '0',
                                ),
                              )})',
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            TextFieldComponent(
                              name: '',
                              showLabel: false,
                              hintText: 'your_comment_about_comment'.tr(),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
        ),
      );
}
