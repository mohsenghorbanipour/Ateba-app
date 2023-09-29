import 'package:ateba_app/core/resources/assets/assets.dart';
import 'package:ateba_app/core/theme/style/color_palatte.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class LessonCard extends StatelessWidget {
  const LessonCard({super.key});

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: ColorPalette.of(context).background,
          border: Border.all(
            width: 1,
            color: ColorPalette.of(context).border,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 94,
              height: 56,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3),
                image: const DecorationImage(
                    image: CachedNetworkImageProvider(
                      'https://s3-alpha-sig.figma.com/img/9f11/3eb4/2e1fa765d7a50a8458f59f477f323cc1?Expires=1693785600&Signature=LkLjHLXLhRscmuTvpy9TeAii4H9fClL8WzTOKrmrf8RX6QI9Tu63bU9h9lXLuQSavpswreIUgRG3SLoQVuyNE6mwPDt-cpZuEzCyORCGer37ZKCnfIfkiQ1sJp1oXDuhc0qd6oqT-3Kjyx9v19sfPngnO3aH5Yf4fW2j3zbQ7APJv1lCUZa9rLvUxWwWnnL-SwP7TdH3XWhPC2zv6lGvmBgj-BV5Klg-4bqWpbiD0tUc0dDjG0iTEVc14M0jVUm5EEAiQaYjcllpShFsievDL6KCsQygHuWaKL~e6riXO6kW8ONQh2QaEhK0lmCSlQGOBEV2-EBD2Z3HR9XaG3oamQ__&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4',
                    ),
                    fit: BoxFit.cover),
              ),
              child: Center(
                child: Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: ColorPalette.of(context).error,
                  ),
                  child: Center(
                    child: Icon(
                      Icons.play_arrow_rounded,
                      color: ColorPalette.of(context).white,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      );
}
