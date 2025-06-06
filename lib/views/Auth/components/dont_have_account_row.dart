import 'package:flutter/material.dart';

import '../../../core/routes/app_routes.dart';

class DontHaveAccountRow extends StatelessWidget {
  const DontHaveAccountRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(
          onPressed: () => AppRoutes.generateRoute(
              const RouteSettings(name: AppRoutes.signup)),
          child: const Text('إنشاء حساب'),
        ),
        const Text('ليس لديك حساب؟'),
      ],
    );
  }
}
