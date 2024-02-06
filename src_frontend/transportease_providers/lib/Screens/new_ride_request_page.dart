import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as MapsLocation;
import 'package:transportease_providers/AssistantFunctions/maps_toolkit_assistant.dart';
import 'package:transportease_providers/main.dart';
import 'package:wtf_sliding_sheet/wtf_sliding_sheet.dart';

import '../AssistantFunctions/methods_assistants.dart';
import '../DataHandler/app_data.dart';
import '../Models/driver.dart';
import '../Models/ride_details.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:transportease_providers/Models/new_ride_request_model.dart';

import 'fare_dialog.dart';
export 'package:transportease_providers/Models/new_ride_request_model.dart';

class NewRidePageWidget extends StatefulWidget {
  const NewRidePageWidget(
      {Key? key, required this.rideDetails, required this.currentPosition})
      : super(key: key);

  final RideDetails rideDetails;
  final Position currentPosition;

  @override
  _NewRidePageWidgetState createState() => _NewRidePageWidgetState(
      rideDetails: this.rideDetails, currentPosition: this.currentPosition);
}

class _NewRidePageWidgetState extends State<NewRidePageWidget> {
  _NewRidePageWidgetState(
      {required this.rideDetails, required this.currentPosition});

  late NewRidePageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final RideDetails rideDetails;

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: MapsLocation.LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  late GoogleMapController googleMapController;

  final Position currentPosition;

  late Position myPosition;

  Set<Marker> markersSet = {};
  Set<Circle> circlesSet = {};
  Set<Polyline> polylineSet = {};
  List<MapsLocation.LatLng> pLineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();

  var geolocator = Geolocator();
  var locationsOptions =
      LocationSettings(accuracy: LocationAccuracy.bestForNavigation);
  BitmapDescriptor? animatingMarkerIcon;

  String btnTitle = "СЕ НАОЃАМ НА ЛОКАЦИЈАТА";
  Color btnColor = const Color.fromARGB(255, 0, 71, 80);
  String status = "accepted";
  bool isRequestingDirection = false;
  Timer? timer;
  int duration = 0;
  String durationText = "x минути";
  String rideType = "regular";

  void locatePosition() async {
    MapsLocation.LatLng latLngPosition = MapsLocation.LatLng(
        currentPosition.latitude, currentPosition.longitude);

    CameraPosition cameraPosition =
        new CameraPosition(target: latLngPosition, zoom: 14);

    googleMapController
        .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
    await createIconMarker();

    // Address address = await MethodsAssistants.getAddressFromCoordinates(
    //     currentPosition, context);
  }

  Future<void> createIconMarker() async {
    if (animatingMarkerIcon == null) {
      ImageConfiguration imageConfiguration =
          createLocalImageConfiguration(context, size: const Size(0.1, 0.1));
      var icon = BitmapDescriptor.defaultMarker;
      DataSnapshot providerSnap = await providersRef
          .child(Provider.of<AppData>(context, listen: false).loggedInUser!.uid)
          .get();
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
      setState(() {
        animatingMarkerIcon = icon;
      });
    }
  }

  void getRideLiveLocationUpdates() {
    MapsLocation.LatLng oldPos = MapsLocation.LatLng(0, 0);

    StreamSubscription<Position> rideStreamSub =
        Geolocator.getPositionStream().listen((Position position) {
      myPosition = position;
      MapsLocation.LatLng mPosition =
          MapsLocation.LatLng(position.latitude, position.longitude);

      double rot = MapsToolkitAssistant.getMarkerRotation(oldPos.latitude,
          oldPos.longitude, mPosition.latitude, mPosition.longitude);

      Marker animatingMarker = Marker(
          markerId: MarkerId("animating"),
          position: mPosition,
          icon: animatingMarkerIcon!,
          rotation: rot,
          infoWindow: InfoWindow(title: "Моментална локација"));

      setState(() {
        CameraPosition cameraPosition =
            new CameraPosition(target: mPosition, zoom: 17);
        googleMapController
            .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
      });

      markersSet
          .removeWhere((element) => element.markerId.value == "animating");
      markersSet.add(animatingMarker);

      oldPos = mPosition;
      updateRideDetails();
      Map location = {
        "latitude": currentPosition.latitude.toString(),
        "longitude": currentPosition.longitude.toString()
      };

      newRideRequestsRef
          .child(widget.rideDetails.rideRequestId)
          .child("driver_location")
          .set(location);
    });

    Provider.of<AppData>(context, listen: false).updateRideSub(rideStreamSub);
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => NewRidePageModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {
          setRideType();
        }));
    acceptRideRequest();
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  void setRideType() async {
    DataSnapshot rideSnap = await providersRef
        .child(Provider.of<AppData>(context, listen: false).loggedInUser!.uid)
        .child("role")
        .get();
    if (rideSnap.exists && rideSnap.value != null) {
      String valueType = rideSnap.value.toString();
      List<String> values = valueType.split("_");
      setState(() {
        rideType = values[0];
      });
      Provider.of<AppData>(context, listen: false).updateRideType(values[0]);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (btnTitle.toUpperCase() == "СЕ НАОЃАМ НА ЛОКАЦИЈАТА") {
      btnColor = FlutterFlowTheme.of(context).primary;
    }

    return GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(_model.unfocusNode),
        child: Scaffold(
            resizeToAvoidBottomInset: false,
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
                        markers: markersSet,
                        circles: circlesSet,
                        polylines: polylineSet,
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
                          locatePosition(),
                          getPlaceDirection(
                              MapsLocation.LatLng(currentPosition.latitude,
                                  currentPosition.longitude),
                              widget.rideDetails.pickUpLocation),
                          getRideLiveLocationUpdates()
                        },
                      ),
                    ],
                  ),
                  builder: (context, state) {
                    // This is the content of the sheet that will get
                    // scrolled, if the content is bigger than the available
                    // height of the sheet.
                    return SingleChildScrollView(
                        child: SingleChildScrollView(
                      child: Column(mainAxisSize: MainAxisSize.max, children: [
                        Container(
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
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Align(
                                alignment: AlignmentDirectional(0, 0),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      10, 8, 0, 0),
                                  child: Text(
                                    // Provider.of<AppData>(context).tripDetails !=
                                    //         null
                                    //     ? Provider.of<AppData>(context)
                                    //         .tripDetails!
                                    //         .durationText
                                    //     : 'x минути',
                                    durationText,
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMediumFamily,
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryText,
                                          fontWeight: FontWeight.normal,
                                          useGoogleFonts: GoogleFonts.asMap()
                                              .containsKey(
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMediumFamily),
                                        ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    10, 0, 20, 0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Align(
                                      alignment: AlignmentDirectional(-1, 0),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            10, 8, 0, 0),
                                        child: Text(
                                          rideDetails.riderName,
                                          style: FlutterFlowTheme.of(context)
                                              .bodyLarge
                                              .override(
                                                fontFamily:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyLargeFamily,
                                                fontSize: 20,
                                                fontWeight: FontWeight.w600,
                                                useGoogleFonts: GoogleFonts
                                                        .asMap()
                                                    .containsKey(
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyLargeFamily),
                                              ),
                                        ),
                                      ),
                                    ),
                                    Icon(
                                      Icons.phone_android,
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryText,
                                      size: 24,
                                    ),
                                  ],
                                ),
                              ),
                              Align(
                                alignment: AlignmentDirectional(0, 1),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 20, 0, 0),
                                  child: Container(
                                    width:
                                        MediaQuery.sizeOf(context).width * 0.9,
                                    height: MediaQuery.sizeOf(context).height *
                                        0.17,
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
                                                  Icons.my_location,
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondaryText,
                                                  size: 16,
                                                ),
                                              ),
                                            ),
                                            Align(
                                              alignment:
                                                  AlignmentDirectional(0, 0),
                                              child: Text(
                                                rideDetails.pickUpAddress,
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Opacity(
                                          opacity: 0.8,
                                          child: Divider(
                                            thickness: 1,
                                            color: FlutterFlowTheme.of(context)
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
                                                  Icons.location_on,
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondaryText,
                                                  size: 16,
                                                ),
                                              ),
                                            ),
                                            Align(
                                              alignment:
                                                  AlignmentDirectional(0, 0),
                                              child: Text(
                                                rideDetails.destinationAddress,
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0, 20, 0, 0),
                                          child: FFButtonWidget(
                                            onPressed: () async {
                                              if (status == "accepted") {
                                                status = "arrived";
                                                newRideRequestsRef
                                                    .child(widget.rideDetails
                                                        .rideRequestId)
                                                    .child("status")
                                                    .set(status);

                                                setState(() {
                                                  btnTitle =
                                                      "ЗАПОЧНИ СО ПАТУВАЊЕТО";
                                                  btnColor =
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .tertiary;
                                                });

                                                showDialog(
                                                    context: context,
                                                    barrierDismissible: false,
                                                    builder: ((context) =>
                                                        AlertDialog(
                                                            content: Text(
                                                                "Ве молиме почекајте"))));

                                                await getPlaceDirection(
                                                    widget.rideDetails
                                                        .pickUpLocation,
                                                    widget.rideDetails
                                                        .destinationLocation);

                                                Navigator.pop(context);
                                              } else if (status == "arrived") {
                                                status = "in_progress";
                                                newRideRequestsRef
                                                    .child(widget.rideDetails
                                                        .rideRequestId)
                                                    .child("status")
                                                    .set(status);

                                                setState(() {
                                                  btnTitle =
                                                      "ПРИСТИГНАВ НА ДЕСТИНАЦИЈАТА";
                                                  btnColor =
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .error;
                                                });

                                                initTimer();
                                              } else if (status ==
                                                  "in_progress") {
                                                await endTrip();
                                              }
                                            },
                                            text: btnTitle,
                                            options: FFButtonOptions(
                                              height: 40,
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(24, 0, 24, 0),
                                              iconPadding: EdgeInsetsDirectional
                                                  .fromSTEB(0, 0, 0, 0),
                                              color: btnColor,
                                              textStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .titleSmall
                                                      .override(
                                                        fontFamily:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .titleSmallFamily,
                                                        color: Colors.white,
                                                        useGoogleFonts: GoogleFonts
                                                                .asMap()
                                                            .containsKey(
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .titleSmallFamily),
                                                      ),
                                              elevation: 3,
                                              borderSide: BorderSide(
                                                color: Colors.transparent,
                                                width: 1,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(8),
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
                        ),
                      ]),
                    ));
                  })
            ])));
  }

  Future<void> getPlaceDirection(
      MapsLocation.LatLng pickupLatLng, MapsLocation.LatLng destLatLng) async {
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
          position: pickupLatLng,
          markerId: MarkerId("PickupID"));

      Marker destLocationMarker = Marker(
          icon: BitmapDescriptor.defaultMarkerWithHue(
              HSLColor.fromColor(FlutterFlowTheme.of(context).info).hue),
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

  void acceptRideRequest() {
    String rideRequestId = widget.rideDetails.rideRequestId;
    newRideRequestsRef.child(rideRequestId).child("status").set("accepted");
    Driver? availableDriver =
        Provider.of<AppData>(context, listen: false).driverInformation;
    newRideRequestsRef
        .child(rideRequestId)
        .child("driver_name")
        .set(availableDriver!.name);
    newRideRequestsRef
        .child(rideRequestId)
        .child("driver_phone")
        .set(availableDriver!.phone);
    newRideRequestsRef
        .child(rideRequestId)
        .child("driver_id")
        .set(availableDriver!.id);
    newRideRequestsRef
        .child(rideRequestId)
        .child("car_details")
        .set("${availableDriver.car_color} ${availableDriver.car_model}");
    newRideRequestsRef
        .child(rideRequestId)
        .child("car_plates")
        .set(availableDriver!.license_plate);

    providersRef
        .child(availableDriver.id)
        .child("history")
        .child(rideRequestId)
        .set(true);

    Map location = {
      "latitude": currentPosition.latitude.toString(),
      "longitude": currentPosition.longitude.toString()
    };

    newRideRequestsRef
        .child(rideRequestId)
        .child("driver_location")
        .set(location);
  }

  void initTimer() {
    const interval = Duration(seconds: 1);
    timer = Timer.periodic(interval, (timer) {
      duration++;
    });
  }

  Future<void> endTrip() async {
    timer!.cancel();
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: ((context) =>
            AlertDialog(content: Text("Ве молиме почекајте"))));

    var currentLatLng =
        MapsLocation.LatLng(myPosition.latitude, myPosition.longitude);

    var destDetails = await MethodsAssistants.obtainDirectionDetails(
        widget.rideDetails.pickUpLocation, currentLatLng);

    Navigator.pop(context);

    int fareAmount = MethodsAssistants.calculateFare(
        destDetails, Provider.of<AppData>(context, listen: false).rideType);

    status = "finished";

    newRideRequestsRef
        .child(widget.rideDetails.rideRequestId)
        .child("fare")
        .set(fareAmount.toString());
    newRideRequestsRef
        .child(widget.rideDetails.rideRequestId)
        .child("status")
        .set(status);

    Provider.of<AppData>(context, listen: false).cancelRideSub();

    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => FareDialogWidget(
            fareAmount: fareAmount,
            paymentMethod: widget.rideDetails.paymentMethod));

    saveEarnings(fareAmount);
  }

  Future<void> updateRideDetails() async {
    if (isRequestingDirection == false) {
      isRequestingDirection = true;
      if (myPosition == null) {
        return;
      }

      var posLatLng =
          MapsLocation.LatLng(myPosition.latitude, myPosition.longitude);
      MapsLocation.LatLng destLatLng;
      if (status == "accepted") {
        destLatLng = widget.rideDetails.pickUpLocation;
      } else {
        destLatLng = widget.rideDetails.destinationLocation;
      }

      var dirDetails =
          await MethodsAssistants.obtainDirectionDetails(posLatLng, destLatLng);
      if (dirDetails != null) {
        setState(() {
          durationText = dirDetails.durationText;
        });
      }

      isRequestingDirection = false;
    }
  }

  Future<void> saveEarnings(int fareAmount) async {
    DataSnapshot snap = await providersRef
        .child(Provider.of<AppData>(context, listen: false).loggedInUser!.uid)
        .child("earnings")
        .get();
    if (snap.value != null) {
      double oldEarnings = double.parse(snap.value.toString());
      double totalEarnings = fareAmount + oldEarnings;
      providersRef
          .child(Provider.of<AppData>(context, listen: false).loggedInUser!.uid)
          .child("earnings")
          .set(totalEarnings.toStringAsFixed(2));
    } else {
      double totalEarnings = fareAmount.toDouble();
      providersRef
          .child(Provider.of<AppData>(context, listen: false).loggedInUser!.uid)
          .child("earnings")
          .set(totalEarnings.toStringAsFixed(2));
    }
  }
}
