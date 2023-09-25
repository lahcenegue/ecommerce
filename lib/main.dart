import 'package:ecommerce/core/widgets/check_notification.dart';
import 'package:ecommerce/screens/home_screen.dart';
import 'package:ecommerce/screens/login_mobile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'core/utils/cache_helper.dart';
import 'homeViewModel/home_view_model.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
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
    hvm.fetchMainData();
    hvm.fetchCategories();
    if (CacheHelper.getData(key: PrefKeys.token) != null) {
      hvm.fetchProfilInfo(token: CacheHelper.getData(key: PrefKeys.token));
      hvm.fetchmyAds(
        token: CacheHelper.getData(key: PrefKeys.token),
        page: 1,
      );
    }

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
        navigatorKey: navigatorKey,
        initialRoute: '/',
        routes: {
          "login": (BuildContext context) => const LoginMobileScreen(),
        },
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
          fontFamily: 'NotoFont',
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
