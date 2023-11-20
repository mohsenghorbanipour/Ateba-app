import 'package:ateba_app/core/components/shimmer_components.dart';
import 'package:ateba_app/core/resources/assets/assets.dart';
import 'package:ateba_app/core/theme/style/color_palatte.dart';
import 'package:ateba_app/core/utils/date_helper.dart';
import 'package:ateba_app/core/utils/text_input_formatters.dart';
import 'package:ateba_app/modules/cart/bloc/cart_bloc.dart';
import 'package:ateba_app/modules/cart/data/models/order.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class OrderCard extends StatelessWidget {
  const OrderCard({
    required this.order,
    super.key,
  });

  final Order order;

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: ColorPalette.of(context).background,
          border: Border.all(
            width: 1,
            color: ColorPalette.of(context).border,
          ),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: CachedNetworkImage(
                imageUrl: order.thumbnail_url ?? '',
                width: 64,
                height: 64,
                placeholder: (_, __) => const ShimmerContainer(
                  width: 64,
                  height: 64,
                  radius: 4,
                ),
              ),
            ),
            const SizedBox(
              width: 12,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    order.title ?? '',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      SvgPicture.asset(
                        Assets.refreshIc,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 4),
                        child: Text(
                          DateHelper.getDistanceWithToday(
                            order.updated_at ?? '',
                          ),
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                      ),
                      if (order.duration?.isNotEmpty ?? false)
                        Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                Assets.clockFillIc,
                                color: ColorPalette.of(context).error,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 4),
                                child: Text(
                                  TextInputFormatters.toPersianNumber(
                                    order.duration ?? '',
                                  ),
                                  style: Theme.of(context).textTheme.labelSmall,
                                ),
                              ),
                            ],
                          ),
                        )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        '${TextInputFormatters.toPersianNumber(
                          order.price.toString(),
                        )} ',
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      Text(
                        'toman'.tr(),
                        style: Theme.of(context).textTheme.labelMedium,
                      )
                    ],
                  )
                ],
              ),
            ),
            InkWell(
              onTap: () {
                Provider.of<CartBloc>(context, listen: false).deleteOrder(
                  order.id ?? '',
                );
              },
              child: SvgPicture.asset(
                Assets.closeIc,
                width: 18,
                height: 18,
              ),
            )
          ],
        ),
      );
}
