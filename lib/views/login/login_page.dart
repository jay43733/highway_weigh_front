import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:highway_weight/controllers/auth_controller.dart';
import 'package:highway_weight/styles/colors.dart';
import 'package:highway_weight/styles/text_styles.dart';
import 'package:highway_weight/widgets/custom_text_form_field.dart';
import 'package:highway_weight/widgets/primary_button.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final authController = Provider.of<AuthController>(context, listen: false);
    final screenWidth = MediaQuery.of(context).size.width;
    return Center(
      child: Row(
        children: [
          Expanded(
            child: Container(
              color: AppColors.blackPure,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/images/logo.png', width: screenWidth / 5),
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
                        "Highway Weight",
                        style: TextStyles.h3Semi.copyWith(
                          color: AppColors.brandPrimary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: 60.0),
                    CustomTextFormField(
                      validator: (value) {
                        final emailRegex = RegExp(
                          r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$",
                        );
                        if (value == '') {
                          return "Email is required";
                        }
                        if (!emailRegex.hasMatch(value!)) {
                          return "Please input email format.";
                        }
                        return null;
                      },
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
                          validator: (value) {
                            if (value == '') {
                              return "Password is required";
                            }
                            if (value!.length < 8) {
                              return "Password must contain at least 8 characters";
                            }
                            return null;
                          },
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
                      onPressed: () {
                        // if (_formKey.currentState!.validate()) {
                        //   _formKey.currentState!.save();
                        context.go('/home');
                        //     _formKey.currentState!.reset();
                        //   }
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
    );
  }
}
