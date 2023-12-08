import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:startup/provider/auth_provider.dart';
import 'package:provider/provider.dart';
import 'package:startup/routes/app_routes.dart';
import 'package:startup/service/firebase_notification_service.dart';
import 'package:startup/service/local_notification_service.dart';
import 'firebase_options.dart';
import 'routes/on_generate_route.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //inisi
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseNotificationService().setUpFCMNotification();
  LocalNotificationService.initialize();
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
      initialRoute: AppRoutes.notificationPage,
      navigatorKey: navigatorKey,
      onGenerateRoute: RouteGenerator.onGenerate,
    );
  }
}
