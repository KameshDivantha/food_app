import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/base/custom_loader.dart';
import 'package:food_delivery/base/show_custom_snackbar.dart';
import 'package:food_delivery/controllers/auth_controller.dart';
import 'package:food_delivery/models/signup_body_model.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widgets/app_textfield.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:get/get.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var phoneController = TextEditingController();
    var nameController = TextEditingController();

    var signUpImages = [
      "t.png",
      "f.png",
      "g.png",
    ];

    void registration(AuthController authController) {
      String name = nameController.text.trim();
      String password = passwordController.text.trim();
      String phone = phoneController.text.trim();
      String email = emailController.text.trim();

      if (name.isEmpty) {
        showCustomSnackBar("Type in your name", title: "Name");
      } else if (phone.isEmpty) {
        showCustomSnackBar("Type in your phone", title: "Phone");
      } else if (email.isEmpty) {
        showCustomSnackBar("Type in your email", title: "Email");
      } else if (!GetUtils.isEmail(email)) {
        showCustomSnackBar("Type in a valid email address",
            title: "Invalid Email");
      } else if (password.isEmpty) {
        showCustomSnackBar("Type in your password", title: "Password");
      } else if (password.length < 6) {
        showCustomSnackBar("Password cannot be less that 6 characters",
            title: "Password");
      } else {
        SignupBody signupBody = SignupBody(
            name: name, email: email, password: password, phone: phone);
        authController.registration(signupBody).then((status) {
          if (status.isSuccess) {
            print("success registration");
          } else {
            showCustomSnackBar(status.message);
          }
        });
      }
    }

    return Scaffold(
        backgroundColor: Colors.white,
        body: GetBuilder<AuthController>(builder: (authController) {
          return !authController.isLoading!
              ? SingleChildScrollView(
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
                            backgroundImage:
                                AssetImage("assets/image/logo_app_my.png"),
                          ),
                        ),
                      ),
                      AppTextField(
                          textController: emailController,
                          hintText: "Email",
                          icon: Icons.email),
                      SizedBox(height: Dimensions.height20),
                      AppTextField(
                          isObscure: true,
                          textController: passwordController,
                          hintText: "Password",
                          icon: Icons.password_sharp),
                      SizedBox(height: Dimensions.height20),
                      AppTextField(
                          textController: nameController,
                          hintText: "Name",
                          icon: Icons.person),
                      SizedBox(height: Dimensions.height20),
                      AppTextField(
                          textController: phoneController,
                          hintText: "Phone",
                          icon: Icons.phone),
                      SizedBox(height: Dimensions.height20 * 2),
                      GestureDetector(
                        onTap: () {
                          registration(authController);
                        },
                        child: Container(
                          width: Dimensions.screenWidth / 2,
                          height: Dimensions.screenHeight / 13,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(Dimensions.radius30),
                              color: AppColors.mainColor),
                          child: Center(
                            child: BigText(
                              text: "Sign up",
                              size: Dimensions.font20 + Dimensions.font20 / 2,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: Dimensions.height10),
                      RichText(
                          text: TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => Get.back(),
                              text: "Have an account already?",
                              style: TextStyle(
                                  color: Colors.grey[500],
                                  fontSize: Dimensions.font20))),
                      SizedBox(height: Dimensions.screenHeight * 0.05),
                      RichText(
                          text: TextSpan(
                              text:
                                  "Sign up using one of the following methods",
                              style: TextStyle(
                                  color: Colors.grey[500],
                                  fontSize: Dimensions.font16))),
                      Wrap(
                        children: List.generate(
                            3,
                            (index) => Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CircleAvatar(
                                    radius: Dimensions.radius30,
                                    backgroundImage: AssetImage(
                                        "assets/image/${signUpImages[index]}"),
                                  ),
                                )),
                      )
                    ],
                  ),
                )
              : const CustomLoader();
        }));
  }
}
