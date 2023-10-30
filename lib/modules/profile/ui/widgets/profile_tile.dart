import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ProfileTile extends StatelessWidget {
  const ProfileTile({
    required this.title,
    required this.icon,
    required this.onTap,
    super.key,
  });

  final String title;
  final String icon;
  final Function() onTap;

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SvgPicture.asset(
                    icon,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 4),
                    child: Text(
                      title.tr(),
                    ),
                  ),
                ],
              ),
              const Icon(
                Icons.arrow_back_ios_new_rounded,
                size: 16,
              )
            ],
          ),
        ),
      );
}
