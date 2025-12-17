// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:roqsal_ecommerce_delivery_project2026/controller/orders/tracking_controller.dart';
// import 'package:roqsal_ecommerce_delivery_project2026/core/constant/color.dart';
// import 'package:roqsal_ecommerce_delivery_project2026/core/functions/getdecodePolyline.dart';

import '../../../../controller/orders/details_controller.dart';
import '../../../../core/class/handlingdataview.dart';
import '../../../controller/orders/tracking_controller.dart';
import '../../../core/constant/color.dart';

class OrdersTracking extends StatelessWidget {
  const OrdersTracking({super.key});

  @override
  Widget build(BuildContext context) {
    //OrdersDetailsController controller = Get.put(OrdersDetailsController());
    // OrdersDetailsController controller = Get.find();
    TrackingController controller = Get.put(TrackingController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Orders Tracking'),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: GetBuilder<TrackingController>(
            builder: ((controller) => HandlingDataView(
                statusRequest: controller.statusRequest,
                widget: Column(children: [
                  // if (controller.ordersModel.ordersType == "0")
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      //height: 300,
                      width: double.infinity,
                      child: GoogleMap(
                        polylines: controller.polylineSet,
                        mapType: MapType.normal,
                        markers: controller.markers.toSet(),
                        initialCameraPosition: controller.cameraPosition!,
                        onMapCreated: (GoogleMapController controllermap) {
                          //controller.completercontroller!.complete(controllermap);
                          controller.gmc = controllermap;
                        },
                      ),
                    ),
                  ),
                  /*Container(
                    height: 40,
                    child: MaterialButton(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      minWidth: 300,
                      color: AppColor.primaryColor,
                      textColor: Colors.white,
                      child: const Text(
                        "The Orderd Has been delivered",
                        style: TextStyle(fontSize: 20),
                      ),
                      onPressed: () { controller.donedelivery();},
                    ),
                  )*/
                ])))),
      ),
    );
  }
}
