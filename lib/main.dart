import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:startup/provider/auth_provider.dart';
import 'package:provider/provider.dart';
import 'package:startup/screen/auth/registration_screen.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // final fcmToken = await FirebaseMessaging.instance.getToken();
  // log('Firebase message token ${fcmToken.toString()}');
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => AuthProvider()),
  ], child: const MyApp()));
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
      home: const RegistrationScreen(),
    );
  }
}
