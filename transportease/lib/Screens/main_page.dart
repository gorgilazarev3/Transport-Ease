import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:transportease/AssistantFunctions/methods_assistants.dart';
import 'package:transportease/Models/address.dart';
import 'package:transportease/Screens/requesting_ride_widget.dart';
import 'package:transportease/Screens/ride_choice_widget.dart';
import 'package:transportease/Screens/search_destination_component.dart';
import 'package:transportease/config_maps.dart' as ConfigMap;
import 'package:wtf_sliding_sheet/wtf_sliding_sheet.dart';

import '../DataHandler/app_data.dart';
import '../Models/direction_details.dart';
import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';

class MainPageWidget extends StatefulWidget {
  const MainPageWidget({super.key});

  @override
  State<MainPageWidget> createState() => _MainPageWidgetState();
}

class _MainPageWidgetState extends State<MainPageWidget>
    with TickerProviderStateMixin {
  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
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

  bool get getSearchDestShown => searchDestShown;

  List<LatLng> pLineCoordinates = [];
  Set<Polyline> polylineSet = {};
  Set<Marker> markersSet = {};
  Set<Circle> circlesSet = {};

  late DatabaseReference rideRequestRef;

  @override
  void initState() {
    super.initState();
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
      "destination_place": destination.placeName
    };

    rideRequestRef.set(rideInfoObj);
  }

  void cancelRideRequest() {
    rideRequestRef.remove();
  }

  Future<void> requestRide() async {
    setState(() {
      requestedRide = true;
    });

    saveRideRequest();
  }

  Future<void> cancelRide() async {
    setState(() {
      requestedRide = false;
    });
    cancelRideRequest();
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
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
        forceAndroidLocationManager: true);
    currentPosition = position;

    LatLng latLngPosition = LatLng(position.latitude, position.longitude);

    CameraPosition cameraPosition =
        new CameraPosition(target: latLngPosition, zoom: 14);

    googleMapController
        .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

    Address address = await MethodsAssistants.getAddressFromCoordinates(
        currentPosition, context);
  }

  void resetTrip() {
    setState(() {
      showRideChoice = false;
      searchDestShown = false;
      polylineSet.clear();
      markersSet.clear();
      circlesSet.clear();
      pLineCoordinates.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("TransportEase"),
        backgroundColor: FlutterFlowTheme.of(context).primary,
      ),
      drawer: Drawer(
        elevation: 16,
        child: Column(
          mainAxisSize: MainAxisSize.max,
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
                      width: MediaQuery.sizeOf(context).width * 0.7,
                      height: MediaQuery.sizeOf(context).height * 0.2,
                      decoration: BoxDecoration(),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          FlutterFlowIconButton(
                            borderColor: FlutterFlowTheme.of(context).primary,
                            borderRadius: 20,
                            borderWidth: 1,
                            buttonSize: MediaQuery.sizeOf(context).width * 0.13,
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
                                'Име на корисник',
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
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily:
                                  FlutterFlowTheme.of(context).bodyMediumFamily,
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
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily:
                                  FlutterFlowTheme.of(context).bodyMediumFamily,
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
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily:
                                  FlutterFlowTheme.of(context).bodyMediumFamily,
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
              height: MediaQuery.sizeOf(context).height * 0.5,
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
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(30, 0, 0, 0),
                      child: Text(
                        'Одјави се',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily:
                                  FlutterFlowTheme.of(context).bodyMediumFamily,
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
                  myLocationEnabled: true,
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
                showRideChoice
                    ? Align(
                        alignment: AlignmentDirectional(-0.89, -0.79),
                        child: FlutterFlowIconButton(
                          borderColor: FlutterFlowTheme.of(context).primary,
                          borderRadius: 20,
                          borderWidth: 1,
                          buttonSize: 40,
                          fillColor: FlutterFlowTheme.of(context).info,
                          icon: Icon(
                            Icons.close,
                            color: FlutterFlowTheme.of(context).primary,
                            size: 24,
                          ),
                          onPressed: () {
                            resetTrip();
                          },
                        ),
                      )
                    : Container()
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
                          ? RequestingRideWidget(
                              requestRide: requestRide, cancelRide: cancelRide)
                          : RideChoiceWidget(
                              requestRide: requestRide,
                            ))
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
                                            useGoogleFonts: GoogleFonts.asMap()
                                                .containsKey(
                                                    FlutterFlowTheme.of(context)
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
                                      searchDestShown = !searchDestShown;
                                    });
                                  },
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 20, 0, 0),
                                    child: Container(
                                      width: MediaQuery.sizeOf(context).width *
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
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    20, 0, 0, 0),
                                            child: Icon(
                                              Icons.travel_explore,
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .success,
                                              size: 24,
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    20, 0, 0, 0),
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
                                      width: MediaQuery.sizeOf(context).width *
                                          0.9,
                                      height:
                                          MediaQuery.sizeOf(context).height * 1,
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
                                                    AlignmentDirectional(0, 0),
                                                child: Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(0, 0, 20, 6),
                                                  child: Icon(
                                                    Icons.home,
                                                    color: FlutterFlowTheme.of(
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
                                                        ? Provider.of<AppData>(
                                                                context)
                                                            .pickUpLocation!
                                                            .placeFormattedAddress
                                                        : 'Додади ја локацијата на твојот дом',
                                                    style: FlutterFlowTheme.of(
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
                                                    AlignmentDirectional(0, 0),
                                                child: Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(0, 0, 20, 6),
                                                  child: Icon(
                                                    Icons.work,
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .success,
                                                    size: 16,
                                                  ),
                                                ),
                                              ),
                                              Align(
                                                alignment:
                                                    AlignmentDirectional(0, 0),
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
    );
  }

  Future<void> getPlaceDirection() async {
    var initialPos =
        Provider.of<AppData>(context, listen: false).pickUpLocation;
    var destPos = Provider.of<AppData>(context, listen: false).dropOffLocation;

    var pickupLatLng = LatLng(initialPos!.latitude, initialPos.longitude);
    var destLatLng = LatLng(destPos!.latitude, destPos.longitude);

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
        pLineCoordinates
            .add(LatLng(pointLatLng.latitude, pointLatLng.longitude));
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
            southwest: LatLng(pickupLatLng.latitude, destLatLng.longitude),
            northeast: LatLng(destLatLng.latitude, pickupLatLng.longitude));
      } else if (pickupLatLng.latitude > destLatLng.latitude) {
        latlngBounds = LatLngBounds(
            southwest: LatLng(destLatLng.latitude, pickupLatLng.longitude),
            northeast: LatLng(pickupLatLng.latitude, destLatLng.longitude));
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
}
