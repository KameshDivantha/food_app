import 'package:flutter/material.dart';
import 'package:food_delivery/base/custom_loader.dart';
import 'package:food_delivery/controllers/auth_controller.dart';
import 'package:food_delivery/controllers/cart_controller.dart';
import 'package:food_delivery/controllers/user_controller.dart';
import 'package:food_delivery/routes/route_helper.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widgets/account_widget.dart';
import 'package:food_delivery/widgets/app_icon.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:get/get.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    bool userLoggedIn = Get.find<AuthController>().userLoggedIn();
    if (userLoggedIn) {
      Get.find<UserController>().getUserInfo();
    }
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: AppColors.mainColor,
          title: BigText(
            text: "Profile",
            size: 24,
            color: Colors.white,
          ),
        ),
        body: GetBuilder<UserController>(builder: (userController) {
          return userLoggedIn
              ? (!userController.isLoading!
                  ? const CustomLoader()
                  : Container(
                      width: double.maxFinite,
                      margin: EdgeInsets.only(top: Dimensions.height20),
                      child: Column(
                        children: [
                          AppIcon(
                            icon: Icons.person,
                            backgroundColor: AppColors.mainColor,
                            iconColor: Colors.white,
                            iconSize: Dimensions.height15 * 5,
                            size: Dimensions.height15 * 10,
                          ),
                          SizedBox(height: Dimensions.height30),
                          Expanded(
                            child: SingleChildScrollView(
                              physics: const BouncingScrollPhysics(),
                              child: Column(
                                children: [
                                  AccountWidget(
                                      appIcon: AppIcon(
                                        icon: Icons.person,
                                        backgroundColor: AppColors.mainColor,
                                        iconColor: Colors.white,
                                        iconSize: Dimensions.height10 * 5 / 2,
                                        size: Dimensions.height10 * 5,
                                      ),
                                      bigText: BigText(
                                          text:
                                              userController.userModel?.name ??
                                                  'No data')),
                                  SizedBox(height: Dimensions.height20),
                                  AccountWidget(
                                      appIcon: AppIcon(
                                        icon: Icons.phone,
                                        backgroundColor: AppColors.yellowColor,
                                        iconColor: Colors.white,
                                        iconSize: Dimensions.height10 * 5 / 2,
                                        size: Dimensions.height10 * 5,
                                      ),
                                      bigText: BigText(
                                          text:
                                              userController.userModel?.phone ??
                                                  'No data')),
                                  SizedBox(height: Dimensions.height20),
                                  AccountWidget(
                                      appIcon: AppIcon(
                                        icon: Icons.email,
                                        backgroundColor: AppColors.yellowColor,
                                        iconColor: Colors.white,
                                        iconSize: Dimensions.height10 * 5 / 2,
                                        size: Dimensions.height10 * 5,
                                      ),
                                      bigText: BigText(
                                          text:
                                              userController.userModel?.email ??
                                                  'No data')),
                                  SizedBox(height: Dimensions.height20),
                                  AccountWidget(
                                      appIcon: AppIcon(
                                        icon: Icons.location_on_rounded,
                                        backgroundColor: AppColors.yellowColor,
                                        iconColor: Colors.white,
                                        iconSize: Dimensions.height10 * 5 / 2,
                                        size: Dimensions.height10 * 5,
                                      ),
                                      bigText: BigText(
                                          text: "Fill in your address")),
                                  SizedBox(height: Dimensions.height20),
                                  AccountWidget(
                                      appIcon: AppIcon(
                                        icon: Icons.message_outlined,
                                        backgroundColor: Colors.redAccent,
                                        iconColor: Colors.white,
                                        iconSize: Dimensions.height10 * 5 / 2,
                                        size: Dimensions.height10 * 5,
                                      ),
                                      bigText: BigText(text: "messages")),
                                  SizedBox(height: Dimensions.height20),
                                  GestureDetector(
                                    onTap: () {
                                      if (Get.find<AuthController>()
                                          .userLoggedIn()) {
                                        Get.find<AuthController>()
                                            .clearSharedData();
                                        Get.find<CartController>().clear();
                                        Get.find<CartController>()
                                            .clearCartHistory();
                                        Get.offNamed(RouteHelper.getInitial());
                                      }
                                    },
                                    child: AccountWidget(
                                        appIcon: AppIcon(
                                          icon: Icons.logout,
                                          backgroundColor: Colors.redAccent,
                                          iconColor: Colors.white,
                                          iconSize: Dimensions.height10 * 5 / 2,
                                          size: Dimensions.height10 * 5,
                                        ),
                                        bigText: BigText(text: "Logout")),
                                  ),
                                  SizedBox(height: Dimensions.height20),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ))
              : Container(
                  child: Center(
                      child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: Dimensions.width30 * 9,
                      height: Dimensions.height20 * 12,
                      margin: EdgeInsets.only(
                        left: Dimensions.width20,
                        right: Dimensions.width20,
                      ),
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage(
                                  "assets/image/signintocontinue.png"))),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(RouteHelper.getSignInPage());
                      },
                      child: Container(
                        width: double.maxFinite,
                        height: Dimensions.height20 * 5,
                        margin: EdgeInsets.only(
                          left: Dimensions.width20,
                          right: Dimensions.width20,
                        ),
                        decoration: BoxDecoration(
                            color: AppColors.mainColor,
                            borderRadius:
                                BorderRadius.circular(Dimensions.radius20)),
                        child: Center(
                          child: BigText(
                            text: "Sign in",
                            color: Colors.white,
                            size: Dimensions.font20,
                          ),
                        ),
                      ),
                    ),
                  ],
                )));
        }));
  }
}
