import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:thegreengrocer/src/auth/view/sign_in_screen.dart';
import 'package:thegreengrocer/src/auth/view/sign_up_screen.dart';
import 'package:thegreengrocer/src/auth/pages/splash/splash_screen.dart';

import '../pages/base/base_screen.dart';


//gerencia minhas rotas
abstract class AppPage {
  static final pages = <GetPage>[
    GetPage(
      name: PagesRoutes.splashRoute,
      page: () => const SplashScreen(),
    ),
    GetPage(
      name: PagesRoutes.signInRoute,
      page: () =>  SignInScreen(),
    ),
    GetPage(
      name: PagesRoutes.signUpRoute,
      page: () => SignUpScreen(),
    ),
    GetPage(
      name: PagesRoutes.baseRoute,
      page: () => const BaseScreen(),
    ),
  ];
}

//minhas rotas nomeadas
abstract class PagesRoutes{

  static const String signInRoute = "/signin";
  static const String signUpRoute = "/signup";
  static const String splashRoute = "/splash";
  static const String baseRoute = "/"; // somente a "/" por ser nossa pagina base
}
