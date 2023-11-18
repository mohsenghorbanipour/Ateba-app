import 'package:ateba_app/core/theme/style/color_palatte.dart';
import 'package:flutter/material.dart';

class InputComponent extends StatelessWidget {
  const InputComponent({
    required this.labelText,
    required this.onTap,
    this.margin = EdgeInsets.zero,
    this.hintText,
    this.value,
    super.key,
  });

  final String labelText;
  final EdgeInsets margin;
  final String? hintText;
  final Function() onTap;
  final String? value;

  @override
  Widget build(BuildContext context) => Padding(
        padding: margin,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.only(
                      top: 4, start: 4, bottom: 8),
                  child: Text(
                    labelText,
                    style: Theme.of(context).textTheme.labelLarge,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            InkWell(
              onTap: onTap,
              child: Container(
                height: 48,
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: ColorPalette.of(context).background,
                  border: Border.all(
                    width: 1,
                    color: ColorPalette.of(context).border,
                  ),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      value ?? hintText ?? '',
                      style: Theme.of(context).textTheme.labelMedium!.copyWith(
                            color: value?.isNotEmpty ?? false
                                ? null
                                : ColorPalette.of(context)
                                    .textPrimary
                                    .withOpacity(0.5),
                          ),
                    ),
                    const Icon(
                      Icons.keyboard_arrow_down_rounded,
                      size: 24,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      );
}
