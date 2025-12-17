/********************

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:googleapis_auth/auth_io.dart' as auth;
import 'package:firebase_messaging/firebase_messaging.dart';

// import '../components/components.dart';
// import '../constants.dart';

class NotificationsHelper {
  // creat instance of fbm
  final _firebaseMessaging = FirebaseMessaging.instance;

  // initialize notifications for this app or device
  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();
    // get device token
    String? deviceToken = await _firebaseMessaging.getToken();
    /////------------->DeviceToken = deviceToken;
    print(
        "===================Begine : Device FirebaseMessaging Token====================");
    print(deviceToken);
    print(
        "===================End : Device FirebaseMessaging Token====================");
  }

  // handle notifications when received
  void handleMessages(RemoteMessage? message) {
    if (message != null) {
      // navigatorKey.currentState?.pushNamed(NotificationsScreen.routeName, arguments: message);
print('on Background Message notification state: ToastStates.SUCCESS ');
print(
    "===================Begine: Handle Notifications when Received====================");
print(message);
print(
    "===================End: Handle Notifications when Received====================");

/*showToast(
          text: 'on Background Message notification',
          state: ToastStates.SUCCESS);*/
    }
  }

  // handel notifications in case app is terminated
  void handleBackgroundNotifications() async {
    FirebaseMessaging.instance.getInitialMessage().then((handleMessages));
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessages);
  }

  Future<String?> getAccessToken() async {
    final serviceAccountJson = {
      "type": "service_account",
      "project_id": "ecommerceroqsal2025",
      "private_key_id": "de7b2f3f7d308fa1194833d2ee2074296ed258c1",
      "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQDJlP5NS2KM8y2s\n9o5k1gLDr0hukDS6U4H6ksDrpMmPMDBFMjwxnEYVnA/eKTOcUgCQSzXnSO5YFl7U\nWCwL5DOlDP4F08XYhtmOnZY2ari9LpJEyaM6bWIyKLd4R6E62comxA/CXXsQfaS6\nfT5g9/4ZogQpr7vnCdtFA8WJYjcTYvzIP8j71AJmzWkHLyY+kJhztFGFKeEHH9w1\nxXFGA9xwvfB7GRaIfrSaqViOCc5ZxgupVUhJ6hvfEnSpKAdOs9n65dwyplJWeJP0\ny8q0xL59kZaXOeG4R2QF9GoFjZyNhWIwSogU+Mwr+bGOAys62pZvEi0uJfSy2/TB\nNs307NTXAgMBAAECggEAPiNpiJYWWPCVQd324up9i6i6oSpetpkLVhxqz7jKURM/\nrfTgTUKo7/xdf9Qfjq5QcipdAWCf6BNtQ/OyEDBWIyiwHUe8kxRud+Hn7fpT3C1A\n9Wdao6YYQPIALFmYP7Xm9LA3U2jRiLHSV5JH6khH0cr5kYgUWhHVv558A+98nsK2\nZtI3KFNB56EtBH6Rot3exksmPhs8zuTGNaZ2CIryrK7TgNqVLQOowLEbhhtqupaz\ns6mk/eJSGu5b9JFXg3zWcw92Ewy6B62KOf1VRLBpxiUtuVyyN33aCvROqsphhAwq\nfH53iXHjpsBK9Q5SkVGIZdBnRnT+jS+e5mlXYDdFYQKBgQDyJh/kj9V2gZxTm4oT\nz+fSimOuebkww4P2INVfcUvVV6Rqv3sZD8R7FPtTnyBM6rKfA3qGQ0IPiAmCeVn4\nfvffXk27hbPJvm7Zb8Y+8IeUuUWHN/hWJ5kCNOBXazsb+i271dSg7755BMkn4gPm\nm/xjuo1bDo80zIaKxXP3c0/aXwKBgQDVHNUgrt835Nk7qzZ+jplX1xf1+tIzZHXK\n7tZS+kqnH/lovk1ySY03dwHhQkG3sgRD1uDOjUrotzwns5pN6FbBdlNuUrzkVYpt\nQGvEj+7Ro3brH4+pKiNtPJVU/YFpAAwEOCH2jkLAH9CwvDn4Nn//d8JRIwHDv+9t\ntWcr2GIIiQKBgDWfjbZ+x6W7pBO7wQMMKmksblCn8gPDeEicEsRVAZcYFnfxOWBe\nZoNfLRzigzOlUbL3AT4UTN/Fn11+ZBcsftW/O3WIcTz+5+tM3lj3yP59XNFJ6ruh\nfzfG39tcCrXyXAhZnQGatdJ05droKTb7WhP3ru/4NGxb0nuOqFSm+4r/AoGBAKsJ\npuvCLZh4bPh8oxHTdLKRCMP8d/OTLw6dvRl/k6ap/MvZ3+JXsaTQOIwHVyMNFmsz\n690afQJk/TyH4tGgJPDD/JXQhZVkKeMhDt0E/5D09p4iCHSmQySKuPcrNk+FIB/K\nxUdSSbRUVHNjvcq+QuBPx37C78mhI5ITQyhnU9axAoGARmspWsaOyuRlisgmHvOm\n7FOTZHqbDiX31pNneyV/51AjN4PnbOhZBVlLlDm3XHv68aaRgMtSJuIIsPXVn1G6\n3yXw9w0op6TNrS2XCSV3MaeanfCK+GsqaNf6fsq/zDyMS5p4QU46L1yt7ngji0hv\nLiH9bok8OKvYqquvx9w/ENg=\n-----END PRIVATE KEY-----\n",
      "client_email": "firebase-adminsdk-qz32z@ecommerceroqsal2025.iam.gserviceaccount.com",
      "client_id": "114997492064746839247",
      "auth_uri": "https://accounts.google.com/o/oauth2/auth",
      "token_uri": "https://oauth2.googleapis.com/token",
      "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
      "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-qz32z%40ecommerceroqsal2025.iam.gserviceaccount.com",
      "universe_domain": "googleapis.com"
    };
    /*{
      "type": "",
      "project_id": "",
      "private_key_id": "",
      "private_key":"",
      "client_email": "",
      "client_id": "",
      "auth_uri": "",
      "token_uri": "",
      "auth_provider_x509_cert_url":
          "",
      "client_x509_cert_url":
          "",
      "universe_domain": ""
    };*/

    List<String> scopes = [
      "https://www.googleapis.com/auth/userinfo.email",
      "https://www.googleapis.com/auth/firebase.database",
      "https://www.googleapis.com/auth/firebase.messaging"
    ];

    try {
      http.Client client = await auth.clientViaServiceAccount(
          auth.ServiceAccountCredentials.fromJson(serviceAccountJson), scopes);

      auth.AccessCredentials credentials =
          await auth.obtainAccessCredentialsViaServiceAccount(
              auth.ServiceAccountCredentials.fromJson(serviceAccountJson),
              scopes,
              client);

      client.close();
      print(
          "===================Begine: Access Token ====================");
      print(
          "Access Token: ${credentials.accessToken.data}");
      print(
          "===================End: Access Token ====================");

      /*print(
          "Access Token: ${credentials.accessToken.data}"); */// Print Access Token
      return credentials.accessToken.data;
    } catch (e) {
      print("Error getting access token: $e");
      return null;
    }
  }

  Map<String, dynamic> getBody({
    required String fcmToken,
    required String title,
    required String body,
    required String userId,
    String? type,
  }) {
    return {
      "message": {
        "token": fcmToken,
        "notification": {"title": title, "body": body},
        "android": {
          "notification": {
            "notification_priority": "PRIORITY_MAX",
            "sound": "default"
          }
        },
        "apns": {
          "payload": {
            "aps": {"content_available": true}
          }
        },
        "data": {
          "type": type,
          "id": userId,
          "click_action": "FLUTTER_NOTIFICATION_CLICK"
        }
      }
    };
  }

  Future<void> sendNotifications({
    required String fcmToken,
    required String title,
    required String body,
    required String userId,
    String? type,
  }) async {
    try {
      var serverKeyAuthorization = await getAccessToken();
      
      // change your project id
      const String urlEndPoint =
          "https://fcm.googleapis.com/v1/projects/ecommerceroqsal2025/messages:send";

      Dio dio = Dio();
      dio.options.headers['Content-Type'] = 'application/json';
      dio.options.headers['Authorization'] = 'Bearer $serverKeyAuthorization';

      var response = await dio.post(
        urlEndPoint,
        data: getBody(
          userId: userId,
          fcmToken: fcmToken,
          title: title,
          body: body,
          type: type ?? "message",
        ),
      );

      // Print response status code and body for debugging
      print('Response Status Code: ${response.statusCode}');
      print('Response Data: ${response.data}');
    } catch (e) {
      print("Error sending notification: $e");
    }
  }
}



    *******/