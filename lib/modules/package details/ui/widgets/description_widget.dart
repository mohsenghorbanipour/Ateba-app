import 'package:ateba_app/core/theme/style/color_palatte.dart';
import 'package:flutter/material.dart';

class DescriptionWidget extends StatelessWidget {
  const DescriptionWidget({super.key});

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 48, 16, 8),
            child: Text(
              'خلاصه ای از پکیج اورولوژی',
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 18, left: 16),
            child: Text(
              'این پکیج منسجم و هدفمند  که مفاهیم آن کاملا قابل درک است و شامل نکته های پرتکرار و سوال خیز آزمون است این پکیج منسجم و هدفمند  که مفاهیم آن کاملا قابل درک است و شامل نکته های پرتکرار و سوال خیز آزمون است میباشد.',
              style: Theme.of(context).textTheme.labelMedium,
              textAlign: TextAlign.justify,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 48, bottom: 24, left: 16),
            child: Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 16, left: 4),
                  width: 4,
                  height: 4,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: ColorPalette.of(context).error,
                  ),
                ),
                Expanded(
                  child: Text(
                    'طبق آخرین رفرنس های اعلامی از وزارت بهداشت می باشد.',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                ),
              ],
            ),
          ),
          
        ],
      );
}
