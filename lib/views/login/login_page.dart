import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:highway_weight/controllers/auth_controller.dart';
import 'package:highway_weight/styles/colors.dart';
import 'package:highway_weight/styles/text_styles.dart';
import 'package:highway_weight/widgets/custom_text_form_field.dart';
import 'package:highway_weight/widgets/error_snack_bar.dart';
import 'package:highway_weight/widgets/primary_button.dart';
import 'package:highway_weight/widgets/success_snack_bar.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final authController = Provider.of<AuthController>(context, listen: false);
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
        child: Row(
          children: [
            Expanded(
              child: Container(
                color: AppColors.blackPure,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/logo.png',
                      width: screenWidth / 5,
                    ),
                    SizedBox(height: 40.0),
                    Text(
                      'สำนักงานควบคุมน้ำหนักยานพาหนะ',
                      style: TextStyles.h3Semi.copyWith(
                        color: AppColors.brandPrimary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 80.0,
                  vertical: 140.0,
                ),
                child: Form(
                  autovalidateMode: AutovalidateMode.onUnfocus,
                  key: _formKey,
                  child: Column(
                    children: [
                      Text("ยินดีต้อนรับ", style: TextStyles.h4Semi),
                      SizedBox(height: 10.0),
                      Container(
                        width: 300,
                        decoration: BoxDecoration(
                          color: AppColors.brandSecondary,
                          borderRadius: BorderRadius.circular(64.0),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10.0,
                          vertical: 8.0,
                        ),
                        child: Text(
                          "Highway Weigh",
                          style: TextStyles.h3Semi.copyWith(
                            color: AppColors.brandPrimary,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(height: 60.0),
                      CustomTextFormField(
                        validator:
                            (value) =>
                                authController.validateField("email", value),
                        onChanged: (value) {
                          if (value.isNotEmpty) {
                            authController.setFieldValue('email', value);
                          }
                        },
                        labelText: "Email",
                        hintText: "johndoe@gmail.com",
                      ),
                      SizedBox(height: 24.0),
                      Consumer<AuthController>(
                        builder: (context, value, child) {
                          return CustomTextFormField(
                            validator:
                                (value) => authController.validateField(
                                  "password",
                                  value,
                                ),
                            onChanged: (value) {
                              if (value.isNotEmpty) {
                                authController.setFieldValue('password', value);
                              }
                            },
                            labelText: "Password",
                            hintText: "888-888-888",
                            obscureText: !authController.showPassword,
                            onSuffixPressed: () {
                              authController.setShowPassword();
                            },
                            suffixIcon:
                                authController.showPassword
                                    ? Icons.visibility_outlined
                                    : Icons.visibility_off_outlined,
                          );
                        },
                      ),
                      SizedBox(height: 24.0),
                      PrimaryButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            await authController.login(
                              authController.email,
                              authController.password,
                            );
                            if (authController.user != null) {
                              SuccessSnackBar.show(
                                context,
                                title: authController.alertMessage,
                                subtitle: authController.user,
                              );
                              context.go('/home');
                            } else {
                              ErrorSnackBar.show(
                                context,
                                title: authController.alertMessage,
                              );
                              print("Login Failed");
                            }
                          }
                        },
                        text: "LOG IN",
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//tossapon43733@hotmail.com
//12345678
