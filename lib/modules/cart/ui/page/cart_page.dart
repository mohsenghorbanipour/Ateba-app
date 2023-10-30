import 'package:ateba_app/core/components/button_component.dart';
import 'package:ateba_app/core/theme/style/color_palatte.dart';
import 'package:ateba_app/modules/cart/bloc/cart_bloc.dart';
import 'package:ateba_app/modules/cart/data/models/order.dart';
import 'package:ateba_app/modules/cart/ui/widgets/cart_discount_widget.dart';
import 'package:ateba_app/modules/cart/ui/widgets/order_card.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: ColorPalette.of(context).scaffoldBackground,
        body: Stack(
          children: [
            ListView(
              physics: const BouncingScrollPhysics(),
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
                          'cart'.tr(),
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Consumer<CartBloc>(
                  builder: (context, bloc, child) => ListView.separated(
                    padding: const EdgeInsets.fromLTRB(16, 20, 16, 120),
                    physics: const NeverScrollableScrollPhysics(),
                    separatorBuilder: (_, __) => const SizedBox(
                      height: 12,
                    ),
                    shrinkWrap: true,
                    itemCount: bloc.ordersResponse?.orders?.length ?? 0,
                    itemBuilder: (context, index) => OrderCard(
                      order: bloc.ordersResponse?.orders?[index] ?? Order(),
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              left: 16,
              right: 16,
              bottom: 28,
              child: Column(
                children: [
                  const CartDiscountWidget(),
                  const SizedBox(
                    height: 24,
                  ),
                  ButtonComponent(
                    onPressed: () {
                      if (Provider.of<CartBloc>(context, listen: false)
                              .ordersResponse !=
                          null) {
                        Provider.of<CartBloc>(context, listen: false).payment();
                      }
                    },
                    loading: context
                        .select<CartBloc, bool>((bloc) => bloc.paymentLoading),
                    height: 40,
                    child: Text(
                      'payment'.tr(),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      );
}
