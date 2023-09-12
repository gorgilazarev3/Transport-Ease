import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';
import 'package:transportease_providers/DataHandler/app_data.dart';

import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:transportease_providers/Models/providers_ratings_page_model.dart';
export 'package:transportease_providers/Models/providers_ratings_page_model.dart';

class ProviderRatingsPageWidget extends StatefulWidget {
  const ProviderRatingsPageWidget({Key? key}) : super(key: key);

  @override
  _ProviderRatingsPageWidgetState createState() =>
      _ProviderRatingsPageWidgetState();
}

class _ProviderRatingsPageWidgetState extends State<ProviderRatingsPageWidget> {
  late ProviderRatingsPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ProviderRatingsPageModel());

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
        backgroundColor: FlutterFlowTheme.of(context).primary,
        body: SafeArea(
          top: true,
          // child: Column(
          //   mainAxisSize: MainAxisSize.min,
          //   children: [
          child: Align(
            alignment: AlignmentDirectional(0, 0),
            child: Container(
              width: MediaQuery.sizeOf(context).width * 0.8,
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
                        width: MediaQuery.sizeOf(context).width * 0.8,
                        height: MediaQuery.sizeOf(context).height * 0.07,
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).accent1,
                        ),
                        child: Align(
                          alignment: AlignmentDirectional(0, 0),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                            child: Text(
                              'Клиентите ве оценија со',
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: FlutterFlowTheme.of(context)
                                        .bodyMediumFamily,
                                    color: FlutterFlowTheme.of(context).info,
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
                        rating: Provider.of<AppData>(context, listen: false)
                            .starCount,
                        color: Colors.yellow,
                        allowHalfRating: true,
                        starCount: 5,
                        size: 45,
                      )),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                          child: Text(
                            Provider.of<AppData>(context, listen: false)
                                    .title
                                    .isEmpty
                                ? "Неоценет"
                                : Provider.of<AppData>(context, listen: false)
                                    .title,
                            textAlign: TextAlign.center,
                            style: FlutterFlowTheme.of(context).bodyLarge,
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
