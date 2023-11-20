import 'package:ateba_app/core/theme/style/color_palatte.dart';
import 'package:ateba_app/core/utils/date_helper.dart';
import 'package:ateba_app/modules/notifications/data/models/notification.dart'
    as notif;
import 'package:flutter/material.dart';

class NotificationCard extends StatelessWidget {
  const NotificationCard({
    required this.notification,
    super.key,
  });

  final notif.Notification notification;

  @override
  Widget build(BuildContext context) => Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: ColorPalette.of(context).background,
          border: Border.all(
            width: 1,
            color: ColorPalette.of(context).border,
          ),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  notification.title ?? '',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                Text(
                  DateHelper.getDistanceWithToday(
                      notification.created_at ?? ''),
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: ColorPalette.of(context)
                          .textPrimary
                          .withOpacity(0.8)),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                notification.text ?? '',
                style: Theme.of(context).textTheme.labelLarge,
              ),
            )
          ],
        ),
      );
}
