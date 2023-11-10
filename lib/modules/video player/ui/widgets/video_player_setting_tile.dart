import 'package:flutter/material.dart';

class VideoPlayerSettingTile extends StatelessWidget {
  const VideoPlayerSettingTile({
    required this.icon,
    required this.title,
    this.optionWidget,
    super.key,
  });

  final IconData icon;
  final String title;
  final Widget? optionWidget;

  @override
  Widget build(BuildContext context) => SizedBox(
        height: 40,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  icon,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ),
                
              ],
            ),
            optionWidget ?? const SizedBox(),
          ],
        ),
      );
}
