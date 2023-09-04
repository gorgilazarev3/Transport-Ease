import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:transportease_providers/Models/providers_earnings_page_model.dart';
export 'package:transportease_providers/Models/providers_earnings_page_model.dart';

class ProviderEarningsPageWidget extends StatefulWidget {
  const ProviderEarningsPageWidget({Key? key}) : super(key: key);

  @override
  _ProviderEarningsPageWidgetState createState() =>
      _ProviderEarningsPageWidgetState();
}

class _ProviderEarningsPageWidgetState
    extends State<ProviderEarningsPageWidget> {
  late ProviderEarningsPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ProviderEarningsPageModel());

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
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [],
          ),
        ),
      ),
    );
  }
}
