import 'package:ecommerce/core/widgets/check_notification.dart';
import 'package:ecommerce/screens/home_screen.dart';
import 'package:ecommerce/screens/login_mobile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

String? phone;
String? token;
String? name;

main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // SharedPreferences prefs = await SharedPreferences.getInstance();
  // phone = prefs.getString("phone");
  // token = prefs.getString("token");
  // name = prefs.getString("name");

  checkNotification();

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
      home: const LoginMobileScreen(),
      //home: const HomeScreen(),
    );
  }
}
