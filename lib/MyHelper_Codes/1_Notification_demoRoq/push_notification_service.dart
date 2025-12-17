/***************

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:googleapis_auth/auth_io.dart' as auth;

class PushNotificationService{

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initialize() async {
    // Request permissions
    await _firebaseMessaging.requestPermission();

    // Get the device token
    String? token = await _firebaseMessaging.getToken();
    print("Device Token: $token");
  }

  static Future<String> getServerAccessToken() async {
    final serviceAccountJson = {
      // Copy and Paste json file content

    };

    List<String> scopes = [
      "https://www.googleapis.com/auth/firebase.messaging",
      "https://www.googleapis.com/auth/firebase.database",
    ];

    http.Client client = await auth.clientViaServiceAccount(
      auth.ServiceAccountCredentials.fromJson(serviceAccountJson),
      scopes,
    );

    // Get Access Token
    auth.AccessCredentials credentials =
    await auth.obtainAccessCredentialsViaServiceAccount(auth.ServiceAccountCredentials.fromJson(serviceAccountJson), scopes, client);
    client.close();
    print("log server access token: ${credentials.accessToken.data}");
    return credentials.accessToken.data;
  }

  static sendNotification({
    required String deviceToken,
    required String message,
  }) async {

    final String serverToken = await getServerAccessToken();

    // You will get Project Id from google-services.json
    String endpointFCM = "https://fcm.googleapis.com/v1/projects/<Project Id>/messages:send";
    final Map<String, dynamic> bodyMessage = {
      'message': {
        'token': deviceToken,
        'notification': {
          'title': 'App Name',
          'body': message,
        },
        // Data is optional if you want to add any payload into notification.
        'data': {}
      }
    };

    final http.Response response = await http.post(Uri.parse(endpointFCM),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $serverToken',
        },
        body: jsonEncode(bodyMessage));

    print(response.statusCode);
    if (response.statusCode == 200) {
      print("Sent Notification successfully");
    } else {
      print("Failed Notification");
    }
  }
}



    ************////////////