import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  if (kDebugMode) print(message.messageId);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  runApp(MyApp_Roq());
}

class MyApp_Roq extends StatelessWidget {
  const MyApp_Roq({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Firebase Messaging Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: MyHomePage_Roq());
  }
}

class MyHomePage_Roq extends StatefulWidget {
  const MyHomePage_Roq({super.key});

  @override
  State<MyHomePage_Roq> createState() => _MyHomePage_RoqState();
}

class _MyHomePage_RoqState extends State<MyHomePage_Roq> {
  void requestPermission() async {

    FirebaseMessaging messaging = FirebaseMessaging.instance;
    await FirebaseMessaging.instance.subscribeToTopic("Roq");
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print("User granted permission");
    }
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.notification != null) {
        print("================================================\n");
        print('Got a message whilst in the foreground!');
        print('Message Title: ${message.notification!.title}');
        print('Message Body: ${message.notification!.body}');
        print('Message data: ${message.data}');
        print("================================================\n");
        // Defer showing the SnackBar until after the widget tree is built.
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    requestPermission();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Firebase Massege"),
        ),
        body: Center(
            child: Column(
              children: [
                Text("Flutter Notification"),
                SizedBox(
                  height: 20,
                ),
                TextButton(onPressed: () async{
                  await FirebaseMessaging.instance.getToken().then((token)
                  {
                    print("============================ Start My Token ==========================");
                    print("My Token : $token");
                    print("============================ End My Token ==========================");
                  });
                }, child: Text("Get Token"))
              ],
            )));
  }
}
