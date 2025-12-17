/*********************

import 'package:flutter/material.dart';


import 'push_notification_service.dart';

class PushNotificationWidget_Roq extends StatefulWidget {
  @override
  _PushNotificationWidget_RoqState createState() => _PushNotificationWidget_RoqState();
}

class _PushNotificationWidget_RoqState extends State<PushNotificationWidget_Roq> {
  final PushNotificationService _pushNotificationService = PushNotificationService();

  @override
  void initState() {
    super.initState();
    _pushNotificationService.initialize();
  }

  void _sendNotification() {
    PushNotificationService.sendNotification(
        deviceToken: 'your-device-token',
        message: 'Hello World'
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FCM Demo'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: _sendNotification,
          child: Text('Send Notification'),
        ),
      ),
    );
  }
}



    ***************/