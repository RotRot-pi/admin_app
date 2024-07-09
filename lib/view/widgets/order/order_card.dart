import 'package:admin_app/core/constants/colors.dart';
import 'package:admin_app/core/constants/routes_name.dart';
import 'package:admin_app/core/constants/spaces.dart';
import 'package:admin_app/data/model/order.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';

class OrderCard extends StatelessWidget {
  const OrderCard({
    super.key,
    required this.order,
    required this.controller,
  });

  final Order order;
  final controller;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.whiteTextColor.withAlpha(150).withAlpha(150),
          border: Border.all(
            color: Colors.grey.shade300,
            width: 1,
            style: BorderStyle.solid,
          ),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.shade300,
                blurRadius: 5,
                spreadRadius: 2,
                offset: const Offset(0, 3))
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "Order Number: ${order.orderId}",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              Text(
                Jiffy.parse(order.orderDateTime!, pattern: 'yyyy-MM-dd')
                    .fromNow(),
                style: const TextStyle(
                    color: AppColors.primaryColor, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const Divider(
            color: Colors.black,
          ),
          Text("Order Date: ${order.orderDateTime}"),
          Text("Order Type: ${controller.printOrderType(order.orderType)}"),
          Text(
              "Order Status: ${controller.printOrderStatus(order.orderStatus)}"),
          Text(
              "Payment Method: ${controller.printPaymentMethod(order.orderPaymentType)}"),
          Text("Order Address: ${order.orderAddressId}"),
          const Divider(
            color: Colors.black,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Order Total Price: ${order.orderTotalprice}",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextButton(
                    onPressed: () {
                      Get.toNamed(AppRoutes.ordersDetails,
                          arguments: {'order': order});
                    },
                    // color: AppColors.whiteTextColor.withAlpha(150),
                    // textColor: AppColors.black,
                    child: const Text(
                      "Details",
                      style: TextStyle(fontSize: 12, color: AppColors.black),
                    ),
                  ),
                  AppSpacing.addWidth(w4),
                  if (order.orderStatus == 0)
                    TextButton(
                      onPressed: () {
                        controller.approveOrder(
                          order.orderUserId,
                          order.orderId,
                        );
                      },
                      child: const Text(
                        "Approve",
                        style: TextStyle(
                            fontSize: 12, color: AppColors.primaryColor),
                      ),
                      // color: AppColors.whiteTextColor.withAlpha(150),
                      // textColor: AppColors.black,
                    ),
                  if (order.orderStatus == 1)
                    TextButton(
                      onPressed: () {
                        controller.orderPrepare(
                            order.orderUserId, order.orderId, order.orderType);
                      },
                      child: const Text(
                        "Done",
                        style: TextStyle(
                            fontSize: 12, color: AppColors.primaryColor),
                      ),
                      // color: AppColors.whiteTextColor.withAlpha(150),
                      // textColor: AppColors.black,
                    ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
