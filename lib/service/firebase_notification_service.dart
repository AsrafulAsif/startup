import 'dart:developer';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:startup/main.dart';
import 'package:startup/service/local_notification_service.dart';

@pragma('vm:entry-point')
Future<void> backgroundHandler(RemoteMessage message) async {
  log('Background handler ${message.notification!.title.toString()}');
}

class FirebaseNotificationService {
  final firebaseMessing = FirebaseMessaging.instance;

  Future<void> setUpFCMNotification() async {
    final settings = await firebaseMessing.requestPermission(
      alert: false,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: false,
      provisional: true,
      sound: false,
    );

    log('Permission granted: ${settings.authorizationStatus}');

    if (settings.authorizationStatus != AuthorizationStatus.authorized) {
      log('Permission not granted: ${settings.authorizationStatus}');
    }

    final fcmToken = await firebaseMessing.getToken();
    log('Token::: $fcmToken');

    firebaseMessing.getInitialMessage().then(
      (RemoteMessage? message) {
        log('call this when app is terminated');
        log("FirebaseMessaging.instance.getInitialMessage");
        if (message != null) {
          if (message.data['route'] == 'notification') {
            navigatorKey.currentState?.pushNamed('/notification_screen');
          } else if (message.data['route'] == 'login') {
            navigatorKey.currentState?.pushNamed('/login_screen');
          }
        }
      },
    );

    // the app is in the background and when a user click the notification it's call
    FirebaseMessaging.onMessageOpenedApp.listen(
      (RemoteMessage? message) {
        log('call this when app is  in background and not terminated');
        log("FirebaseMessaging.onMessageOpenedApp.listen");
        if (message != null) {
          if (message.data['route'] == 'notification') {
            navigatorKey.currentState?.pushNamed('/notification_screen');
          } else if (message.data['route'] == 'login') {
            navigatorKey.currentState?.pushNamed('/login_screen');
          }
        }
      },
    );

    //the  app is in foreground means  user use the app and the app is open in mobile screen
    FirebaseMessaging.onMessage.listen(
      (RemoteMessage? message) {
        log('call this when app is forground');
        log("FirebaseMessaging.onMessage.listen");
        if (message != null) {
          LocalNotificationService.showFCMForgroundNotification(message);
        }
      },
    );

    //this function recive the background message and it a top level function which is outside from class
    FirebaseMessaging.onBackgroundMessage(backgroundHandler);
    FirebaseMessaging.instance.onTokenRefresh.listen(saveTokenToDatabase);
  }

  Future<void> saveTokenToDatabase(String token) async {
    log("Refress token::: $token");
  }
}
