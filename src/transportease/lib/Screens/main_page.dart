import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_geofire/flutter_geofire.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geoflutterfire2/geoflutterfire2.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_flutter_platform_interface/src/types/location.dart'
    as MapsLocation;
import 'package:provider/provider.dart';
import 'package:transportease/AssistantFunctions/methods_assistants.dart';
import 'package:transportease/Models/address.dart';
import 'package:transportease/Screens/rating_dialog.dart';
import 'package:transportease/Screens/requesting_ride_widget.dart';
import 'package:transportease/Screens/ride_choice_widget.dart';
import 'package:transportease/Screens/search_destination_component.dart';
import 'package:transportease/config_maps.dart' as ConfigMap;
import 'package:transportease/flutter_flow/flutter_flow_util.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wtf_sliding_sheet/wtf_sliding_sheet.dart';

import '../AssistantFunctions/geofire_assistant.dart';
import '../DataHandler/app_data.dart';
import '../Models/direction_details.dart';
import '../Models/nearby_driver.dart';
import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../main.dart';
import 'fare_dialog.dart';

class MainPageWidget extends StatefulWidget {
  const MainPageWidget({super.key});

  @override
  State<MainPageWidget> createState() => _MainPageWidgetState();
}

class _MainPageWidgetState extends State<MainPageWidget>
    with TickerProviderStateMixin {
  static const CameraPosition _kGooglePlex = CameraPosition(
    target: MapsLocation.LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  late GoogleMapController googleMapController;

  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  late Position currentPosition;

  bool searchDestShown = false;

  bool showRideChoice = false;

  bool requestedRide = false;

  bool driverAccepted = false;

  bool nearbyDriversLoaded = false;

  bool isRequestingDetails = false;

  bool farePaid = false;

  bool permissionsGranted = false;

  bool get getSearchDestShown => searchDestShown;
  int driverRequestTimeout = 60;
  String state = "normal";
  StreamSubscription<DatabaseEvent>? rideStreamSub;
  String? statusRide;
  String? carDetails;
  String? carPlates;
  String? driverName;
  String? driverPhone;
  String? durationText;
  String rideType = "regular";

  List<MapsLocation.LatLng> pLineCoordinates = [];
  Set<Polyline> polylineSet = {};
  Set<Marker> markersSet = {};
  Set<Circle> circlesSet = {};

  late DatabaseReference rideRequestRef;

  List<NearbyAvailableDriver> availableDrivers = [];

  late StreamSubscription<List<DocumentSnapshot>> streamSub;

  @override
  void initState() {
    super.initState();
  }

  void payFare() {
    setState(() {
      farePaid = true;
    });
  }

  void permissionGranted() {
    setState(() {
      permissionsGranted = true;
    });
  }

  void changeRideType(String newRideType) {
    setState(() {
      rideType = newRideType;
    });
  }

  void saveRideRequest() {
    rideRequestRef =
        FirebaseDatabase.instance.ref().child("ride_requests").push();

    var pickUp = Provider.of<AppData>(context, listen: false).pickUpLocation;
    var destination =
        Provider.of<AppData>(context, listen: false).dropOffLocation;

    var userProfile =
        Provider.of<AppData>(context, listen: false).loggedInUserProfile;

    Map pickupObj = {
      "latitude": pickUp!.latitude.toString(),
      "longitude": pickUp!.longitude.toString()
    };

    Map destObj = {
      "latitude": destination!.latitude.toString(),
      "longitude": destination!.longitude.toString()
    };

    Map rideInfoObj = {
      "driver_id": "waiting",
      "payment_method": "cash",
      "pickUpLocation": pickupObj,
      "destinationLocation": destObj,
      "created_at": DateTime.now().toString(),
      "rider_name": userProfile!.name,
      "rider_phone": userProfile!.phone,
      "pickUp_address": pickUp.placeFormattedAddress,
      "destination_address": destination.placeFormattedAddress,
      "pickUp_place": pickUp.placeName,
      "destination_place": destination.placeName,
      "ride_type": rideType
    };

    rideRequestRef.set(rideInfoObj);
    rideStreamSub = rideRequestRef.onValue.listen((event) async {
      if (event.snapshot.value == null) {
        return;
      }
      var data = event.snapshot.value as Map;
      if (data["status"] != null) {
        statusRide = data["status"].toString();
      }
      if (data["car_details"] != null) {
        carDetails = data["car_details"].toString();
      }
      if (data["driver_name"] != null) {
        driverName = data["driver_name"].toString();
      }
      if (data["driver_phone"] != null) {
        driverPhone = data["driver_phone"].toString();
      }
      if (data["driver_location"] != null) {
        double driverLat =
            double.parse(data["driver_location"]["latitude"].toString());
        double driverLng =
            double.parse(data["driver_location"]["longitude"].toString());
        MapsLocation.LatLng driverPosition =
            MapsLocation.LatLng(driverLat, driverLng);
        if (statusRide == "accepted") {
          updateRideDurationToPickupLocation(driverPosition);
        } else if (statusRide == "in_progress") {
          updateRideDurationToDestination(driverPosition);
        }
      }
      if (data["car_plates"] != null) {
        carPlates = data["car_plates"].toString();
      }
      if (statusRide == "accepted") {
        displayAcceptedRequestDriverInfo();
        Geofire.stopListener();
        deleteGeofireMarkers();
      }
      String driverId = "";
      if (statusRide == "finished") {
        if (data["fare"] != null) {
          int fare = int.parse(data["fare"].toString());
          var res = await showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => FareDialogWidget(
              paymentMethod: "cash",
              fareAmount: fare,
              payFare: payFare,
            ),
          );
          if (data["driver_id"] != null) {
            driverId = data["driver_id"].toString();
          }
          if (res == "paid" && farePaid) {
            var res_rating = await showDialog(
              builder: (context) => RatingDialogWidget(
                driverId: driverId,
              ),
              context: context,
            );
            if (res_rating == "rated") {
              rideRequestRef.onDisconnect();
              rideStreamSub!.cancel();
              rideStreamSub = null;
              resetTrip();
            }
          }
        }
      }
    });
  }

  void deleteGeofireMarkers() {
    setState(() {
      markersSet.removeWhere(
        (element) => element.markerId.value.contains("driver"),
      );
    });
  }

  void updateRideDurationToPickupLocation(
      MapsLocation.LatLng driverPosition) async {
    if (isRequestingDetails == false) {
      isRequestingDetails = true;
      var userPosition = MapsLocation.LatLng(
          currentPosition.latitude, currentPosition.longitude);
      var rideDetails = await MethodsAssistants.obtainDirectionDetails(
          userPosition, driverPosition);
      if (rideDetails == null) {
        return;
      }
      setState(() {
        durationText = rideDetails.durationText;
      });

      isRequestingDetails = false;
    }
  }

  void updateRideDurationToDestination(
      MapsLocation.LatLng driverPosition) async {
    if (isRequestingDetails == false) {
      isRequestingDetails = true;
      var userPosition =
          Provider.of<AppData>(context, listen: false).dropOffLocation;
      var userLatLng =
          MapsLocation.LatLng(userPosition!.latitude, userPosition.longitude);
      var rideDetails = await MethodsAssistants.obtainDirectionDetails(
          userLatLng, driverPosition);
      if (rideDetails == null) {
        return;
      }
      setState(() {
        durationText = rideDetails.durationText;
      });

      isRequestingDetails = false;
    }
  }

  void cancelRideRequest() {
    rideRequestRef.remove();
    setState(() {
      state = "normal";
    });
    updateAvailableDriverList();
  }

  Future<void> requestRide() async {
    setState(() {
      requestedRide = true;
      state = "requesting";
    });

    saveRideRequest();
    updateAvailableDriverList();
    searchNearestDriver();
  }

  Future<void> cancelRide() async {
    setState(() {
      requestedRide = false;
    });
    cancelRideRequest();
  }

  void displayAcceptedRequestDriverInfo() {
    setState(() {
      driverAccepted = true;
    });
  }

  Future<void> updateSearchDestShown() async {
    setState(() {
      searchDestShown = false;
    });
    await getPlaceDirection();
    setState(() {
      showRideChoice = true;
    });
  }

  void updateAvailableDriverList() {
    setState(() {
      availableDrivers = GeofireAssistant.nearbyAvailableDrivers;
    });
  }

  void locatePosition() async {
    MethodsAssistants.getLoggedInUser(context);
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        return Future.error('Location Not Available');
      }
    }
    permissionGranted();
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
        forceAndroidLocationManager: true);
    currentPosition = position;

    MapsLocation.LatLng latLngPosition =
        MapsLocation.LatLng(position.latitude, position.longitude);

    CameraPosition cameraPosition =
        new CameraPosition(target: latLngPosition, zoom: 14);

    googleMapController
        .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

    Address address = await MethodsAssistants.getAddressFromCoordinates(
        currentPosition, context);
    initGeoFireListener();
  }

  void resetTrip() {
    setState(() {
      showRideChoice = false;
      searchDestShown = false;
      polylineSet.clear();
      markersSet.clear();
      circlesSet.clear();
      pLineCoordinates.clear();
      statusRide = "";
      driverName = "";
      driverPhone = "";
      carDetails = "";
      carPlates = "";
      driverAccepted = false;
      farePaid = false;
      requestedRide = false;
    });
    initGeoFireListener();
    updateAvailableDriversOnMap();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        key: scaffoldKey,
        drawer: Drawer(
          elevation: 16,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Container(
                      width: MediaQuery.sizeOf(context).width * 0.78,
                      height: MediaQuery.sizeOf(context).height * 0.05,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).accent1,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Align(
                    alignment: AlignmentDirectional(0, 0),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(15, 0, 0, 0),
                      child: Container(
                        width: MediaQuery.sizeOf(context).width >= 768
                            ? MediaQuery.sizeOf(context).width * 0.15
                            : MediaQuery.sizeOf(context).width * 0.7,
                        height: MediaQuery.sizeOf(context).height * 0.2,
                        decoration: BoxDecoration(),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            FlutterFlowIconButton(
                              borderColor: FlutterFlowTheme.of(context).primary,
                              borderRadius: 20,
                              borderWidth: 1,
                              buttonSize:
                                  MediaQuery.sizeOf(context).width >= 768
                                      ? MediaQuery.sizeOf(context).width * 0.05
                                      : MediaQuery.sizeOf(context).width * 0.13,
                              fillColor:
                                  FlutterFlowTheme.of(context).secondaryText,
                              icon: Icon(
                                Icons.person,
                                color: FlutterFlowTheme.of(context).primaryText,
                                size: 24,
                              ),
                              onPressed: () {
                                print("ICON PRESSED");
                              },
                            ),
                            Align(
                              alignment: AlignmentDirectional(0, 0),
                              child: Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(25, 0, 0, 0),
                                child: Text(
                                  Provider.of<AppData>(context, listen: false)
                                              .loggedInUserProfile !=
                                          null
                                      ? Provider.of<AppData>(context,
                                              listen: false)
                                          .loggedInUserProfile!
                                          .name
                                      : 'Име на корисник',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyLarge
                                      .override(
                                        fontFamily: FlutterFlowTheme.of(context)
                                            .bodyLargeFamily,
                                        fontWeight: FontWeight.w600,
                                        useGoogleFonts: GoogleFonts.asMap()
                                            .containsKey(
                                                FlutterFlowTheme.of(context)
                                                    .bodyLargeFamily),
                                      ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Divider(
                thickness: 1,
                color: FlutterFlowTheme.of(context).primaryText,
              ),
              Align(
                alignment: AlignmentDirectional(0, 0),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Align(
                        alignment: AlignmentDirectional(0, 0),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(25, 0, 0, 0),
                          child: Icon(
                            Icons.history,
                            color: FlutterFlowTheme.of(context).secondaryText,
                            size: 24,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(30, 0, 0, 0),
                        child: Text(
                          'Историја',
                          style: FlutterFlowTheme.of(context)
                              .bodyMedium
                              .override(
                                fontFamily: FlutterFlowTheme.of(context)
                                    .bodyMediumFamily,
                                fontWeight: FontWeight.w600,
                                useGoogleFonts: GoogleFonts.asMap().containsKey(
                                    FlutterFlowTheme.of(context)
                                        .bodyMediumFamily),
                              ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional(0, 0),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Align(
                        alignment: AlignmentDirectional(0, 0),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(25, 0, 0, 0),
                          child: Icon(
                            Icons.person,
                            color: FlutterFlowTheme.of(context).secondaryText,
                            size: 24,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(30, 0, 0, 0),
                        child: Text(
                          'Посети го профилот',
                          style: FlutterFlowTheme.of(context)
                              .bodyMedium
                              .override(
                                fontFamily: FlutterFlowTheme.of(context)
                                    .bodyMediumFamily,
                                fontWeight: FontWeight.w600,
                                useGoogleFonts: GoogleFonts.asMap().containsKey(
                                    FlutterFlowTheme.of(context)
                                        .bodyMediumFamily),
                              ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional(0, 0),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Align(
                        alignment: AlignmentDirectional(0, 0),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(25, 0, 0, 0),
                          child: Icon(
                            Icons.info_rounded,
                            color: FlutterFlowTheme.of(context).secondaryText,
                            size: 24,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(30, 0, 0, 0),
                        child: Text(
                          'За нас',
                          style: FlutterFlowTheme.of(context)
                              .bodyMedium
                              .override(
                                fontFamily: FlutterFlowTheme.of(context)
                                    .bodyMediumFamily,
                                fontWeight: FontWeight.w600,
                                useGoogleFonts: GoogleFonts.asMap().containsKey(
                                    FlutterFlowTheme.of(context)
                                        .bodyMediumFamily),
                              ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: MediaQuery.sizeOf(context).width * 0.78,
                height: MediaQuery.sizeOf(context).height * 0.45,
                decoration: BoxDecoration(),
              ),
              Divider(
                thickness: 1,
                color: FlutterFlowTheme.of(context).primaryText,
              ),
              Align(
                alignment: AlignmentDirectional(0, 0),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Align(
                        alignment: AlignmentDirectional(0, 0),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(25, 0, 0, 0),
                          child: Icon(
                            Icons.logout,
                            color: FlutterFlowTheme.of(context).secondaryText,
                            size: 24,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          FirebaseAuth.instance.signOut();
                          context.go("/login");
                        },
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(30, 0, 0, 0),
                          child: Text(
                            'Одјави се',
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: FlutterFlowTheme.of(context)
                                      .bodyMediumFamily,
                                  fontWeight: FontWeight.w600,
                                  useGoogleFonts: GoogleFonts.asMap()
                                      .containsKey(FlutterFlowTheme.of(context)
                                          .bodyMediumFamily),
                                ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        body: Stack(children: [
          SlidingSheet(
              elevation: 8,
              cornerRadius: 16,
              snapSpec: const SnapSpec(
                // Enable snapping. This is true by default.
                snap: true,
                // Set custom snapping points.
                snappings: [0.4, 0.7, 1.0],
                // Define to what the snappings relate to. In this case,
                // the total available space that the sheet can expand to.
                positioning: SnapPositioning.relativeToAvailableSpace,
              ),
              // The body widget will be displayed under the SlidingSheet
              // and a parallax effect can be applied to it.
              body: Stack(
                children: [
                  GoogleMap(
                    mapType: MapType.normal,
                    myLocationButtonEnabled: true,
                    myLocationEnabled: permissionsGranted,
                    zoomGesturesEnabled: true,
                    zoomControlsEnabled: true,
                    polylines: polylineSet,
                    markers: markersSet,
                    circles: circlesSet,
                    gestureRecognizers: Set()
                      ..add(Factory<PanGestureRecognizer>(
                          () => PanGestureRecognizer()))
                      ..add(Factory<ScaleGestureRecognizer>(
                          () => ScaleGestureRecognizer()))
                      ..add(Factory<TapGestureRecognizer>(
                          () => TapGestureRecognizer()))
                      ..add(Factory<VerticalDragGestureRecognizer>(
                          () => VerticalDragGestureRecognizer())),
                    initialCameraPosition: _kGooglePlex,
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.sizeOf(context).height * 0.3),
                    onMapCreated: (GoogleMapController controller) => {
                      _controller.complete(controller),
                      googleMapController = controller,
                      locatePosition()
                    },
                  ),
                  getSearchDestShown
                      ? AnimatedOpacity(
                          opacity: getSearchDestShown ? 1.0 : 0.0,
                          duration: const Duration(milliseconds: 500),
                          child: SearchDestinationWidget(
                            visible: getSearchDestShown,
                            updateParent: updateSearchDestShown,
                          ),
                        )
                      : Container(),
                  searchDestShown
                      ? Container()
                      : Align(
                          alignment: AlignmentDirectional(-0.89, -0.79),
                          child: FlutterFlowIconButton(
                            borderColor: FlutterFlowTheme.of(context).primary,
                            borderRadius: 20,
                            borderWidth: 1,
                            buttonSize: 40,
                            fillColor: FlutterFlowTheme.of(context).info,
                            icon: showRideChoice
                                ? Icon(
                                    Icons.close,
                                    color: FlutterFlowTheme.of(context).primary,
                                    size: 24,
                                  )
                                : Icon(
                                    Icons.list,
                                    color: FlutterFlowTheme.of(context).primary,
                                    size: 24,
                                  ),
                            onPressed: () {
                              if (showRideChoice) {
                                resetTrip();
                              } else {
                                scaffoldKey.currentState!.openDrawer();
                              }
                            },
                          ),
                        )
                ],
              ),
              builder: (context, state) {
                // This is the content of the sheet that will get
                // scrolled, if the content is bigger than the available
                // height of the sheet.
                return SingleChildScrollView(
                  child: Column(children: [
                    showRideChoice
                        ? (requestedRide
                            ? (driverAccepted
                                ? Container(
                                    width: MediaQuery.sizeOf(context).width,
                                    height:
                                        MediaQuery.sizeOf(context).height * 0.3,
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(0),
                                        bottomRight: Radius.circular(0),
                                        topLeft: Radius.circular(25),
                                        topRight: Radius.circular(25),
                                      ),
                                      shape: BoxShape.rectangle,
                                    ),
                                    child: SingleChildScrollView(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Align(
                                            alignment: Alignment.center,
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(10, 8, 0, 0),
                                              child: Text(
                                                statusRide == "accepted" &&
                                                        durationText != null
                                                    ? "Превозникот е на пат кон Вас - ${durationText}"
                                                    : statusRide ==
                                                                "accepted" &&
                                                            durationText == null
                                                        ? "Превозникот е на пат кон Вас"
                                                        : statusRide ==
                                                                    "in_progress" &&
                                                                durationText !=
                                                                    null
                                                            ? "Патувате кон дестинацијата - ${durationText}"
                                                            : statusRide ==
                                                                    "arrived"
                                                                ? "Превозникот пристигна на вашата локација"
                                                                : statusRide ==
                                                                            "in_progress" &&
                                                                        durationText ==
                                                                            null
                                                                    ? "Патувате кон дестинацијата"
                                                                    : statusRide ==
                                                                            "finished"
                                                                        ? "Пристигнавте на дестинацијата"
                                                                        : "Превозникот е на пат кон Вас",
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyLarge,
                                              ),
                                            ),
                                          ),
                                          Opacity(
                                            opacity: 0.8,
                                            child: Divider(
                                              thickness: 1,
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                            ),
                                          ),
                                          Align(
                                            alignment:
                                                AlignmentDirectional(0, 1),
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0, 20, 0, 0),
                                              child: Container(
                                                width:
                                                    MediaQuery.sizeOf(context)
                                                            .width *
                                                        0.9,
                                                height:
                                                    MediaQuery.sizeOf(context)
                                                            .height *
                                                        1,
                                                decoration: BoxDecoration(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondaryBackground,
                                                ),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: [
                                                        Expanded(
                                                          child: Align(
                                                            alignment: Alignment
                                                                .centerLeft,
                                                            // AlignmentDirectional(
                                                            //     0, 0),
                                                            child: Text(
                                                              carDetails ??
                                                                  'Бела Toyota Corolla',
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyLarge
                                                                  .override(
                                                                    fontFamily:
                                                                        FlutterFlowTheme.of(context)
                                                                            .bodyLargeFamily,
                                                                    fontSize:
                                                                        20,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    useGoogleFonts: GoogleFonts
                                                                            .asMap()
                                                                        .containsKey(
                                                                            FlutterFlowTheme.of(context).bodyLargeFamily),
                                                                  ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: [
                                                        Expanded(
                                                          child: Align(
                                                            alignment: Alignment
                                                                .centerLeft,
                                                            // AlignmentDirectional(
                                                            //     0, 0),
                                                            child: Text(
                                                              driverName ??
                                                                  'Ime Prezime',
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyMedium,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Opacity(
                                                      opacity: 0.8,
                                                      child: Divider(
                                                        thickness: 1,
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primaryText,
                                                      ),
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceAround,
                                                      children: [
                                                        Column(
                                                          children: [
                                                            FlutterFlowIconButton(
                                                              icon: Icon(
                                                                Icons.phone,
                                                              ),
                                                              borderRadius: 20,
                                                              borderWidth: 1,
                                                              onPressed: () {
                                                                launch(
                                                                    "tel://${driverPhone}");
                                                              },
                                                            ),
                                                            Text(
                                                              "Повикај",
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodySmall,
                                                            ),
                                                          ],
                                                        ),
                                                        Column(
                                                          children: [
                                                            FlutterFlowIconButton(
                                                              icon: Icon(
                                                                Icons.list,
                                                              ),
                                                              borderRadius: 20,
                                                              borderWidth: 1,
                                                              onPressed: () {
                                                                print(
                                                                    "details PRESED");
                                                              },
                                                            ),
                                                            Text(
                                                              "Детали",
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodySmall,
                                                            ),
                                                          ],
                                                        ),
                                                        Column(
                                                          children: [
                                                            FlutterFlowIconButton(
                                                              icon: Icon(
                                                                Icons.close,
                                                              ),
                                                              borderRadius: 20,
                                                              borderWidth: 1,
                                                              onPressed: () {
                                                                print(
                                                                    "CANCEL PRESED");
                                                              },
                                                            ),
                                                            Text(
                                                              "Откажи",
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodySmall,
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                : RequestingRideWidget(
                                    requestRide: requestRide,
                                    cancelRide: cancelRide))
                            : RideChoiceWidget(
                                requestRide: requestRide,
                                changeRideType: changeRideType))
                        : Container(
                            width: MediaQuery.sizeOf(context).width,
                            height: MediaQuery.sizeOf(context).height * 0.3,
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(0),
                                bottomRight: Radius.circular(0),
                                topLeft: Radius.circular(25),
                                topRight: Radius.circular(25),
                              ),
                              shape: BoxShape.rectangle,
                            ),
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Align(
                                    alignment: AlignmentDirectional(-1, 0),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          10, 8, 0, 0),
                                      child: Text(
                                        'Здраво,',
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMediumFamily,
                                              fontWeight: FontWeight.w600,
                                              useGoogleFonts: GoogleFonts
                                                      .asMap()
                                                  .containsKey(
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMediumFamily),
                                            ),
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: AlignmentDirectional(-1, 0),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          10, 8, 0, 0),
                                      child: Text(
                                        'Која е вашата наредна дестинација?',
                                        style: FlutterFlowTheme.of(context)
                                            .bodyLarge,
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        if (currentPosition == null) {
                                          locatePosition();
                                        }
                                        searchDestShown = !searchDestShown;
                                      });
                                    },
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 20, 0, 0),
                                      child: Container(
                                        width:
                                            MediaQuery.sizeOf(context).width *
                                                0.8,
                                        height:
                                            MediaQuery.sizeOf(context).height *
                                                0.05,
                                        decoration: BoxDecoration(
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryBackground,
                                          boxShadow: [
                                            BoxShadow(
                                              blurRadius: 4,
                                              color: Color(0x33000000),
                                              offset: Offset(0, 2),
                                            )
                                          ],
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(20, 0, 0, 0),
                                              child: Icon(
                                                Icons.travel_explore,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .success,
                                                size: 24,
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(20, 0, 0, 0),
                                              child: Text(
                                                'Пребарај локација',
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: AlignmentDirectional(0, 1),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 20, 0, 0),
                                      child: Container(
                                        width:
                                            MediaQuery.sizeOf(context).width *
                                                0.9,
                                        height:
                                            MediaQuery.sizeOf(context).height *
                                                1,
                                        decoration: BoxDecoration(
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryBackground,
                                        ),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Align(
                                                  alignment:
                                                      AlignmentDirectional(
                                                          0, 0),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                0, 0, 20, 6),
                                                    child: Icon(
                                                      Icons.home,
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .success,
                                                      size: 16,
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    // AlignmentDirectional(
                                                    //     0, 0),
                                                    child: Text(
                                                      Provider.of<AppData>(
                                                                      context)
                                                                  .pickUpLocation !=
                                                              null
                                                          ? Provider.of<
                                                                      AppData>(
                                                                  context)
                                                              .pickUpLocation!
                                                              .placeFormattedAddress
                                                          : 'Додади ја локацијата на твојот дом',
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMedium,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Opacity(
                                              opacity: 0.8,
                                              child: Divider(
                                                thickness: 1,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryText,
                                              ),
                                            ),
                                            Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Align(
                                                  alignment:
                                                      AlignmentDirectional(
                                                          0, 0),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                0, 0, 20, 6),
                                                    child: Icon(
                                                      Icons.work,
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .success,
                                                      size: 16,
                                                    ),
                                                  ),
                                                ),
                                                Align(
                                                  alignment:
                                                      AlignmentDirectional(
                                                          0, 0),
                                                  child: Text(
                                                    'Додади ја локацијата на твојата работа',
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                  ]),
                );
              }),
        ]),
      ),
    );
  }

  Future<void> getPlaceDirection() async {
    var initialPos =
        Provider.of<AppData>(context, listen: false).pickUpLocation;
    var destPos = Provider.of<AppData>(context, listen: false).dropOffLocation;

    var pickupLatLng =
        MapsLocation.LatLng(initialPos!.latitude, initialPos.longitude);
    var destLatLng = MapsLocation.LatLng(destPos!.latitude, destPos.longitude);

    showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              content: Text("Се вчитува рутата, Ве молиме почекајте"),
            ));

    var details = await MethodsAssistants.obtainDirectionDetails(
        pickupLatLng, destLatLng);

    Provider.of<AppData>(context, listen: false).updateTripDetails(details);

    Navigator.pop(context);

    PolylinePoints polylinePoints = PolylinePoints();
    List<PointLatLng> decodePolylinePointsResult =
        polylinePoints.decodePolyline(details.encodedPoints);

    pLineCoordinates.clear();

    if (decodePolylinePointsResult.isNotEmpty) {
      decodePolylinePointsResult.forEach((PointLatLng pointLatLng) {
        pLineCoordinates.add(
            MapsLocation.LatLng(pointLatLng.latitude, pointLatLng.longitude));
      });
    }

    polylineSet.clear();

    setState(() {
      Polyline polyline = Polyline(
        color: FlutterFlowTheme.of(context).primary,
        polylineId: PolylineId("PolylineID"),
        jointType: JointType.round,
        points: pLineCoordinates,
        width: 5,
        startCap: Cap.roundCap,
        endCap: Cap.roundCap,
        geodesic: true,
      );

      polylineSet.add(polyline);

      LatLngBounds latlngBounds;
      if (pickupLatLng.latitude > destLatLng.latitude &&
          pickupLatLng.longitude > destLatLng.longitude) {
        latlngBounds =
            LatLngBounds(southwest: destLatLng, northeast: pickupLatLng);
      } else if (pickupLatLng.longitude > destLatLng.longitude) {
        latlngBounds = LatLngBounds(
            southwest: MapsLocation.LatLng(
                pickupLatLng.latitude, destLatLng.longitude),
            northeast: MapsLocation.LatLng(
                destLatLng.latitude, pickupLatLng.longitude));
      } else if (pickupLatLng.latitude > destLatLng.latitude) {
        latlngBounds = LatLngBounds(
            southwest: MapsLocation.LatLng(
                destLatLng.latitude, pickupLatLng.longitude),
            northeast: MapsLocation.LatLng(
                pickupLatLng.latitude, destLatLng.longitude));
      } else {
        latlngBounds =
            LatLngBounds(southwest: pickupLatLng, northeast: destLatLng);
      }

      googleMapController
          .animateCamera(CameraUpdate.newLatLngBounds(latlngBounds, 70));

      Marker pickUpLocationMarker = Marker(
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
          infoWindow:
              InfoWindow(title: initialPos.placeName, snippet: "Моја локација"),
          position: pickupLatLng,
          markerId: MarkerId("PickupID"));

      Marker destLocationMarker = Marker(
          icon: BitmapDescriptor.defaultMarkerWithHue(
              HSLColor.fromColor(FlutterFlowTheme.of(context).info).hue),
          infoWindow:
              InfoWindow(title: destPos.placeName, snippet: "Дестинација"),
          position: destLatLng,
          markerId: MarkerId("DestinationID"));

      setState(() {
        markersSet.add(pickUpLocationMarker);
        markersSet.add(destLocationMarker);
      });

      Circle pickupCircle = Circle(
          fillColor: Colors.cyan,
          center: pickupLatLng,
          radius: 12,
          strokeWidth: 4,
          strokeColor: Colors.white,
          circleId: CircleId("PickupID"));

      Circle destCircle = Circle(
          fillColor: Colors.redAccent,
          center: destLatLng,
          radius: 12,
          strokeWidth: 4,
          strokeColor: Colors.white,
          circleId: CircleId("DestinationID"));

      setState(() {
        circlesSet.add(pickupCircle);
        circlesSet.add(destCircle);
      });
    });
  }

  void initGeoFireListener() {
    Geofire.initialize("availableProviders");
    GeoFirePoint center = geo.point(
        latitude: currentPosition.latitude,
        longitude: currentPosition.longitude);
    double radius = 5;
    String field = 'position';
    Stream<List<DocumentSnapshot>> stream = geo
        .collection(collectionRef: availableProvidersRef)
        .withinAsSingleStreamSubscription(
            center: center, radius: radius, field: field);

    //
    Geofire.queryAtLocation(
            currentPosition.latitude, currentPosition.longitude, 5)!
        .listen((map) {
      if (map != null) {
        var callBack = map['callBack'];

        //latitude will be retrieved from map['latitude']
        //longitude will be retrieved from map['longitude']

        switch (callBack) {
          case Geofire.onKeyEntered:
            NearbyAvailableDriver nearbyAvailableDriver = NearbyAvailableDriver(
                key: map['key'],
                latitude: map['latitude'],
                longitude: map['longitude']);
            GeofireAssistant.nearbyAvailableDrivers.add(nearbyAvailableDriver);
            if (nearbyDriversLoaded) {
              updateAvailableDriversOnMap();
            }
            break;

          case Geofire.onKeyExited:
            GeofireAssistant.removeDriverFromList(map['key']);
            updateAvailableDriversOnMap();
            break;

          case Geofire.onKeyMoved:
            // Update your key's location
            NearbyAvailableDriver nearbyAvailableDriver = NearbyAvailableDriver(
                key: map['key'],
                latitude: map['latitude'],
                longitude: map['longitude']);
            GeofireAssistant.updateSpecificDriverNearbyLocation(
                nearbyAvailableDriver);
            updateAvailableDriversOnMap();
            break;

          case Geofire.onGeoQueryReady:
            // All Intial Data is loaded
            updateAvailableDriversOnMap();
            break;
        }
      }

      setState(() {});
    });
    //

    //for web implementation with geoflutterfire2

    if (kIsWeb) {
      stream.listen((List<DocumentSnapshot> documentList) {
        GeofireAssistant.nearbyAvailableDrivers.clear();
        documentList.forEach((DocumentSnapshot document) {
          Map<String, dynamic> snapData =
              document.data() as Map<String, dynamic>;
          final GeoPoint point = snapData['position']['geopoint'];
          NearbyAvailableDriver nearbyAvailableDriver = NearbyAvailableDriver(
              key: snapData['name'],
              latitude: point.latitude,
              longitude: point.longitude);
          GeofireAssistant.nearbyAvailableDrivers.add(nearbyAvailableDriver);
          updateAvailableDriversOnMap();
          setState(() {});
        });
      });
    }
  }

  void updateAvailableDriversOnMap() async {
    setState(() {
      markersSet.clear();
    });

    Set<Marker> nearbyDriversMarkers = Set<Marker>();
    for (NearbyAvailableDriver driver
        in GeofireAssistant.nearbyAvailableDrivers) {
      ImageConfiguration imageConfiguration =
          createLocalImageConfiguration(context, size: const Size(0.1, 0.1));
      var icon = BitmapDescriptor.defaultMarker;
      DataSnapshot providerSnap = await providersRef.child(driver.key).get();
      var provider = providerSnap.value as Map?;
      if (provider != null) {
        if (provider["role"].toString().toLowerCase() == "regular_driver") {
          icon = await BitmapDescriptor.fromAssetImage(
              imageConfiguration, "assets/images/regular_car_icon.png");
        } else if (provider["role"].toString().toLowerCase() == "taxi_driver") {
          icon = await BitmapDescriptor.fromAssetImage(
              imageConfiguration, "assets/images/taxi_icon.png");
        } else if (provider["role"].toString().toLowerCase() ==
                "transporting_driver" &&
            provider["provider_details"]["provider_type"]
                    .toString()
                    .toLowerCase() ==
                "passengers_provider") {
          if (provider["provider_details"]["routes_type"]
                  .toString()
                  .toLowerCase() ==
              "local") {
            icon = await BitmapDescriptor.fromAssetImage(
                imageConfiguration, "assets/images/local_provider_icon.png");
          } else if (provider["provider_details"]["routes_type"]
                  .toString()
                  .toLowerCase() ==
              "international") {
            icon = await BitmapDescriptor.fromAssetImage(imageConfiguration,
                "assets/images/international_provider_icon.png");
          }
        } else if (provider["role"].toString().toLowerCase() ==
                "transporting_driver" &&
            provider["provider_details"]["provider_type"]
                    .toString()
                    .toLowerCase() ==
                "carrier_provider") {
          icon = await BitmapDescriptor.fromAssetImage(
              imageConfiguration, "assets/images/carrier_provider_icon.png");
        }
      }

      MapsLocation.LatLng driverAvailablePos =
          MapsLocation.LatLng(driver.latitude, driver.longitude);
      Marker marker = Marker(
          markerId: MarkerId("driver${driver.key}"),
          position: driverAvailablePos,
          icon: icon,
          rotation: MethodsAssistants.randomNumber(360));
      nearbyDriversMarkers.add(marker);
    }
    setState(() {
      markersSet = nearbyDriversMarkers;
    });
  }

  Future<void> searchNearestDriver() async {
    if (availableDrivers.length == 0) {
      showDialog(
          context: context,
          builder: ((context) => AlertDialog(
                content: Text(
                    "Во моментот нема достапни превозници, Ве молиме почекајте."),
              )));
      cancelRideRequest();
      resetTrip();
      return;
    } else {
      var nearestDriver = availableDrivers[0];
      var nearestDriverRideType =
          await providersRef.child(nearestDriver.key).child("role").get();
      if (nearestDriverRideType.value != null) {
        String driverType = nearestDriverRideType.value.toString();
        String compareType = rideType + "_driver";
        if (driverType == compareType) {
          notifyDriver(nearestDriver);
          availableDrivers.removeAt(0);
        } else {
          showDialog(
              context: context,
              builder: ((context) => AlertDialog(
                    content: Text(
                        "Во моментот нема достапни превозници од бараниот тип. Ве молиме обидете се повторно или селектирајте друг тип на превозник."),
                  )));
          availableDrivers.removeAt(0);
          searchNearestDriver();
        }
      } else {
        showDialog(
            context: context,
            builder: ((context) => AlertDialog(
                  content: Text(
                      "Во моментот нема достапни превозници. Ве молиме обидете се повторно за неколку минути."),
                )));
      }
    }
  }

  Future<void> notifyDriver(NearbyAvailableDriver driver) async {
    providersRef.child(driver.key).child("newRide").set(rideRequestRef.key);
    DataSnapshot snap =
        await providersRef.child(driver.key).child("token").get();
    if (snap.value != null) {
      String token = snap.value.toString();
      MethodsAssistants.sendNotificationToDriver(
          context, token, rideRequestRef.key.toString());
    } else {
      return;
    }

    const oneSecPassed = Duration(seconds: 1);
    var timer = Timer.periodic(oneSecPassed, (timer) {
      if (state != "requesting") {
        providersRef.child(driver.key).child("newRide").set("cancelled");
        providersRef.child(driver.key).child("newRide").onDisconnect();
        driverRequestTimeout = 60;
        timer.cancel();
      }

      driverRequestTimeout = driverRequestTimeout - 1;
      providersRef.child(driver.key).child("newRide").onValue.listen((event) {
        if (event.snapshot.value.toString() == "accepted") {
          providersRef.child(driver.key).child("newRide").onDisconnect();
          driverRequestTimeout = 60;
          timer.cancel();
        }
      });
      if (driverRequestTimeout == 0) {
        providersRef.child(driver.key).child("newRide").set("timeout");
        providersRef.child(driver.key).child("newRide").onDisconnect();
        driverRequestTimeout = 60;
        timer.cancel();

        searchNearestDriver();
      }
    });
  }
}
