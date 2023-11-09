import 'dart:io';

import 'package:ateba_app/core/router/routes.dart';
import 'package:ateba_app/modules/auth/ui/page/login_otp_page.dart';
import 'package:ateba_app/modules/auth/ui/page/login_page.dart';
import 'package:ateba_app/modules/auth/ui/page/splash_page.dart';
import 'package:ateba_app/modules/cart/ui/page/cart_page.dart';
import 'package:ateba_app/modules/categories/data/models/category.dart'
    as category;
import 'package:ateba_app/modules/course%20details/ui/page/course_details_page.dart';
import 'package:ateba_app/modules/edit%20profile/ui/page/edit_profile_page.dart';
import 'package:ateba_app/modules/main/ui/page/main_page.dart';
import 'package:ateba_app/modules/package%20details/ui/page/package_details_page.dart';
import 'package:ateba_app/modules/subscription/ui/page/subscription_page.dart';
import 'package:ateba_app/modules/transactions/ui/page/transactions_page.dart';
import 'package:ateba_app/modules/tutorial%20details/ui/page/tutorial_details_page.dart';
import 'package:ateba_app/modules/category%20details/ui/page/category_details_page.dart';
import 'package:ateba_app/modules/video%20player/ui/page/video_player_page.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:video_player/video_player.dart';

class AtebaRouter {
  late GoRouter router = GoRouter(
    debugLogDiagnostics: true,
    initialLocation: Routes.splash,
    observers: <NavigatorObserver>[
      BotToastNavigatorObserver(),
    ],

    // urlPathStrategy: UrlPathStrategy.path,
    // errorPageBuilder: (context, state) => MaterialPage<void>(
    //   key: state.pageKey,
    //   restorationId: state.pageKey.value,
    //   child: const CustomErrorWidget(),
    // ),

    routes: <GoRoute>[
      _routeFade(
        path: Routes.splash,
        name: Routes.splash,
        pageBuilder: (state) => const SplashPage(),
      ),
      _routeFade(
        path: Routes.login,
        name: Routes.login,
        pageBuilder: (state) => const LoginPage(),
        routes: [
          _routeFade(
            path: Routes.loginOtp,
            name: Routes.loginOtp,
            pageBuilder: (state) => const LoginOtpPage(),
            routes: [
              _routeFade(
                path: Routes.completeInfo,
                name: Routes.completeInfo,
                pageBuilder: (state) => EditProfilePage(
                  isEditProfile: (state.extra as bool?) ?? false,
                ),
              ),
            ],
          ),
        ],
      ),
      _routeFade(
        path: Routes.main,
        name: Routes.main,
        pageBuilder: (state) => const MainPage(),
        routes: [
          _routeFade(
            path: Routes.tutorialDetails,
            name: Routes.tutorialDetails,
            pageBuilder: (state) => TutorialDetailsPage(
              slug: state.pathParameters['slug'] as String,
            ),
            routes: [
              _routeFade(
                path: Routes.subscriptions,
                name: Routes.subscriptions,
                pageBuilder: (state) => const SubscriptionPage(),
              ),
              _routeFade(
                path: Routes.videoPlayer,
                name: Routes.videoPlayer,
                pageBuilder: (state) => VideoPlayerPage(
                  data: state.extra as Map<String, dynamic>,
                ),
              )
            ],
          ),
          _routeFade(
            path: Routes.courseDetails,
            name: Routes.courseDetails,
            pageBuilder: (state) => CourseDetailsPage(
              slug: state.pathParameters['slug'] as String,
            ),
            routes: [
              _routeFade(
                path: Routes.courseTutorialDetails,
                name: Routes.courseTutorialDetails,
                pageBuilder: (state) => TutorialDetailsPage(
                  slug: state.pathParameters['link'] as String,
                ),
                routes: [
                  // _routeFade(
                  //   path: Routes.videoPalyer,
                  //   name: Routes.videoPalyer,
                  //   pageBuilder: (state) => VideoPlayerPage(
                  //     controller: state.extra as VideoPlayerController,
                  //   ),
                  // )
                ],
              ),
            ],
          ),
          _routeFade(
              path: Routes.packageDetails,
              name: Routes.packageDetails,
              pageBuilder: (state) => PackageDetailsPage(
                    slug: state.pathParameters['slug'] as String,
                  ),
              routes: [
                _routeFade(
                  path: Routes.packageVideoPlayer,
                  name: Routes.packageVideoPlayer,
                  pageBuilder: (state) => VideoPlayerPage(
                    data: state.extra as Map<String, dynamic>,
                  ),
                )
              ]),
          _routeFade(
            path: Routes.cart,
            name: Routes.cart,
            pageBuilder: (state) => const CartPage(),
          ),
          _routeFade(
            path: Routes.subscription,
            name: Routes.subscription,
            pageBuilder: (state) => const SubscriptionPage(),
          ),
          _routeFade(
              path: Routes.categoryDetials,
              name: Routes.categoryDetials,
              pageBuilder: (state) => CategoryDetailsPage(
                    slug: state.pathParameters['slug'] as String,
                    category: state.extra as category.Category,
                  ),
              routes: [
                _routeFade(
                  path: Routes.categoryTutorialsDetials,
                  name: Routes.categoryTutorialsDetials,
                  pageBuilder: (state) => TutorialDetailsPage(
                    slug: state.pathParameters['path'] as String,
                  ),
                  routes: [
                    // _routeFade(
                    //   path: Routes.videoPalyer,
                    //   name: Routes.videoPalyer,
                    //   pageBuilder: (state) => VideoPlayerPage(
                    //     controller: state.extra as VideoPlayerController,
                    //   ),
                    // )
                  ],
                ),
              ]),
          _routeFade(
            path: Routes.mainPagevideoPlayer,
            name: Routes.mainPagevideoPlayer,
            pageBuilder: (state) => VideoPlayerPage(
              data: state.extra as Map<String, dynamic>,
            ),
          ),
          _routeFade(
            path: Routes.transactions,
            name: Routes.transactions,
            pageBuilder: (state) => const TransactionsPage(),
          ),
          _routeFade(
            path: Routes.editProfile,
            name: Routes.editProfile,
            pageBuilder: (state) => EditProfilePage(
              isEditProfile: (state.extra as bool?) ?? false,
            ),
          ),
        ],
      )
    ],
  );

  GoRoute _routeFade(
          {required String path,
          required String name,
          required Widget Function(GoRouterState state) pageBuilder,
          List<GoRoute> routes = const []}) =>
      GoRoute(
        path: path,
        name: name,
        routes: routes,
        pageBuilder: (context, state) => (!kIsWeb && Platform.isIOS)
            ? CupertinoPage<void>(
                key: state.pageKey,
                restorationId: state.pageKey.value,
                child: pageBuilder(state),
              )
            : CustomTransitionPage<void>(
                key: state.pageKey,
                child: pageBuilder(state),
                restorationId: state.pageKey.value,
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) =>
                        FadeTransition(opacity: animation, child: child),
              ),
      );
}

// }
