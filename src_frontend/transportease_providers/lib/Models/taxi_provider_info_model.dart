import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class TaxiProviderInformationModel extends FlutterFlowModel {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // State field(s) for TabBar widget.
  TabController? tabBarController;
  int get tabBarCurrentIndex =>
      tabBarController != null ? tabBarController!.index : 0;

  // State field(s) for taxiCompanyName widget.
  TextEditingController? taxiCompanyNameController;
  String? Function(BuildContext, String?)? taxiCompanyNameControllerValidator;
  // State field(s) for licensePlate widget.
  TextEditingController? licensePlateController;
  String? Function(BuildContext, String?)? licensePlateControllerValidator;
  // State field(s) for taxiSeats widget.
  TextEditingController? taxiSeatsController;
  String? Function(BuildContext, String?)? taxiSeatsControllerValidator;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {}

  void dispose() {
    unfocusNode.dispose();
    tabBarController?.dispose();
    taxiCompanyNameController?.dispose();
    licensePlateController?.dispose();
    taxiSeatsController?.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
