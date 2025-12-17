import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;



Future getPolyline(double lat, double long, double destlat, double destlong) async {
  Set<Polyline> polylineSet = {};
  List<LatLng> polylineCo = [];
  PolylinePoints polylinePoints = PolylinePoints();
  // استبدل بمفتاح Google Maps API الخاص بك
  const String apiKey = 'AIzaSyAWChSgP6MCsnU6BC-Hyrt3ekkJgJLTlso';

  var url =
      "https://maps.googleapis.com/maps/api/directions/json?origin=$lat,$long&destination=$destlat,$destlong&key=$apiKey";

  var response = await http.get(Uri.parse(url));
  print("response status code ${response.statusCode}");

  if (response.statusCode == 200) {
    var responsebody = jsonDecode(response.body);

    if (responsebody['routes'] != null && responsebody['routes'].isNotEmpty) {
      var point = responsebody['routes'][0]['overview_polyline']['points'];

      List<PointLatLng> result = polylinePoints.decodePolyline(point);
      print(result);

      if (result.isNotEmpty) {
        polylineCo.clear();
        for (var point in result) {
          polylineCo.add(LatLng(point.latitude, point.longitude));
        }

        print("==========================\npolylineCo $polylineCo ============================\n");

        Polyline polyline = Polyline(
          polylineId: PolylineId("polyRoqy"),
          color: Color(0xff11bbdb),
          points: polylineCo,
          width: 5,
        );
        polylineSet.add(polyline);
        return polylineSet; // يمكنك إرجاع مجموعة الـ Polyline هنا
      }
    } else {
      print("No routes found.");
    }
  } else {
    print("Error: ${response.statusCode}");
  }
}


/*
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

Set<Polyline> polylineSet = {};
//List<LatLng> polylineCoordinates = [];
List<LatLng> polylineCo = [];
PolylinePoints polylinePoints = PolylinePoints();

Future<void> getPolyline(lat, long, destlat, destlong) async {
  //AIzaSyBGA2iJ2uSoedYU4kd5rsOATze5KVJfjmI
  //AIzaSyD-0r7v2xX1g3q4a5b6c8f8e9gk5h4j4wA
//--------------------------------My Gogggle Map  API Key  ----------------------
  // AIzaSyAWChSgP6MCsnU6BC-Hyrt3ekkJgJLTlso

  var url =
      "https://maps.googleapis.com/maps/api/directions/json?origin=$lat,$long&destination=$destlat,$destlong&key=AIzaSyAWChSgP6MCsnU6BC-Hyrt3ekkJgJLTlso";
var response=await http.post(Uri.parse(url));
  print("response status code ${response.statusCode}");
  var responsebody = jsonDecode(response.body);

  //var point=responsebody['routes'][0]['overview_polyline'][0]['points'];
  var point = responsebody['routes'][0]['overview_polyline']['points'];


  List<PointLatLng> result = polylinePoints.decodePolyline(point);
  print(result);

  if(result.isNotEmpty){
    // for (var point in result) {
    //   polylineCo.add(LatLng(point.latitude, point.longitude));
    result.forEach((PointLatLng pointlating){
      polylineCo.add(LatLng(pointlating.latitude, pointlating.longitude));
    });

    print("==========================\npolylineCo $polylineCo ============================\n");
    }
  Polyline polyline = Polyline(
    polylineId: PolylineId("polyRoqy"),
    color: Color(0xff3498db),//Colors.red,
    points: polylineCo,
    width: 5,
  );
  polylineSet.add(polyline);
  }

  // if (response.statusCode == 200) {
  //   var data = response.body;
  //   print("data $data");
  //   // polylineCoordinates.clear();
  //   polylineCo.clear();
  //   // print("polylineCoordinates $polylineCoordinates");
  //   // print("polylineCo $polylineCo");
  //   // print("polylinePoints decodePolyline(data) ${polylinePoints.decodePolyline(data)}");
  //   polylineCo.addAll(polylinePoints.decodePolyline(data));
  //   print("polylineCo $polylineCo");
  // } else {
  //   print("Error: ${response.statusCode}");
  // }


*/
