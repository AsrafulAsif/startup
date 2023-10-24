import 'package:flutter/material.dart';
import '../../service/firebase_notification_service.dart';
import '../../service/local_notification_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    FirebaseNotificationService().setUpFCMNotification(context);
    LocalNotificationService.initialize(context);
    super.initState();
  }

  String notificationMsg = "I am home!";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Text(notificationMsg),
        ),
      ),
    );
  }
}
