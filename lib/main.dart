import 'dart:convert';

import 'package:book_stash/pages/mainpages/Home.dart';
import 'package:book_stash/Services/auth_services.dart';
import 'package:book_stash/Services/notifications_services.dart';
import 'package:book_stash/auth/ui/login_screen.dart';
import 'package:book_stash/auth/ui/signup_screen.dart';
import 'package:book_stash/firebase_options.dart';
import 'package:book_stash/pages/message_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  //initalize firebase msging
  await PushNotificationHelper.init();

  //initialize local notification

  await PushNotificationHelper.localNotificationInitialization();
  FirebaseMessaging.onBackgroundMessage(_firebaseBackgroundMessage);

  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    if (message.notification != null) {
      print("Background Notification Tapped!");
      navigatorKey.currentState!.pushNamed("/message", arguments: message);
    }
  });

  //foreground msg
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    String payloadContent = jsonEncode(message.data);
    print("Message found in background!");
    if (message.notification != null) {
      PushNotificationHelper.showLocalNotification(
          title: message.notification!.title!,
          body: message.notification!.body!,
          payload: payloadContent);
    }
  });

  //handle app terminated state
  final RemoteMessage? message =
      await FirebaseMessaging.instance.getInitialMessage();
  if (message != null) {
    print("From Terminated State!");
    Future.delayed(Duration(seconds: 3), () {
      navigatorKey.currentState!.pushNamed("/message", arguments: message);
    });
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "BOOK STASH",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.amber,
        ),
        useMaterial3: true,
      ),
      navigatorKey: navigatorKey,
      routes: {
        "/": (context) => checkUserBookStash(),
        "/login": (context) => LoginScreen(),
        "/home": (context) => HomeScreen(),
        "/signup": (context) => SignupScreen(),
        "/message": (context) => MessageScreen(),
      },
    );
  }
}

class checkUserBookStash extends StatefulWidget {
  const checkUserBookStash({super.key});

  @override
  State<checkUserBookStash> createState() => _checkUserBookStashState();
}

class _checkUserBookStashState extends State<checkUserBookStash> {
  @override
  void initState() {
    AuthServicesHelper.isUserLoggedIn().then((value) {
      if (value) {
        Navigator.pushReplacementNamed(context, "/home");
      } else {
        Navigator.pushNamed(context, "/login");
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

Future<void> _firebaseBackgroundMessage(RemoteMessage message) async {
  if (message.notification != null) {
    print("Notification is found in background");
  }
}
