import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:transportease_providers/DataHandler/app_data.dart';
import 'package:transportease_providers/Screens/login_page.dart';
import 'package:google_maps_flutter_android/google_maps_flutter_android.dart';
import 'package:google_maps_flutter_platform_interface/google_maps_flutter_platform_interface.dart';
import 'package:transportease_providers/Screens/main_page.dart';
import 'package:transportease_providers/flutter_flow/flutter_flow_util.dart';

import 'Models/address.dart';
import 'Screens/landing_page.dart';
import 'flutter_flow/flutter_flow_theme.dart';
import 'flutter_flow/internationalization.dart';
import 'flutter_flow/nav/nav.dart';

Future<void> main() async {
  if (isAndroid) {
    final GoogleMapsFlutterPlatform platform =
        GoogleMapsFlutterPlatform.instance;
    // Default to Hybrid Composition for the example.
    (platform as GoogleMapsFlutterAndroid).useAndroidViewSurface = true;
    initializeMapRenderer();
  }

  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyDJDtIjXxPSPDfRwnKSO2gGvS3s7gdLAfs",
            appId: "1:376309427810:web:8adf40eea0681723f02b3b",
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

Completer<AndroidMapRenderer?>? _initializedRendererCompleter;

/// Initializes map renderer to the `latest` renderer type.
///
/// The renderer must be requested before creating GoogleMap instances,
/// as the renderer can be initialized only once per application context.
Future<AndroidMapRenderer?> initializeMapRenderer() async {
  if (_initializedRendererCompleter != null) {
    return _initializedRendererCompleter!.future;
  }

  final Completer<AndroidMapRenderer?> completer =
      Completer<AndroidMapRenderer?>();
  _initializedRendererCompleter = completer;

  WidgetsFlutterBinding.ensureInitialized();

  final GoogleMapsFlutterPlatform platform = GoogleMapsFlutterPlatform.instance;
  unawaited((platform as GoogleMapsFlutterAndroid)
      .initializeWithRenderer(AndroidMapRenderer.latest)
      .then((AndroidMapRenderer initializedRenderer) =>
          completer.complete(initializedRenderer)));

  return completer.future;
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
        title: 'TransportEase - Превозници',
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
DatabaseReference providersRef =
    FirebaseDatabase.instance.ref().child("providers");
DatabaseReference newRideRequestsRef =
    FirebaseDatabase.instance.ref().child("ride_requests");
DatabaseReference rideRequestsRef = FirebaseDatabase.instance
    .ref()
    .child("providers")
    .child(FirebaseAuth.instance.currentUser!.uid)
    .child("newRide");

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
      home: FirebaseAuth.instance.currentUser != null
          ? const MainPageWidget()
          : const LandingPage(),
      theme: ThemeData(fontFamily: "Nunito"),
      debugShowCheckedModeBanner: false,
    );
  }
}
