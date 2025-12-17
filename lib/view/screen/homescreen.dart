import 'dart:io';

import 'package:ecommercecourse/controller/homescreen_controller.dart';
import 'package:ecommercecourse/core/constant/color.dart';
import 'package:ecommercecourse/core/constant/routes.dart';
import 'package:ecommercecourse/view/widget/home/custombottomappbarhome.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(HomeScreenControllerImp());
    return GetBuilder<HomeScreenControllerImp>(
        builder: (controller) => Scaffold(
            floatingActionButton: FloatingActionButton(
                backgroundColor: AppColor.primaryColor,
                onPressed: () {
                  Get.toNamed(AppRoute.cart);
                },
                child: const Icon(Icons.shopping_basket_outlined)),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            bottomNavigationBar: const CustomBottomAppBarHome(),
            body: PopScope(
              canPop: false, // Prevent default back button action
              onPopInvoked: (didPop) {
                if (!didPop) {
                  Get.defaultDialog(
                    title: "Exit App",
                    titleStyle: TextStyle(fontWeight: FontWeight.bold,color: AppColor.primaryColor),
                    middleText: "Are you sure you want to exit?",
                    textConfirm: "OK",
                    textCancel: "Cancel",
                    onConfirm: () {
                      Get.back(); // Close dialog
                      Get.close(1); // Exit app
                    },
                    onCancel: () {
                      Get.back(); // Close dialog without exiting
                    },
                  );
                }
              },
              child: controller.listPage.elementAt(controller.currentpage),
            )
        )

    );
  }
}
