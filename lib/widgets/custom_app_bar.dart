import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:highway_weight/constants/app_constants.dart';
import 'package:highway_weight/controllers/auth_controller.dart';
import 'package:highway_weight/styles/colors.dart';
import 'package:highway_weight/styles/text_styles.dart';
import 'package:provider/provider.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Function(int)? onNavBarChanged;
  const CustomAppBar({super.key, this.onNavBarChanged});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final String routeNow =
        GoRouter.of(context).routeInformationProvider.value.uri.toString();
    final authController = Provider.of<AuthController>(context, listen: false);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: () => context.go('/home'),
          child: Row(
            children: [
              Image.asset("assets/images/logo.png", width: 40.0),
              SizedBox(width: 10.0),
              Text(
                'สำนักงานควบคุมน้ำหนักยานพาหนะ',
                style: TextStyles.subtitleSemi.copyWith(
                  color: AppColors.brandPrimary,
                ),
              ),
            ],
          ),
        ),
        routeNow != '/home'
            ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: TextButton(
                    onPressed: () => context.go('/home'),
                    child: Text(
                      'หน้าแรก',
                      style: TextStyle(color: AppColors.whitePrimary),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: PopupMenuButton(
                    itemBuilder: (context) {
                      return menuAtAppbar.asMap().entries.map((entries) {
                        return PopupMenuItem(
                          onTap: () {
                            entries.key == 1
                                ? context.pushReplacement('/')
                                : null;
                          },
                          child: Text(
                            entries.value.toString(),
                            style: TextStyles.labelReg.copyWith(
                              color: AppColors.whitePrimary,
                            ),
                          ),
                        );
                      }).toList();
                    },
                    child: Row(
                      children: [
                        Image.asset("assets/images/user.png", width: 20.0),
                        SizedBox(width: 8.0),
                        Text(
                          authController.user ?? "Guest",
                          style: TextStyles.labelReg.copyWith(
                            color: AppColors.whitePrimary,
                          ),
                        ),
                        SizedBox(width: 4.0),
                        Icon(
                          Icons.arrow_drop_down_outlined,
                          color: AppColors.whitePrimary,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )
            : Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6.0),
                  child: TextButton(
                    onPressed: () {},
                    child: Text(
                      'หน้าแรก',
                      style: TextStyle(color: AppColors.whitePrimary),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6.0),
                  child: TextButton(
                    onPressed: () {
                      onNavBarChanged == null ? null : onNavBarChanged!(0);
                    },
                    child: Text(
                      'ข้อร้องเรียน',
                      style: TextStyle(color: AppColors.whitePrimary),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6.0),
                  child: TextButton(
                    onPressed: () {
                      onNavBarChanged == null ? null : onNavBarChanged!(1);
                    },
                    child: Text(
                      'รายการอนุมัติออกตรวจ',
                      style: TextStyle(color: AppColors.whitePrimary),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6.0),
                  child: TextButton(
                    onPressed: () {
                      onNavBarChanged == null ? null : onNavBarChanged!(1);
                    },
                    child: Text(
                      'รายการรอสุ่มตรวจ',
                      style: TextStyle(color: AppColors.whitePrimary),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6.0),
                  child: TextButton(
                    onPressed: () {
                      onNavBarChanged == null ? null : onNavBarChanged!(2);
                    },
                    child: Text(
                      'แผนที่สถานี',
                      style: TextStyle(color: AppColors.whitePrimary),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6.0),
                  child: PopupMenuButton(
                    itemBuilder: (context) {
                      return menuAtAppbar.asMap().entries.map((entries) {
                        return PopupMenuItem(
                          onTap: () async {
                            if (entries.key == 1) {
                              await authController.logout(context);
                            } else {
                              null;
                            }
                          },
                          child: Text(
                            entries.value.toString(),
                            style: TextStyles.labelReg.copyWith(
                              color: AppColors.whitePrimary,
                            ),
                          ),
                        );
                      }).toList();
                    },
                    child: Row(
                      children: [
                        Image.asset("assets/images/user.png", width: 20.0),
                        SizedBox(width: 8.0),
                        Text(
                          authController.user ?? "Guest",
                          style: TextStyles.labelReg.copyWith(
                            color: AppColors.whitePrimary,
                          ),
                        ),
                        SizedBox(width: 4.0),
                        Icon(
                          Icons.arrow_drop_down_outlined,
                          color: AppColors.whitePrimary,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
      ],
    );
  }
}
