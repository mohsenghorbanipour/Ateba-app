import 'package:ateba_app/core/theme/style/color_palatte.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class SendCommentModals extends StatelessWidget {
  const SendCommentModals({super.key});

  @override
  Widget build(BuildContext context) => Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        color: ColorPalette.of(context).shadow,
        child: Column(
          children: [
            Expanded(
              child: InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: const SizedBox(
                  width: double.infinity,
                ),
              ),
            ),
            TextField(
              autofocus: true,
              keyboardType: TextInputType.multiline,
              textInputAction: TextInputAction.newline,
              maxLines: 4,
              minLines: 1,
              scrollPadding: EdgeInsets.zero,
              decoration: InputDecoration(
                filled: true,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                hintStyle: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color:
                          ColorPalette.of(context).textPrimary.withOpacity(0.5),
                    ),
                hintText: 'your_comment_about_comment'.tr(),
                fillColor: ColorPalette.of(context).background,
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.zero,
                  borderSide: BorderSide.none,
                ),
                errorBorder: const OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.zero,
                ),
                focusedErrorBorder: const OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.zero,
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.zero,
                ),
                prefixIcon: InkWell(
                  onTap: () {},
                  child: Container(
                    width: 40,
                    height: 40,
                    margin: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: ColorPalette.of(context).primary,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Icon(
                        Icons.arrow_upward_rounded,
                        color: ColorPalette.of(context).white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
}
