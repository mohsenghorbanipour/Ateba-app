import 'package:ateba_app/core/theme/style/color_palatte.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

class SendCommentModals extends StatelessWidget {
  const SendCommentModals({
    required this.sendComment,
    required this.onChange,
    required this.onWillPop,
    required this.controller,
    this.loading = false,
    this.isReplay = false,
    this.commentEmpty = false,
    this.replayTo,
    super.key,
  });

  final Function() sendComment;
  final Function(String val) onChange;
  final Future<bool> Function() onWillPop;
  final TextEditingController controller;
  final bool loading;
  final bool isReplay;
  final bool commentEmpty;
  final String? replayTo;

  @override
  Widget build(BuildContext context) => WillPopScope(
        onWillPop: onWillPop,
        child: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          color: ColorPalette.of(context).shadow,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: InkWell(
                  onTap: () async {
                    Navigator.of(context).pop();
                    await onWillPop();
                  },
                  child: const SizedBox(
                    width: double.infinity,
                  ),
                ),
              ),
              if (isReplay)
                Container(
                  padding: const EdgeInsets.all(8),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: ColorPalette.dark.background,
                  ),
                  child: Row(
                    children: [
                      Text(
                        '${'reply_to'.tr()} : ${replayTo ?? ''}',
                        style:
                            Theme.of(context).textTheme.labelMedium?.copyWith(
                                  color: ColorPalette.dark.textPrimary,
                                ),
                      )
                    ],
                  ),
                ),
              KeyboardVisibilityBuilder(
                builder: (context, isKeyboardVisible) => Padding(
                  padding: EdgeInsets.only(
                      bottom: isKeyboardVisible
                          ? MediaQuery.of(context).viewInsets.bottom
                          : 0),
                  child: TextField(
                    autofocus: true,
                    controller: controller,
                    keyboardType: TextInputType.multiline,
                    textInputAction: TextInputAction.newline,
                    maxLines: 4,
                    minLines: 1,
                    scrollPadding: EdgeInsets.zero,
                    onChanged: onChange,
                    decoration: InputDecoration(
                      filled: true,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      hintStyle:
                          Theme.of(context).textTheme.labelMedium!.copyWith(
                                color: ColorPalette.of(context)
                                    .textPrimary
                                    .withOpacity(0.5),
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
                        onTap: commentEmpty ? null : sendComment,
                        child: Container(
                          width: 40,
                          height: 40,
                          margin: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: commentEmpty || loading
                                ? ColorPalette.of(context)
                                    .textPrimary
                                    .withOpacity(0.2)
                                : ColorPalette.of(context).primary,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: loading
                                ? SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                      color: ColorPalette.of(context).primary,
                                      strokeWidth: 2,
                                    ),
                                  )
                                : Icon(
                                    Icons.arrow_upward_rounded,
                                    color: ColorPalette.of(context).white,
                                  ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}
