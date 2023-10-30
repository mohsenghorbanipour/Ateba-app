import 'package:ateba_app/core/base/bloc/download_video_bloc.dart';
import 'package:ateba_app/core/theme/style/color_palatte.dart';
import 'package:ateba_app/core/utils/text_input_formatters.dart';
import 'package:ateba_app/modules/tutorial%20details/data/models/video_link.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:ui' as ui;

class DownloadVideoTile extends StatelessWidget {
  const DownloadVideoTile({
    required this.videoLink,
    required this.onTap,
    this.selected = false,
    super.key,
  });

  final VideoLink videoLink;
  final Function() onTap;
  final bool selected;

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                children: [
                  Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        width: 1,
                        color: ColorPalette.of(context).textPrimary,
                      ),
                    ),
                    child: selected
                        ? Container(
                            width: 4,
                            height: 4,
                            margin: const EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: ColorPalette.of(context).primary,
                            ),
                          )
                        : null,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 6),
                      child: Row(
                        children: [
                          Text(
                            '${'quality'.tr()} ${videoLink.quality ?? ''}',
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                          Text(
                            TextInputFormatters.toPersianNumber(
                              '(${videoLink.size ?? ''})',
                            ),
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall
                                ?.copyWith(
                                  fontSize: 8,
                                  color: ColorPalette.of(context)
                                      .textPrimary
                                      .withOpacity(0.8),
                                ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (selected &&
                context.select<DownloadVideoBloc, bool>(
                    (bloc) => bloc.downloading))
              Container(
                height: 2,
                width: 50,
                decoration: BoxDecoration(
                  color: ColorPalette.of(context).darkGrey,
                  borderRadius: BorderRadius.circular(2),
                ),
                child: Directionality(
                  textDirection: ui.TextDirection.ltr,
                  child: Row(
                    children: [
                      Container(
                        height: 2,
                        width: context.select<DownloadVideoBloc, double>(
                            (bloc) => ((bloc.percentage ?? 0) / 100) * 50),
                        decoration: BoxDecoration(
                          color: ColorPalette.of(context).primary,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ],
                  ),
                ),
              )
          ],
        ),
      );
}
