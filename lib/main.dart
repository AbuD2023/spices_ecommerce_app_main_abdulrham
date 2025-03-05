import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:spices_ecommerce_app_main_abdulrham/Providers/auth/auth_controller.dart';
import 'package:spices_ecommerce_app_main_abdulrham/Providers/order_provider.dart';
import 'package:spices_ecommerce_app_main_abdulrham/Providers/profile_provider.dart';
import 'package:spices_ecommerce_app_main_abdulrham/core/services/auth_service.dart';
import 'package:spices_ecommerce_app_main_abdulrham/core/themes/app_themes.dart';
import 'core/routes/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final AuthService authService = AuthService();
  final token = await authService.getToken();
  log('token: $token');
  runApp(MyApp(token: token));
}

class MyApp extends StatelessWidget {
  final String? token;
  const MyApp({super.key, required this.token});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        if (token != null)
          ChangeNotifierProvider(
            create: (_) => OrderProvider()
              ..fetchCurrentOrders()
              ..fetchHistoryOrders(),
          ),
        if (token == null)
          ChangeNotifierProvider(create: (_) => OrderProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        if (token != null)
          ChangeNotifierProvider(
            create: (_) => ProfileProvider()..fetchDriverProfile(),
          ),
        if (token == null)
          ChangeNotifierProvider(create: (_) => ProfileProvider()),
      ],
      child: GetMaterialApp(
        title: 'Spices Ecommerce',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.defaultTheme,
        // initialRoute: AppRoutes.entryPoint,
        initialRoute: token != null ? AppRoutes.entryPoint : AppRoutes.login,
        onGenerateRoute: AppRoutes.generateRoute,
        // getPages: AppRoutes.routes,
      ),
    );
  }
}
