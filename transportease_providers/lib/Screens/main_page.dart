import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_flutter_platform_interface/src/types/location.dart'
    as MapsLocation;
import 'package:provider/provider.dart';
import 'package:transportease_providers/AssistantFunctions/methods_assistants.dart';
import 'package:transportease_providers/Models/address.dart';
import 'package:transportease_providers/Screens/providers_account_page.dart';
import 'package:transportease_providers/Screens/providers_earnings_page.dart';
import 'package:transportease_providers/Screens/providers_main_page.dart';
import 'package:transportease_providers/Screens/providers_ratings_page.dart';
import 'package:transportease_providers/Screens/requesting_ride_widget.dart';
import 'package:transportease_providers/Screens/ride_choice_widget.dart';
import 'package:transportease_providers/Screens/search_destination_component.dart';
import 'package:transportease_providers/config_maps.dart' as ConfigMap;
import 'package:transportease_providers/flutter_flow/flutter_flow_util.dart';
import 'package:wtf_sliding_sheet/wtf_sliding_sheet.dart';

import '../DataHandler/app_data.dart';
import '../Models/direction_details.dart';
import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';

class MainPageWidget extends StatefulWidget {
  const MainPageWidget({super.key, this.initialPage, this.page});
  final String? initialPage;
  final Widget? page;

  @override
  State<MainPageWidget> createState() => _MainPageWidgetState();
}

class _MainPageWidgetState extends State<MainPageWidget>
    with TickerProviderStateMixin {
  String _currentPageName = 'ProviderMainPage';
  late Widget? _currentPage;

  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _currentPageName = widget.initialPage ?? _currentPageName;
    _currentPage = widget.page;
  }

  @override
  Widget build(BuildContext context) {
    final tabs = {
      'ProviderMainPage': ProviderMainPageWidget(),
      'ProviderEarningsPage': ProviderEarningsPageWidget(),
      'ProviderRatingsPage': ProviderRatingsPageWidget(),
      'ProviderAccountPage': ProviderAccountPageWidget(),
    };
    final currentIndex = tabs.keys.toList().indexOf(_currentPageName);
    return Scaffold(
      body: _currentPage ?? tabs[_currentPageName],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (i) => setState(() {
          _currentPage = null;
          _currentPageName = tabs.keys.toList()[i];
        }),
        backgroundColor: Colors.white,
        selectedItemColor: FlutterFlowTheme.of(context).primary,
        unselectedItemColor: Color(0x8A000000),
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home_outlined,
              size: 24.0,
            ),
            label: 'Home',
            tooltip: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.credit_card,
              size: 24.0,
            ),
            label: 'Earnings',
            tooltip: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.star_rate,
              size: 24.0,
            ),
            label: 'Ratings',
            tooltip: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.account_circle,
              size: 24.0,
            ),
            label: 'Account',
            tooltip: '',
          )
        ],
      ),
    );
  }
}
