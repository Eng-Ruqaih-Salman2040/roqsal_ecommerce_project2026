import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
//import 'package:roqsal_ecommerce_delivery_project2026/core/services/services.dart';

import '../../core/class/statusrequest.dart';
import '../../core/constant/routes.dart';
import '../../core/functions/getdecodePolyline.dart';
import '../../core/services/services.dart';
import '../../data/model/ordersmodel.dart';
//import 'accepted_controller.dart';

class TrackingController extends GetxController {
  // StreamSubscription<Position>? positionStream;

  //Completer<GoogleMapController>? completercontroller;
  GoogleMapController? gmc;
  List<Marker> markers = [];
  StatusRequest statusRequest = StatusRequest.success;
  late OrdersModel ordersModel;
  CameraPosition? cameraPosition;

  //--------------------------------------------------
  double? destlat;
  double? destlong;

  double? currentlat;
  double? currentlong;

  //---------------------------------------
  Set<Polyline> polylineSet = {};

  //---------------------------------------------------
  MyServices myServices = Get.find();
  //Timer? timer;

  //----------------- Start 217 Video --------------------------
  //bool isLoading = false;// Or //StatusRequest statusRequest = StatusRequest.success;
  //OrdersAcceptedController ordersAcceptedController = Get.find();

  // donedelivery() async {
  //  //isLoading = true;
  //   statusRequest= StatusRequest.loading;
  //   update();
  //  await ordersAcceptedController.doneDelivery(ordersModel.ordersId!, ordersModel.ordersUsersid!);
  // Get.offAllNamed(AppRoute.homepage);
  // }

  //----------------- End 217 Video --------------------------


  //getCurrentLocation() {
  initialData() {
    // Implement your logic to get the current location
    cameraPosition = CameraPosition(
      target: LatLng(double.parse(ordersModel.addressLat!),
          double.parse(ordersModel.addressLong!)),
      zoom: 12.4746,
    );


    markers.add(Marker(
        markerId: MarkerId("current"),
        position: LatLng(double.parse(ordersModel.addressLat!),
            double.parse(ordersModel.addressLong!))));

    //-------------------------------------------------------------------
/*    positionStream =
        Geolocator.getPositionStream().listen((Position? position) {
      print(
          "============================== Current Postion============================\n");
      currentlat = position!.latitude;
      currentlong = position!.longitude;
      print(position == null
          ? 'Current Postion Unknown !!!!'
          : 'latitude Current Postion:  ${position.latitude.toString()},\n longitude Current Postion:  ${position.longitude.toString()}');
      if (gmc != null) {
        gmc!.animateCamera(
            CameraUpdate.newLatLng(LatLng(currentlat!, currentlong!)));
      }
      //currentlat = position!.latitude;
      markers.removeWhere((element) => element.markerId.value == "current");
      markers.add(Marker(
          markerId: MarkerId("current"),
          //position: LatLng(double.parse(ordersModel.addressLat!), double.parse(ordersModel.addressLong!))));
          position: LatLng(position!.latitude, position!.longitude)));
      update();
    });*/

    // markers.removeWhere((element) => element.markerId.value == "current");
    // markers.add(Marker(
    //     markerId: MarkerId("current"),
    //     //position: LatLng(double.parse(ordersModel.addressLat!), double.parse(ordersModel.addressLong!))));
    //     position: LatLng(position!.latitude, position!.longitude)));
  }

  //--------------------------------215 video point the path  -------------
  initPolyline() async {
    //await getPolyline(currentlat, currentlong, destlat, destlong);
    //await getPolyline(ordersModel.addressLat, ordersModel.addressLong, destlat, destlong);
    //this is the first way to get the polyline
    //await getPolyline(currentlat!, currentlong!, double.parse(ordersModel.addressLat!), double.parse(ordersModel.addressLong!));
    // Or this is the second way to get the polyline
    await Future.delayed(Duration(seconds: 1));
    destlat = double.parse(ordersModel.addressLat!);
    destlong = double.parse(ordersModel.addressLong!);
    polylineSet =
        await getPolyline(currentlat!, currentlong!, destlat!, destlong!);
    update();
  }

  //---------------------------- 216 video  Live Location   -------------------
  // refreshLocation() async {
  //   await Future.delayed(Duration(seconds: 2));
  //   timer = Timer.periodic(Duration(seconds: 10), (timer) {
  //     FirebaseFirestore.instance
  //         .collection("delivery")
  //         .doc(ordersModel.ordersId)
  //         .set({
  //       "lat": currentlat,
  //       "long": currentlong,
  //       "deliveryid": myServices.sharedPreferences.getString("id"),
  //     });
  //     //update();
  //   });
  // }

  @override
  void onInit() {
    // TODO: implement onInit
    ordersModel = Get.arguments['ordersmodel'];
    //completercontroller = Completer<GoogleMapController>();

    //getCurrentLocation();
    initialData();
    getLocationDelivery();
   // refreshLocation();
    //initPolyline();
    super.onInit();
  }

  //----------------------- 216 video  216 -  real time location  ( delivery app) -------------------
  @override
  void onClose() {
    // TODO: implement onClose
   // positionStream!.cancel();
    gmc!.dispose();
   // timer!.cancel();
    super.onClose();
  }

  //----------------------- Start 219 video  Tracking ( delivery app) -------------------
getLocationDelivery()
{
FirebaseFirestore.instance.collection("delivery").doc(ordersModel.ordersId).snapshots().listen((event) {
      //if (event.data() != null)  Or
  if(event.exists){
        // currentlat = event.data()!['lat'];
        // currentlong = event.data()!['long'];
    destlat=event.get("lat");
    destlong=event.get("long");
        print("================================= Current Postion============================\n");
        // print(currentlat);
        // print(currentlong);
    print(destlat);
    print(destlong);
       // gmc!.animateCamera(CameraUpdate.newLatLng(LatLng(currentlat!, currentlong!)));
    updateMarkerDelivery(destlat!,destlong!);
      }
    });
  }
  updateMarkerDelivery(double newlat,double newlong)
  {
    markers.removeWhere((element) => element.markerId.value == "dest");
    markers.add(Marker(
        markerId: MarkerId("dest"),
        //position: LatLng(double.parse(ordersModel.addressLat!), double.parse(ordersModel.addressLong!))));
        //position: LatLng(position!.latitude, position!.longitude)));
        position: LatLng(newlat, newlong)));
    update();

  }

  goToPageOrderDetails() {
    Get.toNamed(AppRoute.ordersdetails, arguments: {"ordersmodel": ordersModel});
}
}
