import 'package:ecommercecourse/core/class/statusrequest.dart';
import 'package:ecommercecourse/core/functions/handingdatacontroller.dart';
import 'package:ecommercecourse/data/datasource/remote/offers_data.dart';
import 'package:ecommercecourse/data/datasource/remote/test_data.dart';
import 'package:ecommercecourse/data/model/itemsmodel.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'home_controller.dart';

class OffersController extends SearchMixController {

  OfferData offerData = OfferData(Get.find());

  List <ItemsModel>data = [];

  late StatusRequest statusRequest;

  getData() async {

    statusRequest = StatusRequest.loading;

    var response = await offerData.getData();

    print("=============================== Controller $response ");

    statusRequest = handlingData(response);

    if (StatusRequest.success == statusRequest){

      // Start backend
      if (response['status'] == "success") {
List listdata2=response['data'];
data.addAll(listdata2.map((e) => ItemsModel.fromJson(e)).toList());
       // data.addAll(response['data']);


      }else{

        statusRequest = StatusRequest.failure ;

      }
      // End
    }
    update();
  }

  @override
  void onInit() {
    search=TextEditingController();
    getData();
    super.onInit();
  }
}
