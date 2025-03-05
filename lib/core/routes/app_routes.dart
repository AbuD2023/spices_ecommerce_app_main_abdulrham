import 'package:flutter/material.dart';
import 'package:spices_ecommerce_app_main_abdulrham/views/Auth/login_page.dart';
import 'package:spices_ecommerce_app_main_abdulrham/views/Auth/sign_up_page.dart';
import 'package:spices_ecommerce_app_main_abdulrham/views/entrypoint/entrypoint_ui.dart';
import 'package:spices_ecommerce_app_main_abdulrham/views/order/orders_current_page.dart';
import 'package:spices_ecommerce_app_main_abdulrham/views/order/orders_history_page.dart';
import 'package:spices_ecommerce_app_main_abdulrham/views/profile/notification_page.dart';
import 'package:spices_ecommerce_app_main_abdulrham/views/profile/profile_edit_page.dart';
import 'package:spices_ecommerce_app_main_abdulrham/views/profile/profile_page.dart';

class AppRoutes {
  static const String initial = '/';

  static const String home = '/home';

  static const String orders = '/orders';
  static const String ordersHistory = '/orders_history';
  static const String currentOrder = '/current_order';

  static const String profile = '/profile';
  static const String profileEdit = '/profileEdit';
  static const String notifications = '/notifications';

  static const String login = '/login';

  static const String signup = '/signup';

  static const String forgotPassword = '/forgot_password';
  static const String resetPassword = '/reset_password';

  /* <---- ENTRYPOINT -----> */
  static const entryPoint = '/entry_point';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    return MaterialPageRoute(
        builder: (context) => _routeGuard(context, settings));
  }

  static Widget _routeGuard(BuildContext context, RouteSettings settings) {
    switch (settings.name) {
      case notifications:
        return const NotificationPage();
      case profile:
        return const ProfilePage();
      case profileEdit:
        return const ProfileEditPage();
      case currentOrder:
        return const OrderCurrentPage();
      case ordersHistory:
        return const OrderHistoryPage();
      case entryPoint:
        return const EntryPointUI();
      case login:
        return const LoginPage();
      case signup:
        return const SignUpPage();
      default:
        return const EntryPointUI();
    }
  }
}
