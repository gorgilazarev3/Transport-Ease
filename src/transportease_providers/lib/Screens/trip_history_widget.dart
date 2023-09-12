import 'package:flutter/material.dart';
import 'package:transportease_providers/AssistantFunctions/methods_assistants.dart';
import 'package:transportease_providers/flutter_flow/flutter_flow_util.dart';

import '../Models/trip_history.dart';
import '../flutter_flow/flutter_flow_theme.dart';

class TripHistoryWidget extends StatefulWidget {
  final TripHistory tripHistory;

  const TripHistoryWidget({super.key, required this.tripHistory});

  @override
  State<TripHistoryWidget> createState() => _TripHistoryWidgetState();
}

class _TripHistoryWidgetState extends State<TripHistoryWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width,
      height: 150,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Icon(
                        Icons.my_location_outlined,
                        color: FlutterFlowTheme.of(context).secondaryText,
                        size: 24,
                      ),
                      Expanded(
                        child: Text(
                          widget.tripHistory != null
                              ? widget.tripHistory.pickup
                              : 'Локација на поаѓање',
                          style: FlutterFlowTheme.of(context).bodyMedium,
                        ),
                      ),
                    ]
                        .divide(SizedBox(width: 10))
                        .addToStart(SizedBox(width: 5)),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Icon(
                        Icons.location_on,
                        color: FlutterFlowTheme.of(context).secondaryText,
                        size: 24,
                      ),
                      Expanded(
                        child: Text(
                          widget.tripHistory != null
                              ? widget.tripHistory.destination
                              : 'Локација на дестинација',
                          style: FlutterFlowTheme.of(context).bodyMedium,
                        ),
                      ),
                    ]
                        .divide(SizedBox(width: 10))
                        .addToStart(SizedBox(width: 5)),
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: AlignmentDirectional(-1.00, 0.00),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(15, 5, 0, 0),
                      child: Text(
                        widget.tripHistory != null
                            ? MethodsAssistants.formatDateAsString(
                                widget.tripHistory.createdOn)
                            : 'Датум на патување',
                        style: FlutterFlowTheme.of(context).labelSmall,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Text(
            widget.tripHistory != null
                ? widget.tripHistory.fare + ' МКД'
                : '0 МКД',
            style: FlutterFlowTheme.of(context).bodyMedium,
          ),
        ],
      ),
    );
  }
}
