import 'package:ateba_app/core/resources/assets/assets.dart';
import 'package:ateba_app/core/theme/style/color_palatte.dart';
import 'package:ateba_app/core/utils/launcher_helper.dart';
import 'package:ateba_app/modules/tutorial%20details/data/models/attachment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AttachmentTile extends StatelessWidget {
  const AttachmentTile({
    required this.attachment,
    super.key,
  });

  final Attachment attachment;

  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            attachment.title ?? '',
          ),
          if (attachment.is_singular ?? false)
            const Icon(
              Icons.keyboard_arrow_down_rounded,
              size: 24,
            )
          else
            InkWell(
              onTap: () {
                LauncherHelper.launch(attachment.files?.first.url);
              },
              child: SvgPicture.asset(
                Assets.visibilityIc,
                width: 20,
                color: ColorPalette.of(context).primary,
              ),
            )
        ],
      );
}
