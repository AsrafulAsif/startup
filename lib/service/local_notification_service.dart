import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:startup/routes/app_routes.dart';

import '../main.dart';

class LocalNotificationService {
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> setupchannelIdFlutterNotifications() async {
    AndroidNotificationChannel channel1 = const AndroidNotificationChannel(
      'high_importance_channel1', // id
      'High Importance Notifications', // title
      description:
          'This channel is used for important notifications.', // description
      importance: Importance.max,
    );

    AndroidNotificationChannel channel2 = const AndroidNotificationChannel(
      'high_importance_channel2', // id
      'High Importance Notifications', // title
      description:
          'This channel is used for important notifications.', // description
      importance: Importance.max,
    );

    AndroidNotificationChannel channel3 = const AndroidNotificationChannel(
      'high_importance_channel3', // id
      'High Importance Notifications', // title
      description:
          'This channel is used for important notifications.', // description
      importance: Importance.max,
    );

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel1);

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel2);

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel3);
  }

  static void initialize() {
    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: AndroidInitializationSettings("@mipmap/ic_launcher"),
    );

    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (details) {
        log("payload::: ${details.payload}");
        Map<String, dynamic> payloads = json.decode(details.payload.toString());
        String route = payloads["route"];
        log(route);
        if(route == "notification"){
          navigatorKey.currentState?.pushNamed(AppRoutes.notificationPage);
        }
      },

      //     (NotificationResponse notificationResponse) {
      //   switch (notificationResponse.notificationResponseType) {
      //     case NotificationResponseType.selectedNotification:
      //       log("payload::: ${notificationResponse.payload}");
      //       navigatorKey.currentState?.pushNamed('/notification_screen');

      //       // On select notification

      //       break;
      //     case NotificationResponseType.selectedNotificationAction:
      //       // Perhaps this section is for custom action with notification
      //       log(notificationResponse.payload.toString());
      //       break;
      //   }
      // },
    );
  }

  static void showFCMForgroundNotification(RemoteMessage message) async {
    try {
      BigPictureStyleInformation? bigPictureStyleInformation;

      String? imageUrl = message.notification?.android?.imageUrl;
      String? base64Image;

      if (imageUrl != null) {
        Response response = await Dio()
            .get(imageUrl, options: Options(responseType: ResponseType.bytes));
        base64Image = base64Encode(response.data);
        bigPictureStyleInformation = BigPictureStyleInformation(
            ByteArrayAndroidBitmap.fromBase64String(
              base64Image,
            ),
            largeIcon: ByteArrayAndroidBitmap.fromBase64String(
              base64Image,
            ),
            hideExpandedLargeIcon: true);
      }

      final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      NotificationDetails notificationDetailsFor1 = NotificationDetails(
        android: AndroidNotificationDetails(
            "high_importance_channel1", "pushnotificationappchannel",
            importance: Importance.max,
            priority: Priority.high,
            playSound: true,
            styleInformation: bigPictureStyleInformation,
            largeIcon: bigPictureStyleInformation?.largeIcon),
      );

      const NotificationDetails notificationDetailsFor2 = NotificationDetails(
        android: AndroidNotificationDetails(
          "high_importance_channel2",
          "pushnotificationappchannel",
          importance: Importance.max,
          priority: Priority.high,
          playSound: true,
        ),
      );

      const NotificationDetails notificationDetailsFor3 = NotificationDetails(
        android: AndroidNotificationDetails(
          "high_importance_channel3",
          "pushnotificationappchannel",
          importance: Importance.max,
          priority: Priority.high,
          playSound: true,
        ),
      );



      if (message.notification!.android!.channelId ==
          "high_importance_channel1") {
        await flutterLocalNotificationsPlugin.show(
            id,
            message.notification!.title,
            message.notification!.body,
            notificationDetailsFor1,
            payload: json.encode(message.data));
      } else if (message.notification!.android!.channelId ==
          "high_importance_channel2") {
        await flutterLocalNotificationsPlugin.show(
            id,
            message.notification!.title,
            message.notification!.body,
            notificationDetailsFor2,
            payload: message.data["route"]);
      } else if (message.notification!.android!.channelId ==
          "high_importance_channel3") {
        await flutterLocalNotificationsPlugin.show(
            id,
            message.notification!.title,
            message.notification!.body,
            notificationDetailsFor3,
            payload: message.data["route"]);
      }
    } on Exception catch (e) {
      log(e.toString());
    }
  }
}
