import 'package:ateba_app/core/components/shimmer_components.dart';
import 'package:ateba_app/core/theme/style/color_palatte.dart';
import 'package:ateba_app/modules/transactions/bloc/transactions_bloc.dart';
import 'package:ateba_app/modules/transactions/data/models/transaction.dart';
import 'package:ateba_app/modules/transactions/ui/widgets/transaction_tile.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TransactionsPage extends StatelessWidget {
  const TransactionsPage({super.key});

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => TransactionsBloc()..loadTransaction(),
        lazy: false,
        builder: (context, child) => Scaffold(
          backgroundColor: ColorPalette.of(context).scaffoldBackground,
          body: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 24),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        width: 32,
                        height: 32,
                        margin: const EdgeInsets.only(right: 16),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: ColorPalette.of(context).background,
                          border: Border.all(
                            width: 1,
                            color: ColorPalette.of(context).border,
                          ),
                        ),
                        child: Icon(
                          Icons.arrow_back_ios_rounded,
                          size: 16,
                          color: ColorPalette.of(context).primary,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 6),
                      child: Text(
                        'purchase_history'.tr(),
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                margin:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
                decoration: BoxDecoration(
                  color: ColorPalette.of(context).white,
                  border: Border.all(
                    width: 1,
                    color: ColorPalette.of(context).border,
                  ),
                  borderRadius: BorderRadius.circular(
                    6,
                  ),
                ),
                child: context
                        .select<TransactionsBloc, bool>((bloc) => bloc.loading)
                    ? const ShimmerContainer(
                        width: double.infinity,
                        height: 250,
                      )
                    : Selector<TransactionsBloc, List<Transaction>>(
                        selector: (context, bloc) => bloc.transactions,
                        builder: (context, transactions, child) =>
                            ListView.separated(
                          itemCount: transactions.length + 1,
                          shrinkWrap: true,
                          separatorBuilder: (_, index) => index == 0
                              ? const SizedBox()
                              : Divider(
                                  color: ColorPalette.of(context).border,
                                  indent: 16,
                                  endIndent: 16,
                                  height: 1,
                                ),
                          itemBuilder: (context, index) => index == 0
                              ? Container(
                                  height: 35,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12),
                                  decoration: BoxDecoration(
                                    color: ColorPalette.of(context)
                                        .scaffoldBackground,
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(6),
                                      topRight: Radius.circular(6),
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          'title_buy'.tr(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 6,
                                      ),
                                      Expanded(
                                        child: Text(
                                          'time_payment'.tr(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 6,
                                      ),
                                      Expanded(
                                        child: Text(
                                          'amount'.tr(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall,
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              : TrasactionTile(
                                  transaction: transactions[index - 1],
                                ),
                        ),
                      ),
              )
            ],
          ),
        ),
      );
}
