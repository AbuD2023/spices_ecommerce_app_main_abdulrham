import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:spices_ecommerce_app_main_abdulrham/core/routes/app_routes.dart';
import 'package:spices_ecommerce_app_main_abdulrham/data/model/driver.dart';
import 'package:spices_ecommerce_app_main_abdulrham/linkapi.dart';

import '../../core/services/auth_service.dart';
import '../../core/services/notification_service.dart';

class AuthProvider extends ChangeNotifier {
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final AuthService authService = AuthService();
  final NotificationService notificationService = NotificationService();
  LoginDriverData _loginDriverData = LoginDriverData();

  bool _isLoading = false;
  bool _isPasswordShown = false;

  // Getr
  bool get isLoading => _isLoading;
  bool get isPasswordShown => _isPasswordShown;

  LoginDriverData get loginDriverData => _loginDriverData;

  void togglePasswordVisibility() {
    _isPasswordShown = !_isPasswordShown;
    notifyListeners();
  }

  Future<void> login({BuildContext? context}) async {
    try {
      _isLoading = true;
      notifyListeners();
      if (phoneController.text.isEmpty || passwordController.text.isEmpty) {
        notificationService.showErrorSnackbar('يرجى ملء جميع الحقول');
        return;
      }
      final response = await http
          .post(
            Uri.parse(AppLink.login),
            headers: {
              'Accept': 'application/json',
              'Content-Type': 'application/json',
            },
            body: json.encode({
              'phone': phoneController.text,
              'password': passwordController.text,
            }),
          )
          .timeout(const Duration(seconds: 60));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        if (data['success'] == true) {
          _loginDriverData = LoginDriver.fromJson(data).data!;
          // log(_loginDriverData.token.toString(), name: 'token');
          notifyListeners();
          await authService.saveToken(data['data']['token']);
          await authService.saveUserData(data['data']);
          notificationService.showSuccessSnackbar('تم تسجيل الدخول بنجاح');
          Navigator.push(
              context!,
              AppRoutes.generateRoute(
                  const RouteSettings(name: AppRoutes.entryPoint)));
          // AppRoutes.generateRoute(const RouteSettings(name: AppRoutes.login));
        } else {
          notificationService
              .showErrorSnackbar(data['message'] ?? 'خطأ في تسجيل الدخول');
        }
      } else if (response.statusCode == 401) {
        notificationService
            .showErrorSnackbar('اسم المستخدم أو كلمة المرور غير صحيحة');
      } else if (response.statusCode == 500) {
        notificationService.showErrorSnackbar(
            'حدث خطأ في الخادم. يرجى المحاولة مرة أخرى لاحقًا.');
      } else {
        notificationService
            .showErrorSnackbar('حدث خطأ غير متوقع. يرجى المحاولة مرة أخرى.');
      }
    } on SocketException catch (_) {
      notificationService.showErrorSnackbar('لا يوجد اتصال بالإنترنت',
          onRetry: login);
    } on TimeoutException catch (_) {
      notificationService.showErrorSnackbar(
          'انتهت مهلة الطلب. يرجى المحاولة مرة أخرى.',
          onRetry: login);
    } on FormatException catch (e) {
      notificationService
          .showErrorSnackbar('خطأ في تحليل البيانات من الخادم: ${e.message}');
    } catch (e) {
      print('erorr==================${e}');

      notificationService
          .showErrorSnackbar('حدث خطأ غير متوقع. يرجى المحاولة مرة أخرى.');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
