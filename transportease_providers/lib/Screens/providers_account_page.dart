import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:transportease_providers/Models/providers_account_page_model.dart';
export 'package:transportease_providers/Models/providers_account_page_model.dart';

class ProviderAccountPageWidget extends StatefulWidget {
  const ProviderAccountPageWidget({Key? key}) : super(key: key);

  @override
  _ProviderAccountPageWidgetState createState() =>
      _ProviderAccountPageWidgetState();
}

class _ProviderAccountPageWidgetState extends State<ProviderAccountPageWidget> {
  late ProviderAccountPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ProviderAccountPageModel());

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
