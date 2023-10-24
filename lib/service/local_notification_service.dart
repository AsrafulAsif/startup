import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationService {
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();


  static Future<void> setupchannelIdFlutterNotifications() async{
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




  // static void initialize() {
  //   const InitializationSettings initializationSettings =
  //       InitializationSettings(
  //     android: AndroidInitializationSettings("@mipmap/ic_launcher"),
  //   );

  //   flutterLocalNotificationsPlugin.initialize(
  //     initializationSettings,  
  //   );
  // }

  static void showFCMForgroundNotification(BuildContext context, RemoteMessage message) async {
    try {
      final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      const NotificationDetails notificationDetailsFor1 = NotificationDetails(
        android: AndroidNotificationDetails(
          "high_importance_channel1",
          "pushnotificationappchannel",
          importance: Importance.max,
          priority: Priority.high,
          playSound: true,
        ),
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
        );
      } else if (message.notification!.android!.channelId ==
          "high_importance_channel2") {
        await flutterLocalNotificationsPlugin.show(
          id,
          message.notification!.title,
          "high_importance_channel2 + heads up ${message.notification!.body}",
          notificationDetailsFor2,
        );
      } else if (message.notification!.android!.channelId ==
          "high_importance_channel3") {
        await flutterLocalNotificationsPlugin.show(
          id,
          message.notification!.title,
          "high_importance_channel3 + heads up ${message.notification!.body}",
          notificationDetailsFor3,
          
        );
      }
    } on Exception catch (e) {
      log(e.toString());
    }
  }
}
