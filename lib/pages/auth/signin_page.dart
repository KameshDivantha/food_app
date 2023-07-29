import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/pages/auth/signup_page.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widgets/app_textfield.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:get/get.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var phoneController = TextEditingController();
    var nameController = TextEditingController();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            SizedBox(height: Dimensions.screenHeight * 0.05),
            SizedBox(
              height: Dimensions.screenHeight * 0.25,
              child: const Center(
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 80,
                  backgroundImage: AssetImage("assets/image/logo_app_my.png"),
                ),
              ),
            ),
            Container(
              width: double.maxFinite,
              margin: EdgeInsets.only(left: Dimensions.width20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Hello",
                    style: TextStyle(
                        fontSize: Dimensions.font20 * 3 + Dimensions.font20 / 2,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Sign in to your account",
                    style: TextStyle(
                      fontSize: Dimensions.font20,
                      color: Colors.grey[500],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: Dimensions.height10),
            AppTextField(
                textController: emailController,
                hintText: "Email",
                icon: Icons.email),
            SizedBox(height: Dimensions.height20),
            AppTextField(
                textController: passwordController,
                hintText: "Password",
                icon: Icons.password_sharp),
            SizedBox(height: Dimensions.height10),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                RichText(
                    text: TextSpan(
                        text: "Signin to your account",
                        style: TextStyle(
                            color: Colors.grey[500],
                            fontSize: Dimensions.font20))),
              ],
            ),
            SizedBox(height: Dimensions.screenHeight * 0.05),
            Container(
              width: Dimensions.screenWidth / 2,
              height: Dimensions.screenHeight / 13,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius30),
                  color: AppColors.mainColor),
              child: Center(
                child: BigText(
                  text: "Sign in",
                  size: Dimensions.font20 + Dimensions.font20 / 2,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: Dimensions.screenHeight * 0.05),
            RichText(
                text: TextSpan(
                    text: "Don't have an account?",
                    style: TextStyle(
                        color: Colors.grey[500], fontSize: Dimensions.font20),
                    children: [
                  TextSpan(
                    recognizer: TapGestureRecognizer()
                      ..onTap = () => Get.to(() => const SignUpPage(),
                          transition: Transition.fadeIn),
                    text: " Create",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.mainBlackColor,
                        fontSize: Dimensions.font20),
                  )
                ])),
          ],
        ),
      ),
    );
  }
}
