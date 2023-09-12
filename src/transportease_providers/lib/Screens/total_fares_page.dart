import 'package:transportease_providers/Screens/trip_history_widget.dart';

import '../AssistantFunctions/methods_assistants.dart';
import '../DataHandler/app_data.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:transportease_providers/Models/total_fares_page_model.dart';
export 'package:transportease_providers/Models/total_fares_page_model.dart';

class TotalFaresPageWidget extends StatefulWidget {
  const TotalFaresPageWidget({Key? key}) : super(key: key);

  @override
  _TotalFaresPageWidgetState createState() => _TotalFaresPageWidgetState();
}

class _TotalFaresPageWidgetState extends State<TotalFaresPageWidget> {
  late TotalFaresPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => TotalFaresPageModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() async {
          MethodsAssistants.clearTripHistory(context);
          await MethodsAssistants.retrieveHistory(context);
        }));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
        child: SizedBox(
          height: MediaQuery.sizeOf(context).height * 9,
          child: GestureDetector(
            onTap: () =>
                FocusScope.of(context).requestFocus(_model.unfocusNode),
            child: Scaffold(
              key: scaffoldKey,
              backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
              body: SafeArea(
                top: true,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: MediaQuery.sizeOf(context).width,
                      height: MediaQuery.sizeOf(context).height * 0.2,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).primary,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Align(
                                alignment: AlignmentDirectional(0.00, 0.00),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 20, 0, 0),
                                  child: Text(
                                    'Вкупна заработка',
                                    style: FlutterFlowTheme.of(context)
                                        .labelLarge
                                        .override(
                                          fontFamily:
                                              FlutterFlowTheme.of(context)
                                                  .labelLargeFamily,
                                          color:
                                              FlutterFlowTheme.of(context).info,
                                          fontSize: 20,
                                          useGoogleFonts: GoogleFonts.asMap()
                                              .containsKey(
                                                  FlutterFlowTheme.of(context)
                                                      .labelLargeFamily),
                                        ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                                child: Text(
                                  Provider.of<AppData>(context, listen: false)
                                          .earnings +
                                      ' МКД',
                                  style: FlutterFlowTheme.of(context)
                                      .headlineLarge
                                      .override(
                                        fontFamily: FlutterFlowTheme.of(context)
                                            .headlineLargeFamily,
                                        color:
                                            FlutterFlowTheme.of(context).info,
                                        fontWeight: FontWeight.bold,
                                        useGoogleFonts: GoogleFonts.asMap()
                                            .containsKey(
                                                FlutterFlowTheme.of(context)
                                                    .headlineLargeFamily),
                                      ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: MediaQuery.sizeOf(context).width,
                          height: MediaQuery.sizeOf(context).height * 0.1,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Align(
                                alignment: AlignmentDirectional(0.00, -1.00),
                                child: Container(
                                  width: MediaQuery.sizeOf(context).width,
                                  height:
                                      MediaQuery.sizeOf(context).height * 0.1,
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                    border: Border.all(
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: Image.asset(
                                          'assets/images/regular_car_render.png',
                                          width: MediaQuery.sizeOf(context)
                                                      .width >=
                                                  768
                                              ? MediaQuery.sizeOf(context)
                                                      .width *
                                                  0.1
                                              : MediaQuery.sizeOf(context)
                                                      .width *
                                                  0.3,
                                          height: MediaQuery.sizeOf(context)
                                                      .width >=
                                                  768
                                              ? MediaQuery.sizeOf(context)
                                                      .height *
                                                  0.3
                                              : MediaQuery.sizeOf(context)
                                                      .height *
                                                  1,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Text(
                                        'Вкупно патувања',
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium,
                                      ),
                                      Text(
                                        Provider.of<AppData>(context,
                                                listen: false)
                                            .numTrips
                                            .toString(),
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium,
                                      ),
                                    ]
                                        .addToStart(SizedBox(width: 1))
                                        .addToEnd(SizedBox(width: 1)),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          thickness: 1,
                          color: FlutterFlowTheme.of(context).accent4,
                        ),
                        SingleChildScrollView(
                          child: ListView.separated(
                              itemBuilder: (context, index) {
                                return TripHistoryWidget(
                                    tripHistory: Provider.of<AppData>(context,
                                            listen: false)
                                        .tripHistoryData[index]);
                              },
                              separatorBuilder: (context, index) {
                                return Divider(
                                  thickness: 3.0,
                                  height: 3.0,
                                );
                              },
                              shrinkWrap: true,
                              physics: ClampingScrollPhysics(),
                              itemCount:
                                  Provider.of<AppData>(context, listen: false)
                                      .tripHistoryData
                                      .length),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
