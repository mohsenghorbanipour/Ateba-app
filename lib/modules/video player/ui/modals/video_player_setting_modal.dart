import 'package:ateba_app/core/components/modal_component.dart';
import 'package:ateba_app/core/theme/style/color_palatte.dart';
import 'package:ateba_app/modules/video%20player/ui/widgets/video_player_setting_tile.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class VideoPlayerSettingModal extends StatelessWidget {
  const VideoPlayerSettingModal({super.key});

  @override
  Widget build(BuildContext context) => Modal(
        margin: const EdgeInsets.all(12),
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8, 6, 8, 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 65,
                height: 6,
                margin: const EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                    color:
                        ColorPalette.of(context).textPrimary.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(6)),
              ),
              VideoPlayerSettingTile(
                icon: Icons.tune_rounded,
                title: 'quality'.tr(),
                optionWidget: Row(
                  children: [
                    Text(
                      'auto',
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          color: ColorPalette.of(context)
                              .textPrimary
                              .withOpacity(0.8)),
                    ),
                    Icon(Icons.arrow_back_ios_new_rounded,
                        size: 12,
                        color: ColorPalette.of(context)
                            .textPrimary
                            .withOpacity(0.8))
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}
