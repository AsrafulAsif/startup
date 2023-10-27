import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:startup/provider/auth_provider.dart';
import 'package:provider/provider.dart';
import 'package:startup/screen/auth/login_screen.dart';
import 'package:startup/screen/home/home_screen.dart';
import 'package:startup/screen/notification/notification_screen.dart';
import 'package:startup/service/firebase_notification_service.dart';
import 'package:startup/service/local_notification_service.dart';
import 'firebase_options.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //inisi
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  LocalNotificationService.initialize();
  FirebaseNotificationService().setUpFCMNotification();
  await LocalNotificationService.setupchannelIdFlutterNotifications();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
      navigatorKey: navigatorKey,
      routes: {
        '/notification_screen': (context) => const NotificationScreen(),
        '/login_screen': (context) => const Loginscreen(),

      },
    );
  }
}
