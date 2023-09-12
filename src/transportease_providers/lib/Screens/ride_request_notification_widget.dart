import 'package:firebase_database/firebase_database.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:transportease_providers/AssistantFunctions/methods_assistants.dart';
import 'package:transportease_providers/Screens/new_ride_request_page.dart';
import 'package:transportease_providers/main.dart';

import '../DataHandler/app_data.dart';
import '../Models/ride_details.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../Models/ride_request_notification_model.dart';
export '../Models/ride_request_notification_model.dart';

class RideRequestNotificationWidget extends StatefulWidget {
  const RideRequestNotificationWidget({Key? key, required this.rideDetails})
      : super(key: key);

  final RideDetails rideDetails;

  @override
  _RideRequestNotificationWidgetState createState() =>
      _RideRequestNotificationWidgetState(rideDetails: this.rideDetails);
}

class _RideRequestNotificationWidgetState
    extends State<RideRequestNotificationWidget> {
  late RideRequestNotificationModel _model;

  _RideRequestNotificationWidgetState({required this.rideDetails});

  final RideDetails rideDetails;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => RideRequestNotificationModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            width: MediaQuery.sizeOf(context).width,
            height: MediaQuery.sizeOf(context).height * 0.4,
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).secondaryBackground,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Align(
                      alignment: AlignmentDirectional(0, -1),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                        child: Container(
                          width: MediaQuery.sizeOf(context).width * 0.8,
                          height: 100,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context).primary,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Align(
                            alignment: AlignmentDirectional(0, 0),
                            child: Text(
                              'НОВО БАРАЊЕ ЗА ПРЕВОЗ',
                              textAlign: TextAlign.center,
                              style: FlutterFlowTheme.of(context)
                                  .headlineMedium
                                  .override(
                                    fontFamily: FlutterFlowTheme.of(context)
                                        .headlineMediumFamily,
                                    color: FlutterFlowTheme.of(context).info,
                                    fontWeight: FontWeight.bold,
                                    useGoogleFonts: GoogleFonts.asMap()
                                        .containsKey(
                                            FlutterFlowTheme.of(context)
                                                .headlineMediumFamily),
                                  ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 20),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.my_location,
                            color: FlutterFlowTheme.of(context).secondaryText,
                            size: 30,
                          ),
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: Text(
                                rideDetails.pickUpAddress,
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: FlutterFlowTheme.of(context)
                                          .bodyMediumFamily,
                                      fontWeight: FontWeight.w500,
                                      useGoogleFonts: GoogleFonts.asMap()
                                          .containsKey(
                                              FlutterFlowTheme.of(context)
                                                  .bodyMediumFamily),
                                    ),
                                textAlign: TextAlign.start,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 20),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.location_on,
                            color: FlutterFlowTheme.of(context).secondaryText,
                            size: 30,
                          ),
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: Text(
                                rideDetails.destinationAddress,
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: FlutterFlowTheme.of(context)
                                          .bodyMediumFamily,
                                      fontWeight: FontWeight.w500,
                                      useGoogleFonts: GoogleFonts.asMap()
                                          .containsKey(
                                              FlutterFlowTheme.of(context)
                                                  .bodyMediumFamily),
                                    ),
                                textAlign: TextAlign.start,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      thickness: 1,
                      color: FlutterFlowTheme.of(context).primary,
                    ),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    FFButtonWidget(
                      onPressed: () {
                        Provider.of<AppData>(context, listen: false)
                            .audioPlayer
                            .stop();
                        Navigator.pop(context);
                      },
                      text: 'Одбиј',
                      options: FFButtonOptions(
                        height: 40,
                        padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                        iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                        color: FlutterFlowTheme.of(context).error,
                        textStyle: FlutterFlowTheme.of(context)
                            .titleSmall
                            .override(
                              fontFamily:
                                  FlutterFlowTheme.of(context).titleSmallFamily,
                              color: Colors.white,
                              useGoogleFonts: GoogleFonts.asMap().containsKey(
                                  FlutterFlowTheme.of(context)
                                      .titleSmallFamily),
                            ),
                        elevation: 3,
                        borderSide: BorderSide(
                          color: Colors.transparent,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    FFButtonWidget(
                      onPressed: () {
                        Provider.of<AppData>(context, listen: false)
                            .audioPlayer
                            .stop();
                        checkProviderAvailability();
                        Navigator.pop(context);
                      },
                      text: 'Прифати',
                      options: FFButtonOptions(
                        height: 40,
                        padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                        iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                        color: FlutterFlowTheme.of(context).success,
                        textStyle: FlutterFlowTheme.of(context)
                            .titleSmall
                            .override(
                              fontFamily:
                                  FlutterFlowTheme.of(context).titleSmallFamily,
                              color: Colors.white,
                              useGoogleFonts: GoogleFonts.asMap().containsKey(
                                  FlutterFlowTheme.of(context)
                                      .titleSmallFamily),
                            ),
                        elevation: 3,
                        borderSide: BorderSide(
                          color: Colors.transparent,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void checkProviderAvailability() async {
    DataSnapshot providerSnap = await rideRequestsRef.get();
    String rideId = "";
    if (providerSnap.value != null) {
      var data = providerSnap.value;
      if (data != null) {
        rideId = data.toString();
      } else {
        Fluttertoast.showToast(msg: "Не постои такво барање за превоз!");
      }

      if (rideId == rideDetails.rideRequestId) {
        rideRequestsRef.set("accepted");
        Position currentPosition =
            Provider.of<AppData>(context, listen: false).currentPosition ??
                Position(
                    longitude: rideDetails.pickUpLocation.longitude,
                    latitude: rideDetails.pickUpLocation.latitude,
                    timestamp: DateTime.now(),
                    accuracy: 1,
                    altitude: 1,
                    heading: 1,
                    speed: 1,
                    speedAccuracy: 1);
        MethodsAssistants.disableLiveLocationUpdatesOfProvider(context);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => NewRidePageWidget(
                    rideDetails: rideDetails,
                    currentPosition: currentPosition)));
      } else if (rideId == "cancelled") {
        Fluttertoast.showToast(msg: "Барањето за превоз е откажано.");
      } else if (rideId == "timeout") {
        Fluttertoast.showToast(msg: "Времето за барањето за превоз истече.");
      } else {
        Fluttertoast.showToast(msg: "Не постои такво барање за превоз!");
      }
    }
  }
}
