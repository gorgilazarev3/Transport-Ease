import 'package:firebase_database/firebase_database.dart';

import '../AssistantFunctions/methods_assistants.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';

import 'package:transportease/Models/rating_dialog_model.dart';
export 'package:transportease/Models/rating_dialog_model.dart';

class RatingDialogWidget extends StatefulWidget {
  const RatingDialogWidget({
    Key? key,
    required this.driverId,
  }) : super(key: key);
  final String driverId;

  @override
  _RatingDialogWidgetState createState() => _RatingDialogWidgetState();
}

class _RatingDialogWidgetState extends State<RatingDialogWidget> {
  late RatingDialogModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  String title = "";
  double starCount = 0.0;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => RatingDialogModel());

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
        backgroundColor: Colors.transparent,
        body: SafeArea(
          top: true,
          // child: Column(
          //   mainAxisSize: MainAxisSize.min,
          //   children: [
          child: Align(
            alignment: AlignmentDirectional(0, 0),
            child: Container(
              width: MediaQuery.sizeOf(context).width >= 768
                  ? MediaQuery.sizeOf(context).width * 0.6
                  : MediaQuery.sizeOf(context).width * 0.8,
              height: MediaQuery.sizeOf(context).height * 0.4,
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).secondaryBackground,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: MediaQuery.sizeOf(context).width >= 768
                            ? MediaQuery.sizeOf(context).width * 0.6
                            : MediaQuery.sizeOf(context).width * 0.8,
                        height: MediaQuery.sizeOf(context).height * 0.07,
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).alternate,
                        ),
                        child: Align(
                          alignment: AlignmentDirectional(0, 0),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                            child: Text(
                              'Оцени го овој превозник',
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: FlutterFlowTheme.of(context)
                                        .bodyMediumFamily,
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryText,
                                    fontWeight: FontWeight.w600,
                                    useGoogleFonts: GoogleFonts.asMap()
                                        .containsKey(
                                            FlutterFlowTheme.of(context)
                                                .bodyMediumFamily),
                                  ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Align(
                      alignment: AlignmentDirectional(0, 0),
                      child: SmoothStarRating(
                        rating: starCount,
                        color: Colors.yellow,
                        allowHalfRating: false,
                        starCount: 5,
                        size: 45,
                        onRatingChanged: (rating) {
                          setState(() {
                            starCount = rating;
                          });
                          if (starCount == 0 || starCount == 1) {
                            setState(() {
                              title = "Многу лошо";
                            });
                          } else if (starCount == 2) {
                            setState(() {
                              title = "Лошо";
                            });
                          } else if (starCount == 3) {
                            setState(() {
                              title = "Добро";
                            });
                          } else if (starCount == 4) {
                            setState(() {
                              title = "Многу добро";
                            });
                          } else if (starCount == 5) {
                            setState(() {
                              title = "Одлично";
                            });
                          }
                        },
                      )),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                          child: Text(
                            title,
                            textAlign: TextAlign.center,
                            style: FlutterFlowTheme.of(context).bodyLarge,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          DatabaseReference ratingsRef = FirebaseDatabase
                              .instance
                              .ref()
                              .child("providers")
                              .child(widget.driverId)
                              .child("ratings");
                          var snap = await ratingsRef.get();
                          if (snap.value != null) {
                            double oldRating =
                                double.parse(snap.value.toString());
                            double avg = oldRating + starCount;
                            avg /= 2;
                            ratingsRef.set(avg.toString());
                          } else {
                            ratingsRef.set(starCount.toString());
                          }

                          Navigator.pop(context, "rated");
                        },
                        child: Align(
                          alignment: AlignmentDirectional(0, 1),
                          child: Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                            child: Container(
                              width: MediaQuery.sizeOf(context).width >= 768
                                  ? MediaQuery.sizeOf(context).width * 0.4
                                  : MediaQuery.sizeOf(context).width * 0.6,
                              height: 65,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context).primary,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Align(
                                    alignment: AlignmentDirectional(-1, 0),
                                    child: Text(
                                      'Поднеси',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMediumFamily,
                                            color: FlutterFlowTheme.of(context)
                                                .info,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                            useGoogleFonts: GoogleFonts.asMap()
                                                .containsKey(
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMediumFamily),
                                          ),
                                    ),
                                  ),
                                  Icon(
                                    Icons.star,
                                    color: FlutterFlowTheme.of(context).info,
                                    size: 36,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          //   ],
          // ),
        ),
      ),
    );
  }
}
