import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_dataon/pages/change_password/change_password_page.dart';
import 'package:test_dataon/pages/change_password/change_password_view_model.dart';
import 'package:test_dataon/pages/login/login_page.dart';
import 'package:test_dataon/pages/login/login_view_model.dart';
import 'package:test_dataon/pages/navigation_page/navigation_page.dart';
import 'package:test_dataon/pages/navigation_page/navigation_view_model.dart';
import 'package:test_dataon/pages/register/register_page.dart';
import 'package:test_dataon/pages/register/register_view_model.dart';
import 'package:test_dataon/pages/welcome_page/welcome_page.dart';

import '../pages/home_page/home_view_model.dart';

class Routes {
  Route route(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (context) => const WelcomePage(),
        );
      case '/register':
        return MaterialPageRoute(
          builder: (context) => ChangeNotifierProvider(
            create: (context) => RegisterViewModel(),
            child: const RegisterPage(),
          ),
        );
      case '/login':
        return MaterialPageRoute(
          builder: (context) => ChangeNotifierProvider(
            create: (context) => LoginViewModel(),
            child: const LoginPage(),
          ),
        );
      case '/navigation':
        return MaterialPageRoute(
          builder: (context) => MultiProvider(
            providers: [
              ChangeNotifierProvider(
                  create: (context) => NavigationViewModel()),
              ChangeNotifierProvider(
                create: (context) => HomeViewModel(),
              ),
            ],
            child: const NavigationPage(),
          ),
        );
      case '/changePassword':
        return MaterialPageRoute(
          builder: (context) => ChangeNotifierProvider(
            create: (context) => ChangePasswordViewModel(),
            child: ChangePasswordPage(),
          ),
        );
      default:
        return MaterialPageRoute(
          builder: (context) => const Scaffold(),
        );
    }
  }
}
