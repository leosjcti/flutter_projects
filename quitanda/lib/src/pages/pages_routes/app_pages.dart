import 'package:get/get.dart';
import 'package:quitanda/src/pages/auth/view/sign_in_screen.dart';
import 'package:quitanda/src/pages/auth/view/sign_up_screen.dart';
import 'package:quitanda/src/pages/base/base_screen.dart';

import '../splash/splash_screen.dart';

abstract class AppPages {

  static final pages = <GetPage>[
    GetPage(name: PagesRoutes.splashRoute, page: () => const SplashScreen()),
    GetPage(name: PagesRoutes.signInRoutes, page: () => SignInScreen()),
    GetPage(name: PagesRoutes.signUpRoutes, page: () => SignUpScreen()),
    GetPage(name: PagesRoutes.baseRoute, page: () => BaseScreen()),
  ];
}


abstract class PagesRoutes {
  static const String signInRoutes = '/signin';
  static const String signUpRoutes = '/signup';
  static const String splashRoute = '/splash';
  static const String baseRoute = '/';
}