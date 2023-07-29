import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/base/no_data_page.dart';
import 'package:food_delivery/controllers/cart_controller.dart';
import 'package:food_delivery/models/cart_model.dart';
import 'package:food_delivery/routes/route_helper.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/constants.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widgets/app_icon.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:food_delivery/widgets/small_text.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CartHistory extends StatelessWidget {
  const CartHistory({super.key});

  @override
  Widget build(BuildContext context) {
    var getCartHistoryList =
        Get.find<CartController>().getCartHistoryList().reversed.toList();
    Map<String, int> cartItemPerOrder = {};

    for (int i = 0; i < getCartHistoryList.length; i++) {
      if (cartItemPerOrder.containsKey(getCartHistoryList[i].time)) {
        cartItemPerOrder.update(
            getCartHistoryList[i].time!, (value) => ++value);
      } else {
        cartItemPerOrder.putIfAbsent(getCartHistoryList[i].time!, () => 1);
      }
    }

    List<int> cartItemsPerOrderToList() {
      return cartItemPerOrder.entries.map((e) => e.value).toList();
    }

    List<String> cartOrderTimeToList() {
      return cartItemPerOrder.entries.map((e) => e.key).toList();
    }

    List<int> itemsPerOrder = cartItemsPerOrderToList();

    var listCounter = 0;

    Widget timeWidget(int index) {
      var outputDate = DateTime.now().toString();
      if (index < getCartHistoryList.length) {
        DateTime parseDate = DateFormat("yyyy-mm-dd HH:mm:ss")
            .parse(getCartHistoryList[listCounter].time!);
        var inputDate = DateTime.parse(parseDate.toString());
        var outputFormat = DateFormat("MM/dd/yyyy hh:mm a");
        outputDate = outputFormat.format(inputDate);
      }
      return BigText(
        text: outputDate,
      );
    }

    return Scaffold(
      body: Column(
        children: [
          Container(
            height: Dimensions.height10 * 10,
            color: AppColors.mainColor,
            width: double.maxFinite,
            padding: EdgeInsets.only(top: Dimensions.height30 * 2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                BigText(
                  text: "Cart History",
                  color: Colors.white,
                ),
                const AppIcon(
                  icon: Icons.shopping_cart_outlined,
                  iconColor: AppColors.mainColor,
                  backgroundColor: AppColors.yellowColor,
                )
              ],
            ),
          ),
          GetBuilder<CartController>(builder: (cartController) {
            return cartController.getCartHistoryList().isNotEmpty
                ? Expanded(
                    child: Container(
                        height: 500,
                        margin: EdgeInsets.only(
                            top: Dimensions.height20,
                            left: Dimensions.width20,
                            right: Dimensions.width20),
                        child: MediaQuery.removePadding(
                          removeTop: true,
                          context: context,
                          child: ListView(
                            children: [
                              for (int i = 0; i < itemsPerOrder.length; i++)
                                Container(
                                  height: Dimensions.height30 * 4,
                                  margin: EdgeInsets.only(
                                      bottom: Dimensions.height20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      timeWidget(listCounter),
                                      SizedBox(height: Dimensions.height10),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Wrap(
                                            direction: Axis.horizontal,
                                            children: List.generate(
                                                itemsPerOrder[i], (index) {
                                              if (listCounter <
                                                  getCartHistoryList.length) {
                                                listCounter++;
                                              }
                                              return index <= 2
                                                  ? Container(
                                                      margin: EdgeInsets.only(
                                                          right: Dimensions
                                                                  .width10 /
                                                              2),
                                                      height:
                                                          Dimensions.height20 *
                                                              4,
                                                      width:
                                                          Dimensions.height20 *
                                                              4,
                                                      decoration: BoxDecoration(
                                                          borderRadius: BorderRadius
                                                              .circular(Dimensions
                                                                      .radius15 /
                                                                  2),
                                                          image: DecorationImage(
                                                              fit: BoxFit.cover,
                                                              image: CachedNetworkImageProvider(AppConstants
                                                                      .BASE_URL +
                                                                  AppConstants
                                                                      .UPLOAD_URL +
                                                                  getCartHistoryList[
                                                                          listCounter -
                                                                              1]
                                                                      .img!))),
                                                    )
                                                  : Container();
                                            }),
                                          ),
                                          SizedBox(
                                            // height: 80,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                SmallText(
                                                    text: "total",
                                                    color:
                                                        AppColors.titleColor),
                                                BigText(
                                                  text:
                                                      "${itemsPerOrder[i]} items",
                                                  color: AppColors.titleColor,
                                                ),
                                                SizedBox(
                                                    height:
                                                        Dimensions.height10),
                                                GestureDetector(
                                                  onTap: () {
                                                    var orderTime =
                                                        cartOrderTimeToList();
                                                    Map<int, CartModel>
                                                        moreOrder = {};

                                                    for (int j = 0;
                                                        j <
                                                            getCartHistoryList
                                                                .length;
                                                        j++) {
                                                      if (getCartHistoryList[j]
                                                              .time ==
                                                          orderTime[i]) {
                                                        moreOrder.putIfAbsent(
                                                            getCartHistoryList[j]
                                                                .id!,
                                                            () => CartModel.fromJson(
                                                                jsonDecode(jsonEncode(
                                                                    getCartHistoryList[
                                                                        j]))));
                                                      }
                                                    }

                                                    Get.find<CartController>()
                                                        .setItems = moreOrder;
                                                    Get.find<CartController>()
                                                        .addToCartList();
                                                    Get.toNamed(RouteHelper
                                                        .getCartPage());
                                                  },
                                                  child: Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: Dimensions
                                                                    .height10 /
                                                                2,
                                                            horizontal:
                                                                Dimensions
                                                                    .width10),
                                                    decoration: BoxDecoration(
                                                        borderRadius: BorderRadius
                                                            .circular(Dimensions
                                                                    .radius15 /
                                                                2),
                                                        border: Border.all(
                                                            width: 1,
                                                            color: AppColors
                                                                .mainColor)),
                                                    child: SmallText(
                                                      text: "one more",
                                                      color:
                                                          AppColors.mainColor,
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                )
                            ],
                          ),
                        )),
                  )
                : SizedBox(
                    height: MediaQuery.of(context).size.height / 1.5,
                    child: const Center(
                      child: NoDataPage(
                        text: "You didn't buy anything so far !",
                        imgPath: "assets/image/empty_box.png",
                      ),
                    ),
                  );
          })
        ],
      ),
    );
  }
}
