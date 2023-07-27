import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:texno_bozor/provider/auth_provider.dart';
import 'package:texno_bozor/ui/auth/widgets/global_button.dart';
import 'package:texno_bozor/ui/auth/widgets/global_text_fields.dart';
import 'package:texno_bozor/utils/app_icon.dart';
import 'package:texno_bozor/utils/colors.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key, required this.onChanged});

  final VoidCallback onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25.w),
      child: ListView(
        children: [
          Lottie.asset("assets/images/sign.json",height: 210.h),
          const SizedBox(
            height: 24,
          ),
          GlobalTextField(
            hintText: "Username",
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            textAlign: TextAlign.start,
            controller: context.read<AuthProvider>().userNameController,
          ),
          const SizedBox(
            height: 24,
          ),
          GlobalTextField(
            hintText: "Email",
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            textAlign: TextAlign.start,
            controller: context.read<AuthProvider>().emailController,
          ),
          const SizedBox(height: 24),
          GlobalTextField(
            obscureText: true,
            hintText: "Password",
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            textAlign: TextAlign.start,
            controller: context.read<AuthProvider>().passwordController,
          ),
          const SizedBox(height: 24),
          GlobalTextField(
            obscureText: true,
            hintText: "Confirm Password",
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            textAlign: TextAlign.start,
            controller: TextEditingController(),
          ),
          const SizedBox(height: 24),
          GlobalButton(
              title: "Sign up",
              onTap: () {
                context.read<AuthProvider>().signUpUser(context);
              }),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                  onPressed: () {
                    onChanged.call();
                    context.read<AuthProvider>().loginButtonPressed();
                  },
                  child: Text(
                    "Log In",
                    style: TextStyle(fontSize: 18.spMin),
                  ))
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 14.h,vertical: 14.h),
                height: 60.h,
                width: 60.h,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: AppColors.white
                ),
                child: SvgPicture.asset(AppIcon.apple),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 14.h,vertical: 14.h),
                height: 60.h,
                width: 60.h,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: AppColors.white
                ),
                child: SvgPicture.asset(AppIcon.google),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 14.h,vertical: 14.h),
                height: 60.h,
                width: 60.h,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: AppColors.white
                ),
                child: SvgPicture.asset(AppIcon.facebook),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
