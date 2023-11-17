import 'package:ateba_app/core/theme/style/color_palatte.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class SelectGenderInput extends StatelessWidget {
  const SelectGenderInput({
    required this.maleTap,
    required this.feMaleTap,
    this.isMale = true,
    super.key,
  });

  final Function() maleTap;
  final Function() feMaleTap;
  final bool isMale;

  @override
  Widget build(BuildContext context) => Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.only(
                    top: 4, start: 4, bottom: 8),
                child: Text(
                  'gender'.tr(),
                  style: Theme.of(context).textTheme.labelLarge,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          Row(
            children: [
              InkWell(
                onTap: maleTap,
                child: Row(
                  children: [
                    Container(
                      width: 14,
                      height: 14,
                      margin: const EdgeInsets.only(left: 6),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          width: 1.2,
                          color: ColorPalette.of(context).primary,
                        ),
                      ),
                      child: isMale
                          ? Center(
                              child: Container(
                                width: 6,
                                height: 6,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: ColorPalette.of(context).error),
                              ),
                            )
                          : null,
                    ),
                    Text(
                      'male'.tr(),
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 48,
              ),
              InkWell(
                onTap: feMaleTap,
                child: Row(
                  children: [
                    Container(
                      width: 14,
                      height: 14,
                      margin: const EdgeInsets.only(left: 6),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          width: 1.2,
                          color: ColorPalette.of(context).primary,
                        ),
                      ),
                      child: !isMale
                          ? Center(
                              child: Container(
                                width: 6,
                                height: 6,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: ColorPalette.of(context).error),
                              ),
                            )
                          : null,
                    ),
                    Text(
                      'female'.tr(),
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      );
}
