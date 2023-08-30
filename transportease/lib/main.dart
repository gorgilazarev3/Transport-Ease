import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:transportease/DataHandler/app_data.dart';
import 'package:transportease/Screens/login_page.dart';

import 'Models/address.dart';
import 'Screens/landing_page.dart';
import 'flutter_flow/flutter_flow_theme.dart';
import 'flutter_flow/internationalization.dart';
import 'flutter_flow/nav/nav.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyDJDtIjXxPSPDfRwnKSO2gGvS3s7gdLAfs",
            appId: "1:376309427810:web:48af3118670cb068f02b3b",
            messagingSenderId: "376309427810",
            projectId: "transportease-da2b7",
            databaseURL:
                "https://transportease-da2b7-default-rtdb.europe-west1.firebasedatabase.app"));
  }
  await Firebase.initializeApp();

  if (!kIsWeb) {
    await FlutterConfig.loadEnvVariables();
  }

  runApp(const TransportEaseApp());
}

class _MyAppState extends State<TransportEaseApp> {
  Locale? _locale;
  ThemeMode _themeMode = FlutterFlowTheme.themeMode;

  late AppStateNotifier _appStateNotifier;
  late GoRouter _router;

  Address? pickUpLocation;

  @override
  void initState() {
    super.initState();
    _appStateNotifier = AppStateNotifier.instance;
    _router = createRouter(_appStateNotifier);
  }

  void setLocale(String language) {
    setState(() => _locale = createLocale(language));
  }

  void updatePickupLocationAddress(Address location) {
    setState(() => pickUpLocation = location);
  }

  void setThemeMode(ThemeMode mode) => setState(() {
        _themeMode = mode;
        FlutterFlowTheme.saveThemeMode(mode);
      });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppData(),
      child: MaterialApp.router(
        title: 'TransportEase',
        localizationsDelegates: [
          FFLocalizationsDelegate(),
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        locale: _locale,
        supportedLocales: const [Locale('en', '')],
        theme: ThemeData(
          brightness: Brightness.light,
          scrollbarTheme: ScrollbarThemeData(),
        ),
        darkTheme: ThemeData(
          brightness: Brightness.dark,
          scrollbarTheme: ScrollbarThemeData(),
        ),
        themeMode: _themeMode,
        routerConfig: _router,
      ),
    );
  }
}

DatabaseReference usersRef = FirebaseDatabase.instance.ref().child("users");

class TransportEaseApp extends StatefulWidget {
  const TransportEaseApp({super.key});

  @override
  State<TransportEaseApp> createState() => _MyAppState();

  static _MyAppState of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>()!;

  // This widget is the root of your application.
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "TransportEase",
      home: const LandingPage(),
      theme: ThemeData(fontFamily: "Nunito"),
      debugShowCheckedModeBanner: false,
    );
  }
}
