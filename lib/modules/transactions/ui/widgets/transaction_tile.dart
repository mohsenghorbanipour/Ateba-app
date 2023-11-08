import 'package:ateba_app/core/utils/date_helper.dart';
import 'package:ateba_app/core/utils/text_input_formatters.dart';
import 'package:ateba_app/modules/transactions/data/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:ateba_app/core/utils/price_ext.dart';

class TrasactionTile extends StatelessWidget {
  const TrasactionTile({
    required this.transaction,
    super.key,
  });

  final Transaction transaction;

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        height: 40,
        child: Row(
          children: [
            Expanded(
              child: Text(
                transaction.title ?? '',
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.labelMedium,
              ),
            ),
            const SizedBox(
              width: 6,
            ),
            Expanded(
              child: Text(
                TextInputFormatters.toPersianNumber(
                  DateHelper.getShamsiData(
                    transaction.created_at ?? '',
                    withDay: true,
                  ),
                ),
                style: Theme.of(context).textTheme.labelMedium,
              ),
            ),
            const SizedBox(
              width: 6,
            ),
            Expanded(
              child: Text(
                transaction.price?.withPriceLable ?? '',
                style: Theme.of(context).textTheme.labelMedium,
              ),
            ),
          ],
        ),
      );
}
