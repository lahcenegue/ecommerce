import 'package:ecommerce/core/widgets/check_notification.dart';
import 'package:ecommerce/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'core/utils/cache_helper.dart';
import 'homeViewModel/home_view_model.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();

  checkNotification();
  await CacheHelper.init();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  HomeViewModel hvm = HomeViewModel();

  @override
  void initState() {
    print('init state ++++++++++++++++');

    hvm.fetchMainData();
    hvm.fetchCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        return hvm;
      },
      child: MaterialApp(
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
        home: const HomeScreen(),
      ),
    );
  }
}
