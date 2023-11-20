import 'package:ateba_app/core/components/shimmer_components.dart';
import 'package:ateba_app/core/theme/style/color_palatte.dart';
import 'package:ateba_app/modules/notifications/bloc/notification_bloc.dart';
import 'package:ateba_app/modules/notifications/ui/widgets/notification_card.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:provider/provider.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => NotificationBloc()..loadNotifications(),
        lazy: false,
        builder: (context, child) => Scaffold(
          backgroundColor: ColorPalette.of(context).scaffoldBackground,
          body: LazyLoadScrollView(
            onEndOfPage: () async {
              if (Provider.of<NotificationBloc>(context, listen: false)
                  .canLoadMore) {
                await Provider.of<NotificationBloc>(context, listen: false)
                    .loadMoreNotifications();
              }
            },
            isLoading: context
                .select<NotificationBloc, bool>((bloc) => bloc.loadingMore),
            child: RefreshIndicator(
              color: ColorPalette.of(context).primary,
              onRefresh: () async {
                await Provider.of<NotificationBloc>(context, listen: false)
                    .loadNotifications();
              },
              child: ListView(
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
                            'notifications'.tr(),
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  Consumer<NotificationBloc>(
                    builder: (context, bloc, child) => bloc.loading
                        ? ListView.separated(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: 5,
                            shrinkWrap: true,
                            itemBuilder: (_, __) => const ShimmerContainer(
                              radius: 6,
                              width: double.infinity,
                              height: 90,
                            ),
                            separatorBuilder: (_, __) => const SizedBox(
                              height: 12,
                            ),
                          )
                        : ListView.separated(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: bloc.notifications.length,
                            shrinkWrap: true,
                            itemBuilder: (_, index) => NotificationCard(
                              notification: bloc.notifications[index],
                            ),
                            separatorBuilder: (_, __) => const SizedBox(
                              height: 12,
                            ),
                          ),
                  )
                ],
              ),
            ),
          ),
        ),
      );
}
