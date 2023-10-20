import 'dart:io';

import 'package:ateba_app/core/router/routes.dart';
import 'package:ateba_app/modules/auth/ui/page/login_otp_page.dart';
import 'package:ateba_app/modules/auth/ui/page/login_page.dart';
import 'package:ateba_app/modules/auth/ui/page/splash_page.dart';
import 'package:ateba_app/modules/auth/ui/page/user_information_page.dart';
import 'package:ateba_app/modules/course%20details/ui/page/course_details_page.dart';
import 'package:ateba_app/modules/main/ui/page/main_page.dart';
import 'package:ateba_app/modules/package%20details/ui/page/package_details_page.dart';
import 'package:ateba_app/modules/tutorial%20details/ui/page/tutorial_details_page.dart';
import 'package:ateba_app/modules/video%20player/ui/page/video_player_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:video_player/video_player.dart';

class AtebaRouter {
  late GoRouter router = GoRouter(
    debugLogDiagnostics: true,
    initialLocation: Routes.splash,

    // observers: <NavigatorObserver>[BotToastNavigatorObserver()],
    // urlPathStrategy: UrlPathStrategy.path,
    // errorPageBuilder: (context, state) => MaterialPage<void>(
    //   key: state.pageKey,
    //   restorationId: state.pageKey.value,
    //   child: const CustomErrorWidget(),
    // ),

    routes: <GoRoute>[
      _route(
        path: Routes.splash,
        name: Routes.splash,
        pageBuilder: (state) => const SplashPage(),
      ),
      _route(
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
                path: Routes.userInfo,
                name: Routes.userInfo,
                pageBuilder: (state) => const UserInformationPage(),
              ),
            ],
          ),
        ],
      ),
      _route(
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
                path: Routes.videoPalyer,
                name: Routes.videoPalyer,
                pageBuilder: (state) => VideoPlayerPage(
                  controller: state.extra as VideoPlayerController,
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
                path: Routes.tutorialsDetails,
                name: Routes.tutorialsDetails,
                pageBuilder: (state) => TutorialDetailsPage(
                  slug: state.pathParameters['link'] as String,
                ),
                // routes: [
                //   _routeFade(
                //     path: Routes.videoPalyer,
                //     name: Routes.videoPalyer,
                //     pageBuilder: (state) => VideoPlayerPage(
                //       controller: state.extra as VideoPlayerController,
                //     ),
                //   )
                // ],
              ),
            ],
          ),
          _routeFade(
            path: Routes.packageDetails,
            name: Routes.packageDetails,
            pageBuilder: (state) => PackageDetailsPage(
              slug: state.pathParameters['slug'] as String,
            ),
          ),
        ],
      )
      //! bottom navigations
      // _route(path: Routes.main, pageBuilder: (state) => const MainPage()),
      // _route(path: Routes.orders, pageBuilder: (state) => OrdersPage()),
      // _route(path: Routes.search, pageBuilder: (state) => const SearchPage()),
      // _route(
      //     path: Routes.profilePage,
      //     pageBuilder: (state) => const ProfilePage()),

      // //! Home
      // _route(
      //     path: Routes.storePage,
      //     pageBuilder: (state) => StorePage(
      //           storeType:
      //               state.extra != null ? (state.extra as StoreType?)! : null,
      //         )),
      // //! profile
      // _route(
      //     path: Routes.personalInfoPage,
      //     pageBuilder: (state) => const PersonalInfoPage()),
      // _route(path: Routes.addressPage, pageBuilder: (state) => AddressPage()),
      // _route(path: Routes.commentsPage, pageBuilder: (state) => CommentsPage()),
      // _route(
      //     path: Routes.creditCyclePage,
      //     pageBuilder: (state) => const CreditCyclePage()),
      // _route(path: Routes.favoritePage, pageBuilder: (state) => FavoritePage()),
      // _route(
      //     path: Routes.contactUsPage,
      //     pageBuilder: (state) => const ContactUsPage()),
      // _route(
      //     path: Routes.frequentlyAskedQuestionPage,
      //     pageBuilder: (state) => const FrequentlyAskedQuestionPage()),
      // //! more
      // _route(
      //     path: Routes.moreStoresPage,
      //     pageBuilder: (state) => const StoreMorePage()),
      // _route(
      //     path: Routes.moreProductsPage,
      //     pageBuilder: (state) => const ProductsMorePage()),
      // //! map
      // _route(path: Routes.mapPage, pageBuilder: (state) => const MapsPage()),
      // _route(
      //     path: Routes.newAddress,
      //     pageBuilder: (state) => const NewAddressPage()),
      // _route(
      //   path: Routes.editAddressPage,
      //   pageBuilder: (state) => EditAddressPage(
      //       address: state.extra != null ? (state.extra as Address?)! : null),
      // ),

      // _route(
      //     path: Routes.orderDetailsPage,
      //     pageBuilder: (state) => OrderDetailPage()),
      // //! info and comments EXTRA
      // _route(
      //   path: Routes.infoAndComments,
      //   pageBuilder: (state) => const InformationAndCommentsPage(),
      // ),
    ],
  );

  GoRoute _route(
          {required String path,
          required String name,
          required Widget Function(GoRouterState state) pageBuilder,
          List<GoRoute> routes = const []}) =>
      GoRoute(
        path: path,
        name: name,
        routes: routes,
        pageBuilder: (BuildContext context, GoRouterState state) =>
            (!kIsWeb && Platform.isIOS)
                ? CupertinoPage<void>(
                    key: state.pageKey,
                    restorationId: state.pageKey.value,
                    child: pageBuilder(state),
                  )
                : MaterialPage<void>(
                    key: state.pageKey,
                    restorationId: state.pageKey.value,
                    child: pageBuilder(state),
                  ),
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
                        SlideTransition(
                  position: animation.drive(
                    Tween<Offset>(
                      begin: const Offset(1, 0),
                      end: Offset.zero,
                    ).chain(CurveTween(curve: Curves.easeIn)),
                  ),
                  child: child,
                ),
              ),
      );
}

// }
