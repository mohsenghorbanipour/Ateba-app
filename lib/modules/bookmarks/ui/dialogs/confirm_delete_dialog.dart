import 'package:ateba_app/core/base/bloc/download_video_bloc.dart';
import 'package:ateba_app/core/components/button_component.dart';
import 'package:ateba_app/core/resources/assets/assets.dart';
import 'package:ateba_app/core/theme/style/color_palatte.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ConfirmDeleteDialog extends StatelessWidget {
  const ConfirmDeleteDialog({
    required this.index,
    super.key,
  });

  final int index;

  @override
  Widget build(BuildContext context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        backgroundColor: ColorPalette.of(context).background,
        elevation: 0,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    onPressed: () {
                      context.pop();
                    },
                    icon: SvgPicture.asset(
                      Assets.closeIc,
                    ),
                  ),
                ),
                Text(
                  'delete_from_offline_gallery'.tr(),
                  style: Theme.of(context).textTheme.titleSmall,
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: ButtonComponent(
                      onPressed: () {
                        Provider.of<DownloadVideoBloc>(context, listen: false)
                            .deleteFromGallery(
                          index,
                        );
                        Navigator.of(context).pop();
                      },
                      height: 40,
                      color: Colors.transparent,
                      borderSide: BorderSide(
                        width: 1.2,
                        color: ColorPalette.of(context).error,
                      ),
                      child: Text(
                        'yes'.tr(),
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                              color: ColorPalette.of(context).error,
                            ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ButtonComponent(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      height: 40,
                      color: Colors.transparent,
                      child: Text('back'.tr(),
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge
                              ?.copyWith(
                                  color: ColorPalette.of(context).primary)),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      );
}
