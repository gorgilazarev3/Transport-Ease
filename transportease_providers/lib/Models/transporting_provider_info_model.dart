import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_radio_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class TransportProviderInformationModel extends FlutterFlowModel {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // State field(s) for TabBar widget.
  TabController? tabBarController;
  int get tabBarCurrentIndex =>
      tabBarController != null ? tabBarController!.index : 0;

  // State field(s) for providerType widget.
  FormFieldController<String>? providerTypeValueController;
  // State field(s) for transportingType widget.
  FormFieldController<String>? transportingTypeValueController;
  // State field(s) for taxiSeats widget.
  TextEditingController? taxiSeatsController;
  String? Function(BuildContext, String?)? taxiSeatsControllerValidator;
  // State field(s) for carrierCapacity widget.
  TextEditingController? carrierCapacityController;
  String? Function(BuildContext, String?)? carrierCapacityControllerValidator;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {}

  void dispose() {
    unfocusNode.dispose();
    tabBarController?.dispose();
    taxiSeatsController?.dispose();
    carrierCapacityController?.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.

  String? get providerTypeValue => providerTypeValueController?.value;
  String? get transportingTypeValue => transportingTypeValueController?.value;
}
