import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_geofire/flutter_geofire.dart';
import 'package:transportease_providers/DataHandler/app_data.dart';
import 'package:transportease_providers/main.dart';

import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:transportease_providers/Models/provider_profile_page_model.dart';
export 'package:transportease_providers/Models/provider_profile_page_model.dart';

class ProviderProfilePageWidget extends StatefulWidget {
  const ProviderProfilePageWidget({Key? key}) : super(key: key);

  @override
  _ProviderProfilePageWidgetState createState() =>
      _ProviderProfilePageWidgetState();
}

class _ProviderProfilePageWidgetState extends State<ProviderProfilePageWidget> {
  late ProviderProfilePageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ProviderProfilePageModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
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
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: SafeArea(
          top: true,
          child: Container(
            width: MediaQuery.sizeOf(context).width,
            height: MediaQuery.sizeOf(context).height * 1,
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).primary,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Align(
                  alignment: AlignmentDirectional(0.00, 0.00),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 50, 0, 0),
                    child: Text(
                      Provider.of<AppData>(context, listen: false)
                                  .driverInformation !=
                              null
                          ? Provider.of<AppData>(context, listen: false)
                              .driverInformation!
                              .name
                          : 'Име Презиме',
                      style:
                          FlutterFlowTheme.of(context).headlineLarge.override(
                                fontFamily: FlutterFlowTheme.of(context)
                                    .headlineLargeFamily,
                                color: FlutterFlowTheme.of(context).info,
                                fontWeight: FontWeight.w900,
                                useGoogleFonts: GoogleFonts.asMap().containsKey(
                                    FlutterFlowTheme.of(context)
                                        .headlineLargeFamily),
                              ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                  child: Text(
                    'Превозник',
                    style: FlutterFlowTheme.of(context).headlineMedium.override(
                          fontFamily:
                              FlutterFlowTheme.of(context).headlineMediumFamily,
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                          useGoogleFonts: GoogleFonts.asMap().containsKey(
                              FlutterFlowTheme.of(context)
                                  .headlineMediumFamily),
                        ),
                  ),
                ),
                SizedBox(
                  width: 200,
                  child: Divider(
                    thickness: 1,
                    color: FlutterFlowTheme.of(context).accent4,
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 50, 0, 0),
                  child: Container(
                    width: MediaQuery.sizeOf(context).width * 0.8,
                    height: MediaQuery.sizeOf(context).height * 0.05,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.phone,
                          color: FlutterFlowTheme.of(context).primary,
                          size: 24,
                        ),
                        Text(
                          Provider.of<AppData>(context, listen: false)
                                      .driverInformation !=
                                  null
                              ? Provider.of<AppData>(context, listen: false)
                                  .driverInformation!
                                  .phone
                              : '077123456',
                          style: FlutterFlowTheme.of(context).titleLarge,
                        ),
                      ]
                          .divide(SizedBox(width: 50))
                          .addToStart(SizedBox(width: 20)),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 50, 0, 0),
                  child: Container(
                    width: MediaQuery.sizeOf(context).width * 0.8,
                    height: MediaQuery.sizeOf(context).height * 0.05,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.email,
                          color: FlutterFlowTheme.of(context).primary,
                          size: 24,
                        ),
                        Text(
                          Provider.of<AppData>(context, listen: false)
                                      .driverInformation !=
                                  null
                              ? Provider.of<AppData>(context, listen: false)
                                  .driverInformation!
                                  .email
                              : 'test@email.com',
                          style: FlutterFlowTheme.of(context).titleLarge,
                        ),
                      ]
                          .divide(SizedBox(width: 50))
                          .addToStart(SizedBox(width: 20)),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 50, 0, 0),
                  child: Container(
                    width: MediaQuery.sizeOf(context).width * 0.8,
                    height: MediaQuery.sizeOf(context).height * 0.05,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.directions_car,
                          color: FlutterFlowTheme.of(context).primary,
                          size: 24,
                        ),
                        Text(
                          Provider.of<AppData>(context, listen: false)
                                      .driverInformation !=
                                  null
                              ? Provider.of<AppData>(context, listen: false)
                                  .driverInformation!
                                  .car_model
                              : 'Toyota Corolla',
                          style: FlutterFlowTheme.of(context).titleLarge,
                        ),
                      ]
                          .divide(SizedBox(width: 50))
                          .addToStart(SizedBox(width: 20)),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 50, 0, 0),
                  child: FFButtonWidget(
                    onPressed: () {
                      Geofire.removeLocation(
                          Provider.of<AppData>(context, listen: false)
                              .loggedInUser!
                              .uid);
                      availableProvidersRef
                          .doc(Provider.of<AppData>(context, listen: false)
                              .loggedInUser!
                              .uid)
                          .delete();
                      rideRequestsRef.onDisconnect();
                      rideRequestsRef.remove();

                      FirebaseAuth.instance.signOut();
                      context.go("/login");
                    },
                    text: 'Одјави се',
                    options: FFButtonOptions(
                      width: MediaQuery.sizeOf(context).width * 0.7,
                      height: MediaQuery.sizeOf(context).height * 0.1,
                      padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                      iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                      color: FlutterFlowTheme.of(context).tertiary,
                      textStyle: FlutterFlowTheme.of(context)
                          .titleLarge
                          .override(
                            fontFamily:
                                FlutterFlowTheme.of(context).titleLargeFamily,
                            color: FlutterFlowTheme.of(context).info,
                            useGoogleFonts: GoogleFonts.asMap().containsKey(
                                FlutterFlowTheme.of(context).titleLargeFamily),
                          ),
                      elevation: 3,
                      borderSide: BorderSide(
                        color: Colors.transparent,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
