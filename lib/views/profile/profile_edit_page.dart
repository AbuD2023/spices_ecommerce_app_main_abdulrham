import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spices_ecommerce_app_main_abdulrham/Providers/profile_provider.dart';

import '../../core/components/app_back_button.dart';
import '../../core/constants/constants.dart';

class ProfileEditPage extends StatelessWidget {
  const ProfileEditPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cardColor,
      appBar: AppBar(
        leading: const AppBackButton(),
        title: const Text(
          'Profile',
        ),
      ),
      body: SingleChildScrollView(
        child: Consumer<ProfileProvider>(
          builder: (context, profileProvider, state) {
            final profileData = profileProvider.user!;
            return Container(
              margin: const EdgeInsets.all(AppDefaults.padding),
              padding: const EdgeInsets.symmetric(
                horizontal: AppDefaults.padding,
                vertical: AppDefaults.padding * 2,
              ),
              decoration: BoxDecoration(
                color: AppColors.scaffoldBackground,
                borderRadius: AppDefaults.borderRadius,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /* <----  First Name -----> */
                  const Text("First Name"),
                  const SizedBox(height: 8),
                  TextFormField(
                    readOnly: true,
                    initialValue: profileData.name,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(height: AppDefaults.padding),

                  /* <---- Last Name -----> */
                  const Text("Your Phone Number"),
                  const SizedBox(height: 8),
                  TextFormField(
                    readOnly: true,
                    initialValue: profileData.phone,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(height: AppDefaults.padding),

                  /* <---- Phone Number -----> */
                  const Text("Your Salary "),
                  const SizedBox(height: 8),
                  TextFormField(
                    readOnly: true,
                    initialValue: profileData.salary,
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(height: AppDefaults.padding),

                  /* <---- Gender -----> */
                  const Text("Status Of Account"),
                  const SizedBox(height: 8),
                  TextFormField(
                    readOnly: true,
                    initialValue: profileData.status,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(height: AppDefaults.padding),

                  /* <---- Birthday -----> */
                  const Text("Address"),
                  const SizedBox(height: 8),
                  TextFormField(
                    readOnly: true,
                    initialValue: profileData.address,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(height: AppDefaults.padding),

                  /* <---- Password -----> */

                  /* <---- Birthday -----> */
                  // const Text("Password"),
                  // const SizedBox(height: 8),
                  // TextFormField(
                  //   keyboardType: TextInputType.visiblePassword,
                  //   textInputAction: TextInputAction.next,
                  //   obscureText: true,
                  // ),
                  // const SizedBox(height: AppDefaults.padding),

                  // /* <---- Submit -----> */
                  // const SizedBox(height: AppDefaults.padding),
                  // SizedBox(
                  //   width: double.infinity,
                  //   child: ElevatedButton(
                  //     child: const Text('Save'),
                  //     onPressed: () {},
                  //   ),
                  // ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
