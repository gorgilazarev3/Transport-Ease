import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_geofire/flutter_geofire.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as MapsLocation;
import 'package:transportease_providers/DataHandler/app_data.dart';
import 'package:transportease_providers/Models/driver.dart';
import 'package:transportease_providers/Notifications/push_notification_service.dart';
import 'package:transportease_providers/Screens/providers_account_page.dart';
import 'package:transportease_providers/Screens/providers_earnings_page.dart';
import 'package:transportease_providers/Screens/providers_ratings_page.dart';
import 'package:transportease_providers/main.dart';

import '../AssistantFunctions/methods_assistants.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:transportease_providers/Models/providers_main_page_model.dart';
export 'package:transportease_providers/Models/providers_main_page_model.dart';

class ProviderMainPageWidget extends StatefulWidget {
  const ProviderMainPageWidget({Key? key}) : super(key: key);

  @override
  _ProviderMainPageWidgetState createState() => _ProviderMainPageWidgetState();
}

class _ProviderMainPageWidgetState extends State<ProviderMainPageWidget> {
  late ProviderMainPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: MapsLocation.LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  late Position currentPosition;

  bool isProviderAvailable = false;

  late GoogleMapController googleMapController;
  void locatePosition() async {
    //MethodsAssistants.getLoggedInUser(context);
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        return Future.error('Location Not Available');
      }
    }
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
        forceAndroidLocationManager: true);
    currentPosition = position;
    Provider.of<AppData>(context, listen: false)
        .updateCurrentPosition(position);

    MapsLocation.LatLng latLngPosition =
        MapsLocation.LatLng(position.latitude, position.longitude);

    CameraPosition cameraPosition =
        new CameraPosition(target: latLngPosition, zoom: 14);

    googleMapController
        .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

    // Address address = await MethodsAssistants.getAddressFromCoordinates(
    //     currentPosition, context);
  }

  Future<void> getCurrentProviderInfo() async {
    Provider.of<AppData>(context, listen: false).updateFirebaseUser(
        FirebaseAuth.instance.currentUser ??
            Provider.of<AppData>(context, listen: false).loggedInUser!);

    DataSnapshot driverSnap = await providersRef
        .child(Provider.of<AppData>(context, listen: false).loggedInUser!.uid)
        .get();
    Driver driver = Driver.fromSnapshot(driverSnap);
    Provider.of<AppData>(context, listen: false).updateDriverInfo(driver);

    PushNotificationService pushNotificationService = PushNotificationService();
    pushNotificationService.initialize(context);
    pushNotificationService.getToken(context);
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ProviderMainPageModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
    getCurrentProviderInfo();
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(_model.unfocusNode),
      child: Stack(
        children: [
          GoogleMap(
            mapType: MapType.normal,
            myLocationButtonEnabled: true,
            myLocationEnabled: true,
            zoomGesturesEnabled: true,
            zoomControlsEnabled: true,
            gestureRecognizers: Set()
              ..add(Factory<PanGestureRecognizer>(() => PanGestureRecognizer()))
              ..add(Factory<ScaleGestureRecognizer>(
                  () => ScaleGestureRecognizer()))
              ..add(Factory<TapGestureRecognizer>(() => TapGestureRecognizer()))
              ..add(Factory<VerticalDragGestureRecognizer>(
                  () => VerticalDragGestureRecognizer())),
            initialCameraPosition: _kGooglePlex,
            padding: EdgeInsets.only(
                bottom: MediaQuery.sizeOf(context).height * 0.3),
            onMapCreated: (GoogleMapController controller) => {
              _controller.complete(controller),
              googleMapController = controller,
              locatePosition(),
              MethodsAssistants.getLoggedInUser(context)
            },
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                width: MediaQuery.sizeOf(context).width,
                height: MediaQuery.sizeOf(context).height * 0.1,
                decoration: BoxDecoration(
                  color: Color(0x76043B49),
                  borderRadius: BorderRadius.circular(5),
                ),
                alignment: AlignmentDirectional(0, 0),
                child: FFButtonWidget(
                  onPressed: () {
                    changeProviderStatus();
                    if (isProviderAvailable) {
                      updateLiveLocation();
                    }
                  },
                  text: isProviderAvailable
                      ? 'Статус: Достапен'
                      : 'Статус: Недостапен - ПРОМЕНИ',
                  options: FFButtonOptions(
                    width: isProviderAvailable
                        ? MediaQuery.sizeOf(context).width * 0.6
                        : MediaQuery.sizeOf(context).width * 0.7,
                    height: 45,
                    padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                    iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                    color: isProviderAvailable
                        ? FlutterFlowTheme.of(context).success
                        : FlutterFlowTheme.of(context).accent1,
                    textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                          fontFamily:
                              FlutterFlowTheme.of(context).titleSmallFamily,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          useGoogleFonts: GoogleFonts.asMap().containsKey(
                              FlutterFlowTheme.of(context).titleSmallFamily),
                        ),
                    elevation: 3,
                    borderSide: BorderSide(
                      color: FlutterFlowTheme.of(context).accent1,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void changeProviderStatus() async {
    if (!isProviderAvailable) {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
          forceAndroidLocationManager: true);
      currentPosition = position;
      Geofire.initialize("availableProviders");
      Geofire.setLocation(
          Provider.of<AppData>(context, listen: false).loggedInUser!.uid,
          currentPosition.latitude,
          currentPosition.longitude);

      rideRequestsRef.set("searching");
      rideRequestsRef.onValue.listen((event) {});
      Fluttertoast.showToast(msg: "Го променивте вашиот статус во достапен.");
    } else {
      Geofire.removeLocation(
          Provider.of<AppData>(context, listen: false).loggedInUser!.uid);
      rideRequestsRef.onDisconnect();
      rideRequestsRef.remove();
      Fluttertoast.showToast(msg: "Го променивте вашиот статус во недостапен.");
    }

    setState(() {
      isProviderAvailable = !isProviderAvailable;
    });
  }

  void updateLiveLocation() {
    StreamSubscription<Position> mainPageSub =
        Geolocator.getPositionStream().listen((Position position) {
      currentPosition = position;
      if (isProviderAvailable) {
        Geofire.setLocation(
            Provider.of<AppData>(context, listen: false).loggedInUser!.uid,
            position.latitude,
            position.longitude);
      }

      MapsLocation.LatLng latLng =
          MapsLocation.LatLng(position.latitude, position.longitude);
      googleMapController.animateCamera(CameraUpdate.newLatLng(latLng));
    });

    Provider.of<AppData>(context, listen: false).updateMainPageSub(mainPageSub);
  }
}
