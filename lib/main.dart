import 'package:ecommerce/screens/home_screen.dart';
import 'package:ecommerce/screens/login_mobile_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'firebase_options.dart';

String? phone;
String? token;
String? name;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // SharedPreferences prefs = await SharedPreferences.getInstance();
  // phone = prefs.getString("phone");
  // token = prefs.getString("token");
  // name = prefs.getString("name");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale("ar"),
      ],
      locale: const Locale("ar"),
      theme: ThemeData(
        fontFamily: 'MessiriFont',
        useMaterial3: true,
        colorScheme:
            ColorScheme.fromSeed(seedColor: Colors.deepPurple).copyWith(
          background: const Color(0xfff2f2f2),
        ),
      ),
      home: LoginMobileScreen(),
      //home: const HomeScreen(),
    );
  }
}
