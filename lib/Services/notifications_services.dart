import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class PushNotificationHelper {
  static final _firebaseMessaging = FirebaseMessaging.instance;
  static final FlutterLocalNotificationsPlugin
      _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  //request permission

  static Future init() async {
    await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      sound: true,
    );

    //get device token

    final token = await _firebaseMessaging.getToken();
    print("Device Token : $token");
  }

  static Future localNotificationInitialization() async {
    //android initialization
    const AndroidInitializationSettings initializationSettingsForAndroid =
        AndroidInitializationSettings(
            //icon of app to be added in notification

            '@mipmap/ic_launcher');

    //ios initiaization

    final DarwinInitializationSettings initializationSettingsForioS =
        DarwinInitializationSettings(
      onDidReceiveLocalNotification: (id, title, body, payload) => null,
    );

    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsForAndroid,
      iOS: initializationSettingsForioS,
    );

    //permission for android 13 and abv add

    _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()!
        .requestNotificationsPermission();

    _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: onNotificationTap,
      onDidReceiveBackgroundNotificationResponse: onNotificationTap,
    );
  }

  //on Tap Local notification

  static void onNotificationTap(NotificationResponse notificationResponse){
    
  }
}
