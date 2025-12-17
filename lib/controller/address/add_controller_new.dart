/*
import 'dart:async';
import 'package:ecommercecourse/core/class/statusrequest.dart';
import 'package:ecommercecourse/core/constant/routes.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddAddressController_New extends GetxController {
  StatusRequest statusRequest = StatusRequest.loading;

  Completer<GoogleMapController>? completercontroller;

  List<Marker> markers = [];

  double? lat;
  double? long;

  Position? position;
  CameraPosition? kGooglePlex;

  /// Adds a marker to the map at the given `LatLng` position.
  addMarkers(LatLng latLng) {
    markers.clear();
    markers.add(Marker(markerId: MarkerId("1"), position: latLng));
    lat = latLng.latitude;
    long = latLng.longitude;
    update();
  }

  /// Navigates to the address details page with latitude and longitude.
  goToPageAddDetailsAddress() {
    if (lat != null && long != null) {
      Get.toNamed(AppRoute.addressadddetails,
          arguments: {"lat": lat.toString(), "long": long.toString()});
    } else {
      Get.snackbar("Location Error", "Please select a location first.");
    }
  }

  /// Gets the current location of the user with proper permission handling.
  Future<void> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      statusRequest = StatusRequest.failure;
      update();
      Get.snackbar("Location Error", "Please enable location services.");
      return;
    }

    // Check permission status
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        statusRequest = StatusRequest.failure;
        update();
        Get.snackbar("Permission Denied", "Location permission is required.");
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      statusRequest = StatusRequest.failure;
      update();
      Get.snackbar(
        "Permission Permanently Denied",
        "Please enable location permission from settings.",
      );
      return;
    }

    // Fetch current location
    try {
      position = await Geolocator.getCurrentPosition();
      kGooglePlex = CameraPosition(
        target: LatLng(position!.latitude, position!.longitude),
        zoom: 14.4746,
      );

      // Add marker for current location
      addMarkers(LatLng(position!.latitude, position!.longitude));

      statusRequest = StatusRequest.none;
      update();
    } catch (e) {
      statusRequest = StatusRequest.failure;
      update();
      Get.snackbar("Error", "Failed to get current location.");
    }
  }

  @override
  void onInit() {
    super.onInit();
    getCurrentLocation();
    completercontroller = Completer<GoogleMapController>();
  }
}
*/
