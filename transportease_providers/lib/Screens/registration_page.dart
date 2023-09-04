// import '/auth/firebase_auth/auth_util.dart';
// import '/flutter_flow/flutter_flow_animations.dart';
//import 'dart:js_interop';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../Models/registration_model.dart';
import '../flutter_flow/flutter_flow_animations.dart';
import '../flutter_flow/flutter_flow_radio_button.dart';
import '../flutter_flow/form_field_controller.dart';
import '../main.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '/Models/registration_model.dart';
export '/Models/registration_model.dart';

class RegistrationPageWidget extends StatefulWidget {
  const RegistrationPageWidget({Key? key}) : super(key: key);

  @override
  _RegistrationPageWidgetState createState() => _RegistrationPageWidgetState();
}

class _RegistrationPageWidgetState extends State<RegistrationPageWidget>
    with TickerProviderStateMixin {
  late RegistrationPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = {
    'containerOnPageLoadAnimation': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        VisibilityEffect(duration: 1.ms),
        FadeEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 400.ms,
          begin: 0,
          end: 1,
        ),
        MoveEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 400.ms,
          begin: Offset(0, 80),
          end: Offset(0, 0),
        ),
        ScaleEffect(
          curve: Curves.easeInOut,
          delay: 150.ms,
          duration: 400.ms,
          begin: Offset(0.8, 0.8),
          end: Offset(1, 1),
        ),
      ],
    ),
    'columnOnPageLoadAnimation1': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        VisibilityEffect(duration: 300.ms),
        FadeEffect(
          curve: Curves.easeInOut,
          delay: 300.ms,
          duration: 400.ms,
          begin: 0,
          end: 1,
        ),
        MoveEffect(
          curve: Curves.easeInOut,
          delay: 300.ms,
          duration: 400.ms,
          begin: Offset(0, 20),
          end: Offset(0, 0),
        ),
      ],
    ),
    'columnOnPageLoadAnimation2': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        VisibilityEffect(duration: 300.ms),
        FadeEffect(
          curve: Curves.easeInOut,
          delay: 300.ms,
          duration: 400.ms,
          begin: 0,
          end: 1,
        ),
        MoveEffect(
          curve: Curves.easeInOut,
          delay: 300.ms,
          duration: 400.ms,
          begin: Offset(0, 20),
          end: Offset(0, 0),
        ),
      ],
    ),
  };

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => RegistrationPageModel());

    _model.tabBarController = TabController(
      vsync: this,
      length: 2,
      initialIndex: 0,
    );
    _model.emailAddressController1 ??= TextEditingController();
    _model.nameController ??= TextEditingController();
    _model.phoneNumberController ??= TextEditingController();
    _model.passwordController1 ??= TextEditingController();
    _model.confirmPasswordController ??= TextEditingController();
    _model.emailAddressController2 ??= TextEditingController();
    _model.passwordController2 ??= TextEditingController();
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
        backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
        body: SafeArea(
          top: true,
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(32, 32, 32, 32),
                child: Container(
                  width: double.infinity,
                  height: 300,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).primaryBackground,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  alignment: AlignmentDirectional(0, 0),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 72),
                    child: AutoSizeText(
                      'TransportEase - Превозници',
                      style: FlutterFlowTheme.of(context).displaySmall,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional(0, -1),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 170, 0, 0),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding:
                              EdgeInsetsDirectional.fromSTEB(12, 12, 12, 12),
                          child: Container(
                            width: double.infinity,
                            height: MediaQuery.sizeOf(context).width >= 768.0
                                ? 530.0
                                : 630.0,
                            constraints: BoxConstraints(
                              maxWidth: 570,
                            ),
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 4,
                                  color: Color(0x33000000),
                                  offset: Offset(0, 2),
                                )
                              ],
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: FlutterFlowTheme.of(context)
                                    .primaryBackground,
                                width: 2,
                              ),
                            ),
                            child: Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 24, 0, 0),
                              child: Column(
                                children: [
                                  Align(
                                    alignment: Alignment(0, 0),
                                    child: TabBar(
                                      isScrollable: true,
                                      labelColor: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      unselectedLabelColor:
                                          FlutterFlowTheme.of(context)
                                              .secondaryText,
                                      labelPadding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              32, 0, 32, 0),
                                      labelStyle: FlutterFlowTheme.of(context)
                                          .titleMedium,
                                      unselectedLabelStyle: TextStyle(),
                                      indicatorColor:
                                          FlutterFlowTheme.of(context).primary,
                                      indicatorWeight: 3,
                                      tabs: [
                                        Tab(
                                          text: 'Креирај акаунт',
                                        ),
                                        Tab(
                                          text: 'Најави се',
                                        ),
                                      ],
                                      controller: _model.tabBarController,
                                      onTap: (value) => setState(() {}),
                                    ),
                                  ),
                                  Expanded(
                                    child: TabBarView(
                                      controller: _model.tabBarController,
                                      children: [
                                        Align(
                                          alignment:
                                              AlignmentDirectional(0, -1),
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    24, 16, 24, 0),
                                            child: SingleChildScrollView(
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  if (responsiveVisibility(
                                                    context: context,
                                                    phone: false,
                                                    tablet: false,
                                                  ))
                                                    Container(
                                                      width: 230,
                                                      height: 40,
                                                      decoration: BoxDecoration(
                                                        color: FlutterFlowTheme
                                                                .of(context)
                                                            .secondaryBackground,
                                                      ),
                                                    ),
                                                  Text(
                                                    'Регистрирајте се како превозници',
                                                    textAlign: TextAlign.start,
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .headlineMedium,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                0, 4, 0, 24),
                                                    child: Text(
                                                      'Пополнете ја формата подолу за да го креирате вашиот нов акаунт',
                                                      textAlign:
                                                          TextAlign.start,
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelMedium,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                0, 0, 0, 16),
                                                    child: Container(
                                                      width: double.infinity,
                                                      child: TextFormField(
                                                        controller: _model
                                                            .emailAddressController1,
                                                        autofocus: true,
                                                        autofillHints: [
                                                          AutofillHints.name
                                                        ],
                                                        obscureText: false,
                                                        decoration:
                                                            InputDecoration(
                                                          labelText: 'Email',
                                                          labelStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .titleMedium
                                                                  .override(
                                                                    fontFamily:
                                                                        FlutterFlowTheme.of(context)
                                                                            .titleMediumFamily,
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .secondaryText,
                                                                    useGoogleFonts: GoogleFonts
                                                                            .asMap()
                                                                        .containsKey(
                                                                            FlutterFlowTheme.of(context).titleMediumFamily),
                                                                  ),
                                                          enabledBorder:
                                                              OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .alternate,
                                                              width: 2,
                                                            ),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        40),
                                                          ),
                                                          focusedBorder:
                                                              OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .primary,
                                                              width: 2,
                                                            ),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        40),
                                                          ),
                                                          errorBorder:
                                                              OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .error,
                                                              width: 2,
                                                            ),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        40),
                                                          ),
                                                          focusedErrorBorder:
                                                              OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .error,
                                                              width: 2,
                                                            ),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        40),
                                                          ),
                                                          filled: true,
                                                          fillColor: FlutterFlowTheme
                                                                  .of(context)
                                                              .secondaryBackground,
                                                          contentPadding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      24,
                                                                      24,
                                                                      24,
                                                                      24),
                                                        ),
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .titleMedium
                                                                .override(
                                                                  fontFamily: FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleMediumFamily,
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .secondaryText,
                                                                  useGoogleFonts: GoogleFonts
                                                                          .asMap()
                                                                      .containsKey(
                                                                          FlutterFlowTheme.of(context)
                                                                              .titleMediumFamily),
                                                                ),
                                                        keyboardType:
                                                            TextInputType
                                                                .emailAddress,
                                                        validator: _model
                                                            .emailAddressController1Validator
                                                            .asValidator(
                                                                context),
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                0, 0, 0, 16),
                                                    child: Container(
                                                      width: double.infinity,
                                                      child: TextFormField(
                                                        controller: _model
                                                            .nameController,
                                                        autofocus: true,
                                                        autofillHints: [
                                                          AutofillHints.name
                                                        ],
                                                        obscureText: false,
                                                        decoration:
                                                            InputDecoration(
                                                          labelText:
                                                              'Име и презиме',
                                                          labelStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .titleMedium
                                                                  .override(
                                                                    fontFamily:
                                                                        FlutterFlowTheme.of(context)
                                                                            .titleMediumFamily,
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .secondaryText,
                                                                    useGoogleFonts: GoogleFonts
                                                                            .asMap()
                                                                        .containsKey(
                                                                            FlutterFlowTheme.of(context).titleMediumFamily),
                                                                  ),
                                                          enabledBorder:
                                                              OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .alternate,
                                                              width: 2,
                                                            ),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        40),
                                                          ),
                                                          focusedBorder:
                                                              OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .primary,
                                                              width: 2,
                                                            ),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        40),
                                                          ),
                                                          errorBorder:
                                                              OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .error,
                                                              width: 2,
                                                            ),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        40),
                                                          ),
                                                          focusedErrorBorder:
                                                              OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .error,
                                                              width: 2,
                                                            ),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        40),
                                                          ),
                                                          filled: true,
                                                          fillColor: FlutterFlowTheme
                                                                  .of(context)
                                                              .secondaryBackground,
                                                          contentPadding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      24,
                                                                      24,
                                                                      24,
                                                                      24),
                                                        ),
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .titleMedium
                                                                .override(
                                                                  fontFamily: FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleMediumFamily,
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .secondaryText,
                                                                  useGoogleFonts: GoogleFonts
                                                                          .asMap()
                                                                      .containsKey(
                                                                          FlutterFlowTheme.of(context)
                                                                              .titleMediumFamily),
                                                                ),
                                                        keyboardType:
                                                            TextInputType.text,
                                                        validator: _model
                                                            .nameValidator
                                                            .asValidator(
                                                                context),
                                                      ),
                                                    ),
                                                  ),
                                                  // Padding(
                                                  //   padding:
                                                  //       EdgeInsetsDirectional
                                                  //           .fromSTEB(
                                                  //               0, 0, 0, 16),
                                                  //   child: Container(
                                                  //     width: double.infinity,
                                                  //     child: TextFormField(
                                                  //       controller: _model
                                                  //           .confirmPasswordController,
                                                  //       autofocus: true,
                                                  //       autofillHints: [
                                                  //         AutofillHints.password
                                                  //       ],
                                                  //       obscureText: !_model
                                                  //           .confirmPasswordVisibility,
                                                  //       decoration:
                                                  //           InputDecoration(
                                                  //         labelText:
                                                  //             'Потврда на лозинка',
                                                  //         labelStyle:
                                                  //             FlutterFlowTheme.of(
                                                  //                     context)
                                                  //                 .titleMedium
                                                  //                 .override(
                                                  //                   fontFamily:
                                                  //                       FlutterFlowTheme.of(context)
                                                  //                           .titleMediumFamily,
                                                  //                   color: FlutterFlowTheme.of(
                                                  //                           context)
                                                  //                       .secondaryText,
                                                  //                   useGoogleFonts: GoogleFonts
                                                  //                           .asMap()
                                                  //                       .containsKey(
                                                  //                           FlutterFlowTheme.of(context).titleMediumFamily),
                                                  //                 ),
                                                  //         enabledBorder:
                                                  //             OutlineInputBorder(
                                                  //           borderSide:
                                                  //               BorderSide(
                                                  //             color: FlutterFlowTheme
                                                  //                     .of(context)
                                                  //                 .alternate,
                                                  //             width: 2,
                                                  //           ),
                                                  //           borderRadius:
                                                  //               BorderRadius
                                                  //                   .circular(
                                                  //                       40),
                                                  //         ),
                                                  //         focusedBorder:
                                                  //             OutlineInputBorder(
                                                  //           borderSide:
                                                  //               BorderSide(
                                                  //             color: FlutterFlowTheme
                                                  //                     .of(context)
                                                  //                 .primary,
                                                  //             width: 2,
                                                  //           ),
                                                  //           borderRadius:
                                                  //               BorderRadius
                                                  //                   .circular(
                                                  //                       40),
                                                  //         ),
                                                  //         errorBorder:
                                                  //             OutlineInputBorder(
                                                  //           borderSide:
                                                  //               BorderSide(
                                                  //             color: FlutterFlowTheme
                                                  //                     .of(context)
                                                  //                 .error,
                                                  //             width: 2,
                                                  //           ),
                                                  //           borderRadius:
                                                  //               BorderRadius
                                                  //                   .circular(
                                                  //                       40),
                                                  //         ),
                                                  //         focusedErrorBorder:
                                                  //             OutlineInputBorder(
                                                  //           borderSide:
                                                  //               BorderSide(
                                                  //             color: FlutterFlowTheme
                                                  //                     .of(context)
                                                  //                 .error,
                                                  //             width: 2,
                                                  //           ),
                                                  //           borderRadius:
                                                  //               BorderRadius
                                                  //                   .circular(
                                                  //                       40),
                                                  //         ),
                                                  //         filled: true,
                                                  //         fillColor: FlutterFlowTheme
                                                  //                 .of(context)
                                                  //             .secondaryBackground,
                                                  //         contentPadding:
                                                  //             EdgeInsetsDirectional
                                                  //                 .fromSTEB(
                                                  //                     24,
                                                  //                     24,
                                                  //                     24,
                                                  //                     24),
                                                  //         suffixIcon: InkWell(
                                                  //           onTap: () =>
                                                  //               setState(
                                                  //             () => _model
                                                  //                     .confirmPasswordVisibility =
                                                  //                 !_model
                                                  //                     .confirmPasswordVisibility,
                                                  //           ),
                                                  //           focusNode: FocusNode(
                                                  //               skipTraversal:
                                                  //                   true),
                                                  //           child: Icon(
                                                  //             _model.confirmPasswordVisibility
                                                  //                 ? Icons
                                                  //                     .visibility_outlined
                                                  //                 : Icons
                                                  //                     .visibility_off_outlined,
                                                  //             color: FlutterFlowTheme
                                                  //                     .of(context)
                                                  //                 .secondaryText,
                                                  //             size: 24,
                                                  //           ),
                                                  //         ),
                                                  //       ),
                                                  //       style:
                                                  //           FlutterFlowTheme.of(
                                                  //                   context)
                                                  //               .titleMedium,
                                                  //       validator: _model
                                                  //           .confirmPasswordControllerValidator
                                                  //           .asValidator(
                                                  //               context),
                                                  //     ),
                                                  //   ),
                                                  // ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                0, 0, 0, 16),
                                                    child: Container(
                                                      width: double.infinity,
                                                      child: TextFormField(
                                                        controller: _model
                                                            .phoneNumberController,
                                                        autofocus: true,
                                                        autofillHints: [
                                                          AutofillHints
                                                              .telephoneNumber
                                                        ],
                                                        decoration:
                                                            InputDecoration(
                                                          labelText:
                                                              'Телефонски број',
                                                          labelStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .titleMedium
                                                                  .override(
                                                                    fontFamily:
                                                                        FlutterFlowTheme.of(context)
                                                                            .titleMediumFamily,
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .secondaryText,
                                                                    useGoogleFonts: GoogleFonts
                                                                            .asMap()
                                                                        .containsKey(
                                                                            FlutterFlowTheme.of(context).titleMediumFamily),
                                                                  ),
                                                          enabledBorder:
                                                              OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .alternate,
                                                              width: 2,
                                                            ),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        40),
                                                          ),
                                                          focusedBorder:
                                                              OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .primary,
                                                              width: 2,
                                                            ),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        40),
                                                          ),
                                                          errorBorder:
                                                              OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .error,
                                                              width: 2,
                                                            ),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        40),
                                                          ),
                                                          focusedErrorBorder:
                                                              OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .error,
                                                              width: 2,
                                                            ),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        40),
                                                          ),
                                                          filled: true,
                                                          fillColor: FlutterFlowTheme
                                                                  .of(context)
                                                              .secondaryBackground,
                                                          contentPadding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      24,
                                                                      24,
                                                                      24,
                                                                      24),
                                                        ),
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .titleMedium
                                                                .override(
                                                                  fontFamily: FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleMediumFamily,
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .secondaryText,
                                                                  useGoogleFonts: GoogleFonts
                                                                          .asMap()
                                                                      .containsKey(
                                                                          FlutterFlowTheme.of(context)
                                                                              .titleMediumFamily),
                                                                ),
                                                        validator: _model
                                                            .phoneNumberControllerValidator
                                                            .asValidator(
                                                                context),
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                0, 0, 0, 16),
                                                    child: Container(
                                                      width: double.infinity,
                                                      child: TextFormField(
                                                        controller: _model
                                                            .passwordController1,
                                                        autofocus: true,
                                                        autofillHints: [
                                                          AutofillHints.password
                                                        ],
                                                        obscureText: !_model
                                                            .passwordVisibility1,
                                                        decoration:
                                                            InputDecoration(
                                                          labelText: 'Лозинка',
                                                          labelStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .titleMedium
                                                                  .override(
                                                                    fontFamily:
                                                                        FlutterFlowTheme.of(context)
                                                                            .titleMediumFamily,
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .secondaryText,
                                                                    useGoogleFonts: GoogleFonts
                                                                            .asMap()
                                                                        .containsKey(
                                                                            FlutterFlowTheme.of(context).titleMediumFamily),
                                                                  ),
                                                          enabledBorder:
                                                              OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .alternate,
                                                              width: 2,
                                                            ),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        40),
                                                          ),
                                                          focusedBorder:
                                                              OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .primary,
                                                              width: 2,
                                                            ),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        40),
                                                          ),
                                                          errorBorder:
                                                              OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .error,
                                                              width: 2,
                                                            ),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        40),
                                                          ),
                                                          focusedErrorBorder:
                                                              OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .error,
                                                              width: 2,
                                                            ),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        40),
                                                          ),
                                                          filled: true,
                                                          fillColor: FlutterFlowTheme
                                                                  .of(context)
                                                              .secondaryBackground,
                                                          contentPadding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      24,
                                                                      24,
                                                                      24,
                                                                      24),
                                                          suffixIcon: InkWell(
                                                            onTap: () =>
                                                                setState(
                                                              () => _model
                                                                      .passwordVisibility1 =
                                                                  !_model
                                                                      .passwordVisibility1,
                                                            ),
                                                            focusNode: FocusNode(
                                                                skipTraversal:
                                                                    true),
                                                            child: Icon(
                                                              _model.passwordVisibility1
                                                                  ? Icons
                                                                      .visibility_outlined
                                                                  : Icons
                                                                      .visibility_off_outlined,
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .secondaryText,
                                                              size: 24,
                                                            ),
                                                          ),
                                                        ),
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .titleMedium
                                                                .override(
                                                                  fontFamily: FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleMediumFamily,
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .secondaryText,
                                                                  useGoogleFonts: GoogleFonts
                                                                          .asMap()
                                                                      .containsKey(
                                                                          FlutterFlowTheme.of(context)
                                                                              .titleMediumFamily),
                                                                ),
                                                        validator: _model
                                                            .passwordController1Validator
                                                            .asValidator(
                                                                context),
                                                      ),
                                                    ),
                                                  ),
                                                  Align(
                                                    alignment:
                                                        AlignmentDirectional(
                                                            0, 0),
                                                    child: Text(
                                                      'Се регистрирам како:',
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMedium,
                                                    ),
                                                  ),
                                                  Align(
                                                    alignment: Alignment.center,
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0, 10, 0, 10),
                                                      child:
                                                          FlutterFlowRadioButton(
                                                        options: [
                                                          'Самостојно',
                                                          'Такси',
                                                          'Превозник'
                                                        ].toList(),
                                                        onChanged: (val) =>
                                                            setState(() {}),
                                                        controller: _model
                                                                .radioButtonValueController ??=
                                                            FormFieldController<
                                                                String>(null),
                                                        optionHeight: 32,
                                                        textStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .labelMedium,
                                                        selectedTextStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium,
                                                        buttonPosition:
                                                            RadioButtonPosition
                                                                .left,
                                                        direction:
                                                            Axis.horizontal,
                                                        radioButtonColor:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primary,
                                                        inactiveRadioButtonColor:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .secondaryText,
                                                        toggleable: false,
                                                        horizontalAlignment:
                                                            WrapAlignment
                                                                .center,
                                                        verticalAlignment:
                                                            WrapCrossAlignment
                                                                .start,
                                                      ),
                                                    ),
                                                  ),
                                                  Align(
                                                    alignment:
                                                        AlignmentDirectional(
                                                            0, 0),
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0, 0, 0, 16),
                                                      child: FFButtonWidget(
                                                        onPressed: () async {
                                                          // GoRouter.of(context)
                                                          //     .prepareAuthEvent();
                                                          // if (_model
                                                          //         .passwordController1
                                                          //         .text !=
                                                          //     _model
                                                          //         .confirmPasswordController
                                                          //         .text) {
                                                          //   ScaffoldMessenger
                                                          //           .of(context)
                                                          //       .showSnackBar(
                                                          //     SnackBar(
                                                          //       content: Text(
                                                          //         'Passwords don\'t match!',
                                                          //       ),
                                                          //     ),
                                                          //   );
                                                          //   return;
                                                          // }

                                                          // final user =
                                                          //     await authManager
                                                          //         .createAccountWithEmail(
                                                          //   context,
                                                          //   _model
                                                          //       .emailAddressController1
                                                          //       .text,
                                                          //   _model
                                                          //       .passwordController1
                                                          //       .text,
                                                          // );
                                                          // if (user == null) {
                                                          //   return;
                                                          // }

                                                          // context.goNamedAuth(
                                                          //     'LoginPage',
                                                          //     context.mounted);
                                                          registerNewUser(
                                                              context);
                                                        },
                                                        text: 'Следно',
                                                        options:
                                                            FFButtonOptions(
                                                          width: 230,
                                                          height: 52,
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(0,
                                                                      0, 0, 0),
                                                          iconPadding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(0,
                                                                      0, 0, 0),
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primary,
                                                          textStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .titleSmall
                                                                  .override(
                                                                    fontFamily:
                                                                        FlutterFlowTheme.of(context)
                                                                            .titleSmallFamily,
                                                                    color: Colors
                                                                        .white,
                                                                    useGoogleFonts: GoogleFonts
                                                                            .asMap()
                                                                        .containsKey(
                                                                            FlutterFlowTheme.of(context).titleSmallFamily),
                                                                  ),
                                                          elevation: 3,
                                                          borderSide:
                                                              BorderSide(
                                                            color: Colors
                                                                .transparent,
                                                            width: 1,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(40),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Align(
                                                        alignment:
                                                            AlignmentDirectional(
                                                                0, 0),
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      16,
                                                                      0,
                                                                      16,
                                                                      24),
                                                          child: Text(
                                                            'Или регистрирајте се со',
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .labelMedium,
                                                          ),
                                                        ),
                                                      ),
                                                      Align(
                                                        alignment:
                                                            AlignmentDirectional(
                                                                0, 0),
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(0,
                                                                      0, 0, 16),
                                                          child: Wrap(
                                                            spacing: 16,
                                                            runSpacing: 0,
                                                            alignment:
                                                                WrapAlignment
                                                                    .center,
                                                            crossAxisAlignment:
                                                                WrapCrossAlignment
                                                                    .center,
                                                            direction:
                                                                Axis.horizontal,
                                                            runAlignment:
                                                                WrapAlignment
                                                                    .center,
                                                            verticalDirection:
                                                                VerticalDirection
                                                                    .down,
                                                            clipBehavior:
                                                                Clip.none,
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0,
                                                                            0,
                                                                            0,
                                                                            16),
                                                                child:
                                                                    FFButtonWidget(
                                                                  onPressed:
                                                                      () async {
                                                                    // GoRouter.of(
                                                                    //         context)
                                                                    //     .prepareAuthEvent();
                                                                    // final user =
                                                                    //     await authManager
                                                                    //         .signInWithGoogle(context);
                                                                    // if (user ==
                                                                    //     null) {
                                                                    //   return;
                                                                    // }

                                                                    // context.goNamedAuth(
                                                                    //     'LoginPage',
                                                                    //     context
                                                                    //         .mounted);
                                                                  },
                                                                  text:
                                                                      'Регистрација преку Google',
                                                                  icon: FaIcon(
                                                                    FontAwesomeIcons
                                                                        .google,
                                                                    size: 20,
                                                                  ),
                                                                  options:
                                                                      FFButtonOptions(
                                                                    width: 230,
                                                                    height: 44,
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0,
                                                                            0,
                                                                            0,
                                                                            0),
                                                                    iconPadding:
                                                                        EdgeInsetsDirectional.fromSTEB(
                                                                            0,
                                                                            0,
                                                                            0,
                                                                            0),
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .secondaryBackground,
                                                                    textStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .override(
                                                                          fontFamily:
                                                                              FlutterFlowTheme.of(context).bodyMediumFamily,
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                          useGoogleFonts:
                                                                              GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).bodyMediumFamily),
                                                                        ),
                                                                    elevation:
                                                                        0,
                                                                    borderSide:
                                                                        BorderSide(
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .alternate,
                                                                      width: 2,
                                                                    ),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            40),
                                                                    hoverColor:
                                                                        FlutterFlowTheme.of(context)
                                                                            .primaryBackground,
                                                                  ),
                                                                ),
                                                              ),
                                                              isAndroid
                                                                  ? Container()
                                                                  : Padding(
                                                                      padding: EdgeInsetsDirectional
                                                                          .fromSTEB(
                                                                              0,
                                                                              0,
                                                                              0,
                                                                              16),
                                                                      child:
                                                                          FFButtonWidget(
                                                                        onPressed:
                                                                            () async {
                                                                          // GoRouter.of(context)
                                                                          //     .prepareAuthEvent();
                                                                          // final user =
                                                                          //     await authManager.signInWithApple(context);
                                                                          // if (user ==
                                                                          //     null) {
                                                                          //   return;
                                                                          // }

                                                                          // context.goNamedAuth(
                                                                          //     'LoginPage',
                                                                          //     context.mounted);
                                                                        },
                                                                        text:
                                                                            'Регистрација преку Apple',
                                                                        icon:
                                                                            FaIcon(
                                                                          FontAwesomeIcons
                                                                              .apple,
                                                                          size:
                                                                              20,
                                                                        ),
                                                                        options:
                                                                            FFButtonOptions(
                                                                          width:
                                                                              230,
                                                                          height:
                                                                              44,
                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                              0,
                                                                              0,
                                                                              0,
                                                                              0),
                                                                          iconPadding: EdgeInsetsDirectional.fromSTEB(
                                                                              0,
                                                                              0,
                                                                              0,
                                                                              0),
                                                                          color:
                                                                              FlutterFlowTheme.of(context).secondaryBackground,
                                                                          textStyle: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .override(
                                                                                fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                                                                                fontWeight: FontWeight.bold,
                                                                                useGoogleFonts: GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).bodyMediumFamily),
                                                                              ),
                                                                          elevation:
                                                                              0,
                                                                          borderSide:
                                                                              BorderSide(
                                                                            color:
                                                                                FlutterFlowTheme.of(context).alternate,
                                                                            width:
                                                                                2,
                                                                          ),
                                                                          borderRadius:
                                                                              BorderRadius.circular(40),
                                                                          hoverColor:
                                                                              FlutterFlowTheme.of(context).primaryBackground,
                                                                        ),
                                                                      ),
                                                                    ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ).animateOnPageLoad(animationsMap[
                                                'columnOnPageLoadAnimation1']!),
                                          ),
                                        ),
                                        Align(
                                          alignment:
                                              AlignmentDirectional(0, -1),
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    24, 16, 24, 0),
                                            child: SingleChildScrollView(
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  if (responsiveVisibility(
                                                    context: context,
                                                    phone: false,
                                                    tablet: false,
                                                  ))
                                                    Container(
                                                      width: 230,
                                                      height: 40,
                                                      decoration: BoxDecoration(
                                                        color: FlutterFlowTheme
                                                                .of(context)
                                                            .secondaryBackground,
                                                      ),
                                                    ),
                                                  Text(
                                                    'Добредојдовте',
                                                    textAlign: TextAlign.start,
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .headlineMedium,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                0, 4, 0, 24),
                                                    child: Text(
                                                      'Пополнете ги податоците за да пристапите до вашиот акаунт.',
                                                      textAlign:
                                                          TextAlign.start,
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelMedium,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                0, 0, 0, 16),
                                                    child: Container(
                                                      width: double.infinity,
                                                      child: TextFormField(
                                                        controller: _model
                                                            .emailAddressController2,
                                                        autofocus: true,
                                                        autofillHints: [
                                                          AutofillHints.email
                                                        ],
                                                        obscureText: false,
                                                        decoration:
                                                            InputDecoration(
                                                          labelText: 'Email',
                                                          labelStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelLarge,
                                                          enabledBorder:
                                                              OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .primaryBackground,
                                                              width: 2,
                                                            ),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        40),
                                                          ),
                                                          focusedBorder:
                                                              OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .primary,
                                                              width: 2,
                                                            ),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        40),
                                                          ),
                                                          errorBorder:
                                                              OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .alternate,
                                                              width: 2,
                                                            ),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        40),
                                                          ),
                                                          focusedErrorBorder:
                                                              OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .alternate,
                                                              width: 2,
                                                            ),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        40),
                                                          ),
                                                          filled: true,
                                                          fillColor: FlutterFlowTheme
                                                                  .of(context)
                                                              .secondaryBackground,
                                                          contentPadding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      24,
                                                                      24,
                                                                      0,
                                                                      24),
                                                        ),
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyLarge,
                                                        keyboardType:
                                                            TextInputType
                                                                .emailAddress,
                                                        validator: _model
                                                            .emailAddressController2Validator
                                                            .asValidator(
                                                                context),
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                0, 0, 0, 16),
                                                    child: Container(
                                                      width: double.infinity,
                                                      child: TextFormField(
                                                        controller: _model
                                                            .passwordController2,
                                                        autofocus: true,
                                                        autofillHints: [
                                                          AutofillHints.password
                                                        ],
                                                        obscureText: !_model
                                                            .passwordVisibility2,
                                                        decoration:
                                                            InputDecoration(
                                                          labelText: 'Лозинка',
                                                          labelStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelLarge,
                                                          enabledBorder:
                                                              OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .alternate,
                                                              width: 2,
                                                            ),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        40),
                                                          ),
                                                          focusedBorder:
                                                              OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .primary,
                                                              width: 2,
                                                            ),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        40),
                                                          ),
                                                          errorBorder:
                                                              OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .error,
                                                              width: 2,
                                                            ),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        40),
                                                          ),
                                                          focusedErrorBorder:
                                                              OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .error,
                                                              width: 2,
                                                            ),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        40),
                                                          ),
                                                          filled: true,
                                                          fillColor: FlutterFlowTheme
                                                                  .of(context)
                                                              .secondaryBackground,
                                                          contentPadding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      24,
                                                                      24,
                                                                      0,
                                                                      24),
                                                          suffixIcon: InkWell(
                                                            onTap: () =>
                                                                setState(
                                                              () => _model
                                                                      .passwordVisibility2 =
                                                                  !_model
                                                                      .passwordVisibility2,
                                                            ),
                                                            focusNode: FocusNode(
                                                                skipTraversal:
                                                                    true),
                                                            child: Icon(
                                                              _model.passwordVisibility2
                                                                  ? Icons
                                                                      .visibility_outlined
                                                                  : Icons
                                                                      .visibility_off_outlined,
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .secondaryText,
                                                              size: 24,
                                                            ),
                                                          ),
                                                        ),
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyLarge,
                                                        validator: _model
                                                            .passwordController2Validator
                                                            .asValidator(
                                                                context),
                                                      ),
                                                    ),
                                                  ),
                                                  Align(
                                                    alignment:
                                                        AlignmentDirectional(
                                                            0, 0),
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0, 0, 0, 16),
                                                      child: FFButtonWidget(
                                                        onPressed: () async {
                                                          // GoRouter.of(context)
                                                          //     .prepareAuthEvent();

                                                          // final user =
                                                          //     await authManager
                                                          //         .signInWithEmail(
                                                          //   context,
                                                          //   _model
                                                          //       .emailAddressController2
                                                          //       .text,
                                                          //   _model
                                                          //       .passwordController2
                                                          //       .text,
                                                          // );
                                                          // if (user == null) {
                                                          //   return;
                                                          // }

                                                          // context.goNamedAuth(
                                                          //     'LoginPage',
                                                          //     context.mounted);
                                                          authenticate(context);
                                                        },
                                                        text: 'Најава',
                                                        options:
                                                            FFButtonOptions(
                                                          width: 230,
                                                          height: 52,
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(0,
                                                                      0, 0, 0),
                                                          iconPadding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(0,
                                                                      0, 0, 0),
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primary,
                                                          textStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .titleSmall
                                                                  .override(
                                                                    fontFamily:
                                                                        FlutterFlowTheme.of(context)
                                                                            .titleSmallFamily,
                                                                    color: Colors
                                                                        .white,
                                                                    useGoogleFonts: GoogleFonts
                                                                            .asMap()
                                                                        .containsKey(
                                                                            FlutterFlowTheme.of(context).titleSmallFamily),
                                                                  ),
                                                          elevation: 3,
                                                          borderSide:
                                                              BorderSide(
                                                            color: Colors
                                                                .transparent,
                                                            width: 1,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(40),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Align(
                                                    alignment:
                                                        AlignmentDirectional(
                                                            0, 0),
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(16, 0,
                                                                  16, 24),
                                                      child: Text(
                                                        'Или најавете се со',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .labelMedium,
                                                      ),
                                                    ),
                                                  ),
                                                  Align(
                                                    alignment:
                                                        AlignmentDirectional(
                                                            0, 0),
                                                    child: Wrap(
                                                      spacing: 16,
                                                      runSpacing: 0,
                                                      alignment:
                                                          WrapAlignment.center,
                                                      crossAxisAlignment:
                                                          WrapCrossAlignment
                                                              .center,
                                                      direction:
                                                          Axis.horizontal,
                                                      runAlignment:
                                                          WrapAlignment.center,
                                                      verticalDirection:
                                                          VerticalDirection
                                                              .down,
                                                      clipBehavior: Clip.none,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(0,
                                                                      0, 0, 16),
                                                          child: FFButtonWidget(
                                                            onPressed:
                                                                () async {
                                                              // GoRouter.of(
                                                              //         context)
                                                              //     .prepareAuthEvent();
                                                              // final user =
                                                              //     await authManager
                                                              //         .signInWithGoogle(
                                                              //             context);
                                                              // if (user ==
                                                              //     null) {
                                                              //   return;
                                                              // }

                                                              // context.goNamedAuth(
                                                              //     'LoginPage',
                                                              //     context
                                                              //         .mounted);
                                                            },
                                                            text:
                                                                'Најава преку Google',
                                                            icon: FaIcon(
                                                              FontAwesomeIcons
                                                                  .google,
                                                              size: 20,
                                                            ),
                                                            options:
                                                                FFButtonOptions(
                                                              width: 230,
                                                              height: 44,
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0,
                                                                          0,
                                                                          0,
                                                                          0),
                                                              iconPadding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0,
                                                                          0,
                                                                          0,
                                                                          0),
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .secondaryBackground,
                                                              textStyle:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .override(
                                                                        fontFamily:
                                                                            FlutterFlowTheme.of(context).bodyMediumFamily,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        useGoogleFonts:
                                                                            GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).bodyMediumFamily),
                                                                      ),
                                                              elevation: 0,
                                                              borderSide:
                                                                  BorderSide(
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .alternate,
                                                                width: 2,
                                                              ),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          40),
                                                              hoverColor:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .primaryBackground,
                                                            ),
                                                          ),
                                                        ),
                                                        isAndroid
                                                            ? Container()
                                                            : Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0,
                                                                            0,
                                                                            0,
                                                                            16),
                                                                child:
                                                                    FFButtonWidget(
                                                                  onPressed:
                                                                      () async {
                                                                    // GoRouter.of(
                                                                    //         context)
                                                                    //     .prepareAuthEvent();
                                                                    // final user =
                                                                    //     await authManager
                                                                    //         .signInWithApple(context);
                                                                    // if (user ==
                                                                    //     null) {
                                                                    //   return;
                                                                    // }

                                                                    // context.goNamedAuth(
                                                                    //     'LoginPage',
                                                                    //     context
                                                                    //         .mounted);
                                                                  },
                                                                  text:
                                                                      'Најава преку Apple',
                                                                  icon: FaIcon(
                                                                    FontAwesomeIcons
                                                                        .apple,
                                                                    size: 20,
                                                                  ),
                                                                  options:
                                                                      FFButtonOptions(
                                                                    width: 230,
                                                                    height: 44,
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0,
                                                                            0,
                                                                            0,
                                                                            0),
                                                                    iconPadding:
                                                                        EdgeInsetsDirectional.fromSTEB(
                                                                            0,
                                                                            0,
                                                                            0,
                                                                            0),
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .secondaryBackground,
                                                                    textStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .override(
                                                                          fontFamily:
                                                                              FlutterFlowTheme.of(context).bodyMediumFamily,
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                          useGoogleFonts:
                                                                              GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).bodyMediumFamily),
                                                                        ),
                                                                    elevation:
                                                                        0,
                                                                    borderSide:
                                                                        BorderSide(
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .alternate,
                                                                      width: 2,
                                                                    ),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            40),
                                                                    hoverColor:
                                                                        FlutterFlowTheme.of(context)
                                                                            .primaryBackground,
                                                                  ),
                                                                ),
                                                              ),
                                                      ],
                                                    ),
                                                  ),
                                                  Align(
                                                    alignment:
                                                        AlignmentDirectional(
                                                            0, 0),
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0, 0, 0, 16),
                                                      child: FFButtonWidget(
                                                        onPressed: () async {
                                                          // GoRouter.of(context)
                                                          //     .prepareAuthEvent();
                                                          // final user =
                                                          //     await authManager
                                                          //         .signInWithGoogle(
                                                          //             context);
                                                          // if (user == null) {
                                                          //   return;
                                                          // }

                                                          // context.goNamedAuth(
                                                          //     'LoginPage',
                                                          //     context.mounted);
                                                        },
                                                        text:
                                                            'Ја заборавивте лозинката?',
                                                        options:
                                                            FFButtonOptions(
                                                          height: 44,
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(32,
                                                                      0, 32, 0),
                                                          iconPadding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(0,
                                                                      0, 0, 0),
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .secondaryBackground,
                                                          textStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .override(
                                                                    fontFamily:
                                                                        FlutterFlowTheme.of(context)
                                                                            .bodyMediumFamily,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    useGoogleFonts: GoogleFonts
                                                                            .asMap()
                                                                        .containsKey(
                                                                            FlutterFlowTheme.of(context).bodyMediumFamily),
                                                                  ),
                                                          elevation: 0,
                                                          borderSide:
                                                              BorderSide(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .secondaryBackground,
                                                            width: 2,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(40),
                                                          hoverColor:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .primaryBackground,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ).animateOnPageLoad(animationsMap[
                                                'columnOnPageLoadAnimation2']!),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ).animateOnPageLoad(
                              animationsMap['containerOnPageLoadAnimation']!),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  bool validateFields(BuildContext context) {
    bool result = false;

    if (_model.nameController.text.length < 4) {
      Fluttertoast.showToast(
          msg: "Во полето за име мора да пополните барем 3 букви");
    } else if (_model.passwordController1.text.length < 8) {
      Fluttertoast.showToast(
          msg: "Лозинката мора да се состои од барем 8 букви.");
    } else if (!_model.emailAddressController1.text.contains("@")) {
      Fluttertoast.showToast(msg: "Ве молиме внесете валидна емаил адреса.");
    } else if (_model.phoneNumberController.text.isEmpty) {
      Fluttertoast.showToast(
          msg: "Полето за внес на телефонски број е задолжително.");
    } else {
      result = true;
    }
    return result;
  }

  void registerNewUser(BuildContext context) async {
    if (validateFields(context)) {
      final User? firebaseUser = (await _firebaseAuth
              .createUserWithEmailAndPassword(
                  email: _model.emailAddressController1.text,
                  password: _model.passwordController1.text)
              .catchError((errMsg) {
        Fluttertoast.showToast(msg: "Настана грешка: " + errMsg);
      }))
          .user;
      if (firebaseUser == null) {
        Fluttertoast.showToast(
            msg:
                "Настана грешка при креирањето на акаунтот. Ве молиме обидете се повторно.");
      } else {
        String user_role = "regular_driver";
        if (_model.radioButtonValue!.isNotEmpty &&
            _model.radioButtonValue!.toLowerCase() == "самостојно") {
          user_role = "regular_driver";
        } else if (_model.radioButtonValue!.isNotEmpty &&
            _model.radioButtonValue!.toLowerCase() == "такси") {
          user_role = "taxi_driver";
        } else if (_model.radioButtonValue!.isNotEmpty &&
            _model.radioButtonValue!.toLowerCase() == "превозник") {
          user_role = "transporting_driver";
        }
        Map userDataObj = {
          "name": _model.nameController.text,
          "email": _model.emailAddressController1.text,
          "phone": _model.phoneNumberController.text,
          "role": user_role
        };

        providersRef.child(firebaseUser.uid).set(userDataObj);
        Fluttertoast.showToast(
            msg:
                "Вашиот профил е креиран, ќе бидете пренасочени кон страницата за информации за превозник");
        if (user_role == "regular_driver") {
          context.go("/independentProvider");
        } else if (user_role == "taxi_driver") {
          context.go("/taxiProvider");
        } else if (user_role == "transporting_driver") {
          context.go("/transportingProvider");
        }
      }
    }
  }

  bool validateLoginFields(BuildContext context) {
    bool result = false;

    if (_model.passwordController2.text.isEmpty) {
      Fluttertoast.showToast(msg: "Мора да внесете лозинка за да се најавите!");
    } else if (!_model.emailAddressController2.text.contains("@")) {
      Fluttertoast.showToast(msg: "Ве молиме внесете валидна емаил адреса.");
    } else {
      result = true;
    }
    return result;
  }

  void authenticate(BuildContext context) async {
    if (validateLoginFields(context)) {
      // final User? firebaseUser = (await _firebaseAuth
      //         .signInWithEmailAndPassword(
      //             email: _model.emailAddressController2.text,
      //             password: _model.passwordController2.text)
      //         .catchError((errMsg) {
      //   Fluttertoast.showToast(msg: "Настана грешка: " + errMsg);
      // }))
      //     .user;
      // if (firebaseUser == null) {
      //   Fluttertoast.showToast(
      //       msg:
      //           "Не постои корисник со такви информации. Ве молиме проверете ги и обидете се повторно или регистрирајте се.");
      // } else {
      //   usersRef
      //       .child(firebaseUser.uid)
      //       .once()
      //       .then((value) => (DataSnapshot snap) {
      //             if (snap.value != null) {
      //               context.go("/home");
      //               Fluttertoast.showToast(msg: "Успешно се најавивте!");
      //             } else {
      //               _firebaseAuth.signOut();
      //               Fluttertoast.showToast(
      //                   msg:
      //                       "Не постои корисник со такви информации. Ве молиме проверете ги и обидете се повторно или регистрирајте се.");
      //             }
      //           });
      // }
      try {
        final UserCredential? firebaseUser =
            (await _firebaseAuth.signInWithEmailAndPassword(
                email: _model.emailAddressController2.text,
                password: _model.passwordController2.text));

        if (firebaseUser != null) {
          DataSnapshot userSnap =
              await providersRef.child(firebaseUser.user!.uid).get();
          if (userSnap.value == null) {
            Fluttertoast.showToast(
                msg:
                    "Не постои корисник со такви информации. Ве молиме проверете ги и обидете се повторно или регистрирајте се.");
            _firebaseAuth.signOut();
          } else {
            Fluttertoast.showToast(msg: "Успешно се најавивте!");
            context.go("/home");
          }
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          Fluttertoast.showToast(
              msg:
                  "Не постои корисник со такви информации. Ве молиме проверете ги и обидете се повторно или регистрирајте се.");
        } else if (e.code == 'wrong-password') {
          Fluttertoast.showToast(
              msg:
                  "Погрешна лозинка. Ве молиме проверете ги и обидете се повторно или регистрирајте се.");
        }
      }
    }
  }
}
