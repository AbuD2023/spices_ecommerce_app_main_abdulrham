import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:spices_ecommerce_app_main_abdulrham/Providers/auth/auth_controller.dart';
import 'package:spices_ecommerce_app_main_abdulrham/Providers/order_provider.dart';
import 'package:spices_ecommerce_app_main_abdulrham/Providers/profile_provider.dart';
import '../../../core/constants/constants.dart';
import '../../../core/routes/app_routes.dart';
import '../../../core/themes/app_themes.dart';
import '../../../core/utils/validators.dart';
import 'login_button.dart';

class LoginPageForm extends StatelessWidget {
  LoginPageForm({super.key});

  final _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // final authProvider = Provider.of<AuthProvider>(context);
    void onLogin(Future<void> login) async {
      final bool isFormOkay = _key.currentState?.validate() ?? false;
      if (isFormOkay) {
        await login.then(
          (value) {
            Provider.of<OrderProvider>(context, listen: false)
                .fetchCurrentOrders();
            Provider.of<OrderProvider>(context, listen: false)
                .fetchHistoryOrders();
            Provider.of<ProfileProvider>(context, listen: false)
                .fetchDriverProfile();
          },
        );
      }
    }

    return Theme(
      data: AppTheme.defaultTheme.copyWith(
        inputDecorationTheme: AppTheme.secondaryInputDecorationTheme,
      ),
      child: Consumer<AuthProvider>(
        builder: (context, authProvider, child) {
          return Directionality(
            // إضافة Directionality لتحديد الاتجاه من اليمين إلى اليسار
            textDirection: TextDirection.rtl,
            child: Padding(
              padding: const EdgeInsets.all(AppDefaults.padding),
              child: Form(
                key: _key,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Phone Field
                    const Text(
                      "جوالك",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(219, 5, 91, 15),
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: authProvider.phoneController,
                      keyboardType: TextInputType.number,
                      validator: Validators.requiredWithFieldName('Phone').call,
                      textInputAction: TextInputAction.next,
                      textDirection: TextDirection
                          .rtl, // تحديد اتجاه النص من اليمين إلى اليسار
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color.fromARGB(255, 237, 255, 242),
                        border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(15), // زيادة الانحناءات
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(15), // زيادة الانحناءات
                          borderSide: BorderSide(
                            color: const Color.fromARGB(
                                228, 41, 163, 70), // لون الحدود
                            width: 1.5,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(15), // زيادة الانحناءات
                          borderSide: BorderSide(
                            color: const Color.fromARGB(
                                94, 40, 167, 70), // لون الحدود عند التركيز
                            width: 2,
                          ),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 16,
                          horizontal: 16,
                        ),
                        hintText: 'ادخل رقم الجوال',
                        hintStyle: TextStyle(
                            color: const Color.fromARGB(230, 9, 57, 14)),
                      ),
                    ),
                    const SizedBox(height: AppDefaults.padding),

                    // Password Field
                    Text(
                      "الرمز",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(219, 5, 91, 15),
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: authProvider.passwordController,
                      // validator: Validators.password.call,
                      onFieldSubmitted: (v) =>
                          onLogin(authProvider.login(context: context)),
                      textInputAction: TextInputAction.done,
                      textDirection: TextDirection
                          .rtl, // تحديد اتجاه النص من اليمين إلى اليسار
                      obscureText: !authProvider.isPasswordShown,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color.fromARGB(255, 237, 255, 242),
                        border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(15), // زيادة الانحناءات
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(15), // زيادة الانحناءات
                          borderSide: BorderSide(
                            color: const Color.fromARGB(
                                228, 41, 163, 70), // لون الحدود
                            width: 1.5,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(15), // زيادة الانحناءات
                          borderSide: BorderSide(
                            color: const Color.fromARGB(
                                94, 40, 167, 70), // لون الحدود عند التركيز
                            width: 2,
                          ),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 16,
                          horizontal: 16,
                        ),
                        hintText: 'ادخل الرمز',
                        hintStyle: TextStyle(
                            color: const Color.fromARGB(230, 9, 57, 14)),
                        suffixIcon: Material(
                          color: Colors.transparent,
                          child: IconButton(
                            onPressed: authProvider.togglePasswordVisibility,
                            icon: SvgPicture.asset(
                              AppIcons.eye,
                              width: 24,
                              color: const Color.fromARGB(228, 41, 163, 70),
                            ),
                          ),
                        ),
                      ),
                    ),

                    // Forget Password
                    Align(
                      alignment:
                          Alignment.centerLeft, // تغيير المحاذاة إلى اليسار
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushNamed(
                              context, AppRoutes.forgotPassword);
                        },
                        child: Text(
                          'نسيت كلمة المرور؟',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(
                                255, 84, 223, 66), // لون أخضر
                          ),
                        ),
                      ),
                    ),

                    // Login Button
                    const SizedBox(height: 20),
                    LoginButton(
                      onPressed: () {
                        if (authProvider.isLoading) {
                          null;
                        } else {
                          onLogin(authProvider.login(context: context));
                        }
                      },
                      isLoading: authProvider.isLoading,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
