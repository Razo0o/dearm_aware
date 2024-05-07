import '/auth/firebase_auth/auth_util.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_autocomplete_options_list.dart';
import '/flutter_flow/flutter_flow_button_tabbar.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'login_page_model.dart';
export 'login_page_model.dart';

class LoginPageWidget extends StatefulWidget {
  const LoginPageWidget({super.key});

  @override
  State<LoginPageWidget> createState() => _LoginPageWidgetState();
}

class _LoginPageWidgetState extends State<LoginPageWidget>
    with TickerProviderStateMixin {
  late LoginPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = <String, AnimationInfo>{};

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => LoginPageModel());

    _model.tabBarController = TabController(
      vsync: this,
      length: 3,
      initialIndex: 0,
    )..addListener(() => setState(() {}));
    _model.emailAddressTextController1 ??= TextEditingController();
    _model.emailAddressFocusNode1 ??= FocusNode();

    _model.passwordTextController1 ??= TextEditingController();
    _model.passwordFocusNode1 ??= FocusNode();

    _model.emailAddressTextController2 ??= TextEditingController();
    _model.emailAddressFocusNode2 ??= FocusNode();

    _model.passwordTextController2 ??= TextEditingController();
    _model.passwordFocusNode2 ??= FocusNode();

    _model.patientEmailTextController ??= TextEditingController();

    _model.patientpasswordTextController ??= TextEditingController();
    _model.patientpasswordFocusNode ??= FocusNode();

    animationsMap.addAll({
      'containerOnPageLoadAnimation': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          VisibilityEffect(duration: 1.ms),
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 400.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
          MoveEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 400.0.ms,
            begin: const Offset(0.0, 80.0),
            end: const Offset(0.0, 0.0),
          ),
          ScaleEffect(
            curve: Curves.easeInOut,
            delay: 150.0.ms,
            duration: 400.0.ms,
            begin: const Offset(0.8, 0.8),
            end: const Offset(1.0, 1.0),
          ),
        ],
      ),
      'columnOnPageLoadAnimation1': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          VisibilityEffect(duration: 300.ms),
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 300.0.ms,
            duration: 400.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
          MoveEffect(
            curve: Curves.easeInOut,
            delay: 300.0.ms,
            duration: 400.0.ms,
            begin: const Offset(0.0, 20.0),
            end: const Offset(0.0, 0.0),
          ),
        ],
      ),
      'columnOnPageLoadAnimation2': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          VisibilityEffect(duration: 300.ms),
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 300.0.ms,
            duration: 400.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
          MoveEffect(
            curve: Curves.easeInOut,
            delay: 300.0.ms,
            duration: 400.0.ms,
            begin: const Offset(0.0, 20.0),
            end: const Offset(0.0, 0.0),
          ),
        ],
      ),
      'columnOnPageLoadAnimation3': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          VisibilityEffect(duration: 300.ms),
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 300.0.ms,
            duration: 400.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
          MoveEffect(
            curve: Curves.easeInOut,
            delay: 300.0.ms,
            duration: 400.0.ms,
            begin: const Offset(0.0, 20.0),
            end: const Offset(0.0, 0.0),
          ),
        ],
      ),
    });
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
        body: SafeArea(
          top: true,
          child: Stack(
            children: [
              Stack(
                children: [
                  Padding(
                    padding:
                        const EdgeInsetsDirectional.fromSTEB(12.0, 250.0, 12.0, 12.0),
                    child: Container(
                      width: double.infinity,
                      height: MediaQuery.sizeOf(context).width >= 768.0
                          ? 530.0
                          : 630.0,
                      constraints: const BoxConstraints(
                        maxWidth: 570.0,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE1E1E1),
                        boxShadow: const [
                          BoxShadow(
                            blurRadius: 4.0,
                            color: Color(0x33000000),
                            offset: Offset(
                              0.0,
                              2.0,
                            ),
                          )
                        ],
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(0.0),
                          bottomRight: Radius.circular(0.0),
                          topLeft: Radius.circular(80.0),
                          topRight: Radius.circular(80.0),
                        ),
                        border: Border.all(
                          color: FlutterFlowTheme.of(context).primaryBackground,
                          width: 1.0,
                        ),
                      ),
                      child: Align(
                        alignment: const AlignmentDirectional(0.0, 0.0),
                        child: Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0.0, 80.0, 0.0, 0.0),
                              child: Column(
                                children: [
                                  Align(
                                    alignment: const Alignment(0.0, 0),
                                    child: FlutterFlowButtonTabBar(
                                      useToggleButtonStyle: true,
                                      isScrollable: true,
                                      labelStyle: FlutterFlowTheme.of(context)
                                          .titleMedium
                                          .override(
                                            fontFamily: 'Plus Jakarta Sans',
                                            letterSpacing: 0.0,
                                            lineHeight: 2.0,
                                          ),
                                      unselectedLabelStyle: const TextStyle(),
                                      labelColor: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      unselectedLabelColor:
                                          FlutterFlowTheme.of(context)
                                              .primaryText,
                                      backgroundColor: const Color(0xFF91E2D8),
                                      unselectedBackgroundColor:
                                          const Color(0xFF73BCB2),
                                      borderWidth: 20.0,
                                      borderRadius: 20.0,
                                      elevation: 4.0,
                                      labelPadding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              20.0, 0.0, 20.0, 0.0),
                                      tabs: const [
                                        Tab(
                                          text: 'طبيب',
                                        ),
                                        Tab(
                                          text: 'طبيب الامتياز',
                                        ),
                                        Tab(
                                          text: 'مريض',
                                        ),
                                      ],
                                      controller: _model.tabBarController,
                                      onTap: (i) async {
                                        [
                                          () async {},
                                          () async {},
                                          () async {}
                                        ][i]();
                                      },
                                    ),
                                  ),
                                  Expanded(
                                    child: TabBarView(
                                      controller: _model.tabBarController,
                                      children: [
                                        Column(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Align(
                                              alignment: const AlignmentDirectional(
                                                  0.0, -1.0),
                                              child: Padding(
                                                padding: const EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        24.0, 16.0, 24.0, 0.0),
                                                child: SingleChildScrollView(
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      if (responsiveVisibility(
                                                        context: context,
                                                        phone: false,
                                                        tablet: false,
                                                      ))
                                                        Container(
                                                          width: 230.0,
                                                          height: 40.0,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .secondaryBackground,
                                                          ),
                                                        ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0.0,
                                                                    20.0,
                                                                    0.0,
                                                                    16.0),
                                                        child: SizedBox(
                                                          width:
                                                              double.infinity,
                                                          child: TextFormField(
                                                            controller: _model
                                                                .emailAddressTextController1,
                                                            focusNode: _model
                                                                .emailAddressFocusNode1,
                                                            onFieldSubmitted:
                                                                (_) async {
                                                              await authManager
                                                                  .refreshUser();
                                                              if (!((currentUserEmail !=
                                                                          '') &&
                                                                  currentUserEmailVerified)) {
                                                                context.pushNamed(
                                                                    'WelcomePage');
                                                              }
                                                            },
                                                            autofocus: true,
                                                            autofillHints: const [
                                                              AutofillHints
                                                                  .email
                                                            ],
                                                            obscureText: false,
                                                            decoration:
                                                                InputDecoration(
                                                              labelText:
                                                                  'البريد الإلكتروني',
                                                              labelStyle:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyLarge
                                                                      .override(
                                                                        fontFamily:
                                                                            'Plus Jakarta Sans',
                                                                        letterSpacing:
                                                                            0.0,
                                                                        fontWeight:
                                                                            FontWeight.normal,
                                                                      ),
                                                              alignLabelWithHint:
                                                                  false,
                                                              enabledBorder:
                                                                  OutlineInputBorder(
                                                                borderSide:
                                                                    BorderSide(
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primaryBackground,
                                                                  width: 2.0,
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            40.0),
                                                              ),
                                                              focusedBorder:
                                                                  OutlineInputBorder(
                                                                borderSide:
                                                                    const BorderSide(
                                                                  color: Color(
                                                                      0xFF06A881),
                                                                  width: 2.0,
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            40.0),
                                                              ),
                                                              errorBorder:
                                                                  OutlineInputBorder(
                                                                borderSide:
                                                                    BorderSide(
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .alternate,
                                                                  width: 2.0,
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            40.0),
                                                              ),
                                                              focusedErrorBorder:
                                                                  OutlineInputBorder(
                                                                borderSide:
                                                                    BorderSide(
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .alternate,
                                                                  width: 2.0,
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            40.0),
                                                              ),
                                                              filled: true,
                                                              fillColor: FlutterFlowTheme
                                                                      .of(context)
                                                                  .secondaryBackground,
                                                              contentPadding:
                                                                  const EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          24.0,
                                                                          24.0,
                                                                          0.0,
                                                                          24.0),
                                                            ),
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyLarge
                                                                .override(
                                                                  fontFamily:
                                                                      'Plus Jakarta Sans',
                                                                  letterSpacing:
                                                                      0.0,
                                                                ),
                                                            textAlign:
                                                                TextAlign.end,
                                                            keyboardType:
                                                                TextInputType
                                                                    .emailAddress,
                                                            validator: _model
                                                                .emailAddressTextController1Validator
                                                                .asValidator(
                                                                    context),
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0.0,
                                                                    0.0,
                                                                    0.0,
                                                                    16.0),
                                                        child: SizedBox(
                                                          width:
                                                              double.infinity,
                                                          child: TextFormField(
                                                            controller: _model
                                                                .passwordTextController1,
                                                            focusNode: _model
                                                                .passwordFocusNode1,
                                                            autofocus: true,
                                                            autofillHints: const [
                                                              AutofillHints
                                                                  .password
                                                            ],
                                                            obscureText: !_model
                                                                .passwordVisibility1,
                                                            decoration:
                                                                InputDecoration(
                                                              labelText:
                                                                  'كلمة المرور',
                                                              labelStyle:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelLarge
                                                                      .override(
                                                                        fontFamily:
                                                                            'Plus Jakarta Sans',
                                                                        letterSpacing:
                                                                            0.0,
                                                                      ),
                                                              enabledBorder:
                                                                  OutlineInputBorder(
                                                                borderSide:
                                                                    BorderSide(
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .alternate,
                                                                  width: 2.0,
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            40.0),
                                                              ),
                                                              focusedBorder:
                                                                  OutlineInputBorder(
                                                                borderSide:
                                                                    const BorderSide(
                                                                  color: Color(
                                                                      0xFF66AFA5),
                                                                  width: 2.0,
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            40.0),
                                                              ),
                                                              errorBorder:
                                                                  OutlineInputBorder(
                                                                borderSide:
                                                                    BorderSide(
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .error,
                                                                  width: 2.0,
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            40.0),
                                                              ),
                                                              focusedErrorBorder:
                                                                  OutlineInputBorder(
                                                                borderSide:
                                                                    BorderSide(
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .error,
                                                                  width: 2.0,
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            40.0),
                                                              ),
                                                              filled: true,
                                                              fillColor: FlutterFlowTheme
                                                                      .of(context)
                                                                  .secondaryBackground,
                                                              contentPadding:
                                                                  const EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          24.0,
                                                                          24.0,
                                                                          0.0,
                                                                          24.0),
                                                              suffixIcon:
                                                                  InkWell(
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
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .secondaryText,
                                                                  size: 24.0,
                                                                ),
                                                              ),
                                                            ),
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyLarge
                                                                .override(
                                                                  fontFamily:
                                                                      'Plus Jakarta Sans',
                                                                  letterSpacing:
                                                                      0.0,
                                                                ),
                                                            textAlign:
                                                                TextAlign.end,
                                                            validator: _model
                                                                .passwordTextController1Validator
                                                                .asValidator(
                                                                    context),
                                                          ),
                                                        ),
                                                      ),
                                                      Align(
                                                        alignment:
                                                            const AlignmentDirectional(
                                                                1.0, 0.0),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      16.0,
                                                                      0.0,
                                                                      0.0,
                                                                      15.0),
                                                          child: Text(
                                                            'نسيت كلمة المرور؟',
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .labelMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'Plus Jakarta Sans',
                                                                  color: const Color(
                                                                      0xFF06A881),
                                                                  fontSize:
                                                                      15.0,
                                                                  letterSpacing:
                                                                      0.0,
                                                                ),
                                                          ),
                                                        ),
                                                      ),
                                                      Align(
                                                        alignment:
                                                            const AlignmentDirectional(
                                                                0.0, 0.0),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      0.0,
                                                                      0.0,
                                                                      0.0,
                                                                      16.0),
                                                          child: FFButtonWidget(
                                                            onPressed:
                                                                () async {
                                                              GoRouter.of(
                                                                      context)
                                                                  .prepareAuthEvent();

                                                              final user =
                                                                  await authManager
                                                                      .signInWithEmail(
                                                                context,
                                                                _model
                                                                    .emailAddressTextController1
                                                                    .text,
                                                                _model
                                                                    .passwordTextController1
                                                                    .text,
                                                              );
                                                              if (user ==
                                                                  null) {
                                                                return;
                                                              }

                                                              context.goNamedAuth(
                                                                  'HomePagee',
                                                                  context
                                                                      .mounted);
                                                            },
                                                            text:
                                                                'تسجيل الدخول',
                                                            options:
                                                                FFButtonOptions(
                                                              width: 346.0,
                                                              height: 52.0,
                                                              padding:
                                                                  const EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          0.0,
                                                                          0.0,
                                                                          0.0),
                                                              iconPadding:
                                                                  const EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          0.0,
                                                                          0.0,
                                                                          0.0),
                                                              color: const Color(
                                                                  0xFF66AFA5),
                                                              textStyle: FlutterFlowTheme
                                                                      .of(context)
                                                                  .headlineMedium
                                                                  .override(
                                                                    fontFamily:
                                                                        'Urbanist',
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .secondaryBackground,
                                                                    letterSpacing:
                                                                        0.0,
                                                                  ),
                                                              elevation: 3.0,
                                                              borderSide:
                                                                  const BorderSide(
                                                                color: Colors
                                                                    .transparent,
                                                                width: 1.0,
                                                              ),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          40.0),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Align(
                                                        alignment:
                                                            const AlignmentDirectional(
                                                                0.0, 0.0),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      0.0,
                                                                      4.0,
                                                                      0.0,
                                                                      24.0),
                                                          child: RichText(
                                                            textScaler:
                                                                MediaQuery.of(
                                                                        context)
                                                                    .textScaler,
                                                            text: TextSpan(
                                                              children: [
                                                                TextSpan(
                                                                  text:
                                                                      'ليس لديك حساب مسجل ؟ ',
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .override(
                                                                        fontFamily:
                                                                            'Plus Jakarta Sans',
                                                                        letterSpacing:
                                                                            0.0,
                                                                      ),
                                                                ),
                                                                const TextSpan(
                                                                  text:
                                                                      ' إنشاء حساب جديد',
                                                                  style:
                                                                      TextStyle(
                                                                    color: Color(
                                                                        0xFF06A881),
                                                                  ),
                                                                )
                                                              ],
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .labelMedium
                                                                  .override(
                                                                    fontFamily:
                                                                        'Plus Jakarta Sans',
                                                                    letterSpacing:
                                                                        0.0,
                                                                  ),
                                                            ),
                                                            textAlign:
                                                                TextAlign.start,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ).animateOnPageLoad(animationsMap[
                                                    'columnOnPageLoadAnimation1']!),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Align(
                                              alignment: const AlignmentDirectional(
                                                  0.0, -1.0),
                                              child: Padding(
                                                padding: const EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        24.0, 16.0, 24.0, 0.0),
                                                child: SingleChildScrollView(
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      if (responsiveVisibility(
                                                        context: context,
                                                        phone: false,
                                                        tablet: false,
                                                      ))
                                                        Container(
                                                          width: 230.0,
                                                          height: 40.0,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .secondaryBackground,
                                                          ),
                                                        ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0.0,
                                                                    20.0,
                                                                    0.0,
                                                                    16.0),
                                                        child: SizedBox(
                                                          width:
                                                              double.infinity,
                                                          child: TextFormField(
                                                            controller: _model
                                                                .emailAddressTextController2,
                                                            focusNode: _model
                                                                .emailAddressFocusNode2,
                                                            autofocus: true,
                                                            autofillHints: const [
                                                              AutofillHints
                                                                  .email
                                                            ],
                                                            obscureText: false,
                                                            decoration:
                                                                InputDecoration(
                                                              labelText:
                                                                  'البريد الإلكتروني',
                                                              labelStyle:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyLarge
                                                                      .override(
                                                                        fontFamily:
                                                                            'Plus Jakarta Sans',
                                                                        letterSpacing:
                                                                            0.0,
                                                                        fontWeight:
                                                                            FontWeight.normal,
                                                                      ),
                                                              alignLabelWithHint:
                                                                  false,
                                                              enabledBorder:
                                                                  OutlineInputBorder(
                                                                borderSide:
                                                                    BorderSide(
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primaryBackground,
                                                                  width: 2.0,
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            40.0),
                                                              ),
                                                              focusedBorder:
                                                                  OutlineInputBorder(
                                                                borderSide:
                                                                    const BorderSide(
                                                                  color: Color(
                                                                      0xFF06A881),
                                                                  width: 2.0,
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            40.0),
                                                              ),
                                                              errorBorder:
                                                                  OutlineInputBorder(
                                                                borderSide:
                                                                    BorderSide(
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .alternate,
                                                                  width: 2.0,
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            40.0),
                                                              ),
                                                              focusedErrorBorder:
                                                                  OutlineInputBorder(
                                                                borderSide:
                                                                    BorderSide(
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .alternate,
                                                                  width: 2.0,
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            40.0),
                                                              ),
                                                              filled: true,
                                                              fillColor: FlutterFlowTheme
                                                                      .of(context)
                                                                  .secondaryBackground,
                                                              contentPadding:
                                                                  const EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          24.0,
                                                                          24.0,
                                                                          0.0,
                                                                          24.0),
                                                            ),
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyLarge
                                                                .override(
                                                                  fontFamily:
                                                                      'Plus Jakarta Sans',
                                                                  letterSpacing:
                                                                      0.0,
                                                                ),
                                                            textAlign:
                                                                TextAlign.end,
                                                            keyboardType:
                                                                TextInputType
                                                                    .emailAddress,
                                                            validator: _model
                                                                .emailAddressTextController2Validator
                                                                .asValidator(
                                                                    context),
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0.0,
                                                                    0.0,
                                                                    0.0,
                                                                    16.0),
                                                        child: SizedBox(
                                                          width:
                                                              double.infinity,
                                                          child: TextFormField(
                                                            controller: _model
                                                                .passwordTextController2,
                                                            focusNode: _model
                                                                .passwordFocusNode2,
                                                            autofocus: true,
                                                            autofillHints: const [
                                                              AutofillHints
                                                                  .password
                                                            ],
                                                            obscureText: !_model
                                                                .passwordVisibility2,
                                                            decoration:
                                                                InputDecoration(
                                                              labelText:
                                                                  'كلمة المرور',
                                                              labelStyle:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelLarge
                                                                      .override(
                                                                        fontFamily:
                                                                            'Plus Jakarta Sans',
                                                                        letterSpacing:
                                                                            0.0,
                                                                      ),
                                                              enabledBorder:
                                                                  OutlineInputBorder(
                                                                borderSide:
                                                                    BorderSide(
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .alternate,
                                                                  width: 2.0,
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            40.0),
                                                              ),
                                                              focusedBorder:
                                                                  OutlineInputBorder(
                                                                borderSide:
                                                                    const BorderSide(
                                                                  color: Color(
                                                                      0xFF66AFA5),
                                                                  width: 2.0,
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            40.0),
                                                              ),
                                                              errorBorder:
                                                                  OutlineInputBorder(
                                                                borderSide:
                                                                    BorderSide(
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .error,
                                                                  width: 2.0,
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            40.0),
                                                              ),
                                                              focusedErrorBorder:
                                                                  OutlineInputBorder(
                                                                borderSide:
                                                                    BorderSide(
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .error,
                                                                  width: 2.0,
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            40.0),
                                                              ),
                                                              filled: true,
                                                              fillColor: FlutterFlowTheme
                                                                      .of(context)
                                                                  .secondaryBackground,
                                                              contentPadding:
                                                                  const EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          24.0,
                                                                          24.0,
                                                                          0.0,
                                                                          24.0),
                                                              suffixIcon:
                                                                  InkWell(
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
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .secondaryText,
                                                                  size: 24.0,
                                                                ),
                                                              ),
                                                            ),
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyLarge
                                                                .override(
                                                                  fontFamily:
                                                                      'Plus Jakarta Sans',
                                                                  letterSpacing:
                                                                      0.0,
                                                                ),
                                                            textAlign:
                                                                TextAlign.end,
                                                            validator: _model
                                                                .passwordTextController2Validator
                                                                .asValidator(
                                                                    context),
                                                          ),
                                                        ),
                                                      ),
                                                      Align(
                                                        alignment:
                                                            const AlignmentDirectional(
                                                                1.0, 0.0),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      16.0,
                                                                      0.0,
                                                                      0.0,
                                                                      15.0),
                                                          child: Text(
                                                            'نسيت كلمة المرور؟',
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .labelMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'Plus Jakarta Sans',
                                                                  color: const Color(
                                                                      0xFF06A881),
                                                                  fontSize:
                                                                      15.0,
                                                                  letterSpacing:
                                                                      0.0,
                                                                ),
                                                          ),
                                                        ),
                                                      ),
                                                      Align(
                                                        alignment:
                                                            const AlignmentDirectional(
                                                                0.0, 0.0),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      0.0,
                                                                      0.0,
                                                                      0.0,
                                                                      16.0),
                                                          child: FFButtonWidget(
                                                            onPressed: () {
                                                              print(
                                                                  'Button pressed ...');
                                                            },
                                                            text:
                                                                'تسجيل الدخول',
                                                            options:
                                                                FFButtonOptions(
                                                              width: 346.0,
                                                              height: 52.0,
                                                              padding:
                                                                  const EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          0.0,
                                                                          0.0,
                                                                          0.0),
                                                              iconPadding:
                                                                  const EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          0.0,
                                                                          0.0,
                                                                          0.0),
                                                              color: const Color(
                                                                  0xFF66AFA5),
                                                              textStyle: FlutterFlowTheme
                                                                      .of(context)
                                                                  .headlineMedium
                                                                  .override(
                                                                    fontFamily:
                                                                        'Urbanist',
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .secondaryBackground,
                                                                    letterSpacing:
                                                                        0.0,
                                                                  ),
                                                              elevation: 3.0,
                                                              borderSide:
                                                                  const BorderSide(
                                                                color: Colors
                                                                    .transparent,
                                                                width: 1.0,
                                                              ),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          40.0),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Align(
                                                        alignment:
                                                            const AlignmentDirectional(
                                                                0.0, 0.0),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      0.0,
                                                                      4.0,
                                                                      0.0,
                                                                      24.0),
                                                          child: RichText(
                                                            textScaler:
                                                                MediaQuery.of(
                                                                        context)
                                                                    .textScaler,
                                                            text: TextSpan(
                                                              children: [
                                                                TextSpan(
                                                                  text:
                                                                      'ليس لديك حساب مسجل ؟ ',
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .override(
                                                                        fontFamily:
                                                                            'Plus Jakarta Sans',
                                                                        letterSpacing:
                                                                            0.0,
                                                                      ),
                                                                ),
                                                                const TextSpan(
                                                                  text:
                                                                      ' إنشاء حساب جديد',
                                                                  style:
                                                                      TextStyle(
                                                                    color: Color(
                                                                        0xFF06A881),
                                                                  ),
                                                                )
                                                              ],
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .labelMedium
                                                                  .override(
                                                                    fontFamily:
                                                                        'Plus Jakarta Sans',
                                                                    letterSpacing:
                                                                        0.0,
                                                                  ),
                                                            ),
                                                            textAlign:
                                                                TextAlign.start,
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
                                        Column(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Align(
                                              alignment: const AlignmentDirectional(
                                                  0.0, -1.0),
                                              child: Padding(
                                                padding: const EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        24.0, 16.0, 24.0, 0.0),
                                                child: SingleChildScrollView(
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      if (responsiveVisibility(
                                                        context: context,
                                                        phone: false,
                                                        tablet: false,
                                                      ))
                                                        Container(
                                                          width: 230.0,
                                                          height: 40.0,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .secondaryBackground,
                                                          ),
                                                        ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0.0,
                                                                    20.0,
                                                                    0.0,
                                                                    16.0),
                                                        child: SizedBox(
                                                          width:
                                                              double.infinity,
                                                          child: Autocomplete<
                                                              String>(
                                                            initialValue:
                                                                const TextEditingValue(),
                                                            optionsBuilder:
                                                                (textEditingValue) {
                                                              if (textEditingValue
                                                                      .text ==
                                                                  '') {
                                                                return const Iterable<
                                                                    String>.empty();
                                                              }
                                                              return [
                                                                'Option 1'
                                                              ].where((option) {
                                                                final lowercaseOption =
                                                                    option
                                                                        .toLowerCase();
                                                                return lowercaseOption
                                                                    .contains(
                                                                        textEditingValue
                                                                            .text
                                                                            .toLowerCase());
                                                              });
                                                            },
                                                            optionsViewBuilder:
                                                                (context,
                                                                    onSelected,
                                                                    options) {
                                                              return AutocompleteOptionsList(
                                                                textFieldKey: _model
                                                                    .patientEmailKey,
                                                                textController:
                                                                    _model
                                                                        .patientEmailTextController!,
                                                                options: options
                                                                    .toList(),
                                                                onSelected:
                                                                    onSelected,
                                                                textStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .override(
                                                                      fontFamily:
                                                                          'Plus Jakarta Sans',
                                                                      letterSpacing:
                                                                          0.0,
                                                                    ),
                                                                textHighlightStyle:
                                                                    const TextStyle(),
                                                                elevation: 4.0,
                                                                optionBackgroundColor:
                                                                    FlutterFlowTheme.of(
                                                                            context)
                                                                        .primaryBackground,
                                                                optionHighlightColor:
                                                                    FlutterFlowTheme.of(
                                                                            context)
                                                                        .secondaryBackground,
                                                                maxHeight:
                                                                    200.0,
                                                              );
                                                            },
                                                            onSelected: (String
                                                                selection) {
                                                              setState(() =>
                                                                  _model.patientEmailSelectedOption =
                                                                      selection);
                                                              FocusScope.of(
                                                                      context)
                                                                  .unfocus();
                                                            },
                                                            fieldViewBuilder: (
                                                              context,
                                                              textEditingController,
                                                              focusNode,
                                                              onEditingComplete,
                                                            ) {
                                                              _model.patientEmailFocusNode =
                                                                  focusNode;

                                                              _model.patientEmailTextController =
                                                                  textEditingController;
                                                              return TextFormField(
                                                                key: _model
                                                                    .patientEmailKey,
                                                                controller:
                                                                    textEditingController,
                                                                focusNode:
                                                                    focusNode,
                                                                onEditingComplete:
                                                                    onEditingComplete,
                                                                onChanged: (_) =>
                                                                    EasyDebounce
                                                                        .debounce(
                                                                  '_model.patientEmailTextController',
                                                                  const Duration(
                                                                      milliseconds:
                                                                          2000),
                                                                  () => setState(
                                                                      () {}),
                                                                ),
                                                                autofocus: true,
                                                                autofillHints: const [
                                                                  AutofillHints
                                                                      .email
                                                                ],
                                                                obscureText:
                                                                    false,
                                                                decoration:
                                                                    InputDecoration(
                                                                  labelText:
                                                                      'البريد الإلكتروني',
                                                                  labelStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyLarge
                                                                      .override(
                                                                        fontFamily:
                                                                            'Plus Jakarta Sans',
                                                                        letterSpacing:
                                                                            0.0,
                                                                        fontWeight:
                                                                            FontWeight.normal,
                                                                      ),
                                                                  alignLabelWithHint:
                                                                      false,
                                                                  errorStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyLarge
                                                                      .override(
                                                                        fontFamily:
                                                                            'Plus Jakarta Sans',
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .error,
                                                                        letterSpacing:
                                                                            0.0,
                                                                      ),
                                                                  enabledBorder:
                                                                      OutlineInputBorder(
                                                                    borderSide:
                                                                        BorderSide(
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .primaryBackground,
                                                                      width:
                                                                          2.0,
                                                                    ),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            40.0),
                                                                  ),
                                                                  focusedBorder:
                                                                      OutlineInputBorder(
                                                                    borderSide:
                                                                        const BorderSide(
                                                                      color: Color(
                                                                          0xFF06A881),
                                                                      width:
                                                                          2.0,
                                                                    ),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            40.0),
                                                                  ),
                                                                  errorBorder:
                                                                      OutlineInputBorder(
                                                                    borderSide:
                                                                        BorderSide(
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .alternate,
                                                                      width:
                                                                          2.0,
                                                                    ),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            40.0),
                                                                  ),
                                                                  focusedErrorBorder:
                                                                      OutlineInputBorder(
                                                                    borderSide:
                                                                        BorderSide(
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .alternate,
                                                                      width:
                                                                          2.0,
                                                                    ),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            40.0),
                                                                  ),
                                                                  filled: true,
                                                                  fillColor: FlutterFlowTheme.of(
                                                                          context)
                                                                      .secondaryBackground,
                                                                  contentPadding:
                                                                      const EdgeInsetsDirectional.fromSTEB(
                                                                          24.0,
                                                                          24.0,
                                                                          0.0,
                                                                          24.0),
                                                                  suffixIcon: _model
                                                                          .patientEmailTextController!
                                                                          .text
                                                                          .isNotEmpty
                                                                      ? InkWell(
                                                                          onTap:
                                                                              () async {
                                                                            _model.patientEmailTextController?.clear();
                                                                            setState(() {});
                                                                          },
                                                                          child:
                                                                              const Icon(
                                                                            Icons.clear,
                                                                            color:
                                                                                Color(0xFF757575),
                                                                            size:
                                                                                22.0,
                                                                          ),
                                                                        )
                                                                      : null,
                                                                ),
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyLarge
                                                                    .override(
                                                                      fontFamily:
                                                                          'Plus Jakarta Sans',
                                                                      letterSpacing:
                                                                          0.0,
                                                                    ),
                                                                textAlign:
                                                                    TextAlign
                                                                        .end,
                                                                keyboardType:
                                                                    TextInputType
                                                                        .emailAddress,
                                                                validator: _model
                                                                    .patientEmailTextControllerValidator
                                                                    .asValidator(
                                                                        context),
                                                              );
                                                            },
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0.0,
                                                                    0.0,
                                                                    0.0,
                                                                    16.0),
                                                        child: SizedBox(
                                                          width:
                                                              double.infinity,
                                                          child: TextFormField(
                                                            controller: _model
                                                                .patientpasswordTextController,
                                                            focusNode: _model
                                                                .patientpasswordFocusNode,
                                                            autofocus: true,
                                                            autofillHints: const [
                                                              AutofillHints
                                                                  .password
                                                            ],
                                                            obscureText: !_model
                                                                .patientpasswordVisibility,
                                                            decoration:
                                                                InputDecoration(
                                                              labelText:
                                                                  'كلمة المرور',
                                                              labelStyle:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelLarge
                                                                      .override(
                                                                        fontFamily:
                                                                            'Plus Jakarta Sans',
                                                                        letterSpacing:
                                                                            0.0,
                                                                      ),
                                                              enabledBorder:
                                                                  OutlineInputBorder(
                                                                borderSide:
                                                                    BorderSide(
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .alternate,
                                                                  width: 2.0,
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            40.0),
                                                              ),
                                                              focusedBorder:
                                                                  OutlineInputBorder(
                                                                borderSide:
                                                                    const BorderSide(
                                                                  color: Color(
                                                                      0xFF66AFA5),
                                                                  width: 2.0,
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            40.0),
                                                              ),
                                                              errorBorder:
                                                                  OutlineInputBorder(
                                                                borderSide:
                                                                    BorderSide(
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .error,
                                                                  width: 2.0,
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            40.0),
                                                              ),
                                                              focusedErrorBorder:
                                                                  OutlineInputBorder(
                                                                borderSide:
                                                                    BorderSide(
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .error,
                                                                  width: 2.0,
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            40.0),
                                                              ),
                                                              filled: true,
                                                              fillColor: FlutterFlowTheme
                                                                      .of(context)
                                                                  .secondaryBackground,
                                                              contentPadding:
                                                                  const EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          24.0,
                                                                          24.0,
                                                                          0.0,
                                                                          24.0),
                                                              suffixIcon:
                                                                  InkWell(
                                                                onTap: () =>
                                                                    setState(
                                                                  () => _model
                                                                          .patientpasswordVisibility =
                                                                      !_model
                                                                          .patientpasswordVisibility,
                                                                ),
                                                                focusNode: FocusNode(
                                                                    skipTraversal:
                                                                        true),
                                                                child: Icon(
                                                                  _model.patientpasswordVisibility
                                                                      ? Icons
                                                                          .visibility_outlined
                                                                      : Icons
                                                                          .visibility_off_outlined,
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .secondaryText,
                                                                  size: 24.0,
                                                                ),
                                                              ),
                                                            ),
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyLarge
                                                                .override(
                                                                  fontFamily:
                                                                      'Plus Jakarta Sans',
                                                                  letterSpacing:
                                                                      0.0,
                                                                ),
                                                            textAlign:
                                                                TextAlign.end,
                                                            validator: _model
                                                                .patientpasswordTextControllerValidator
                                                                .asValidator(
                                                                    context),
                                                          ),
                                                        ),
                                                      ),
                                                      Align(
                                                        alignment:
                                                            const AlignmentDirectional(
                                                                1.0, 0.0),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      16.0,
                                                                      0.0,
                                                                      0.0,
                                                                      15.0),
                                                          child: InkWell(
                                                            splashColor: Colors
                                                                .transparent,
                                                            focusColor: Colors
                                                                .transparent,
                                                            hoverColor: Colors
                                                                .transparent,
                                                            highlightColor:
                                                                Colors
                                                                    .transparent,
                                                            onTap: () async {
                                                              context.pushNamed(
                                                                  'auth_ForgotPassword');
                                                            },
                                                            child: Text(
                                                              'نسيت كلمة المرور؟',
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .labelMedium
                                                                  .override(
                                                                    fontFamily:
                                                                        'Plus Jakarta Sans',
                                                                    color: const Color(
                                                                        0xFF06A881),
                                                                    fontSize:
                                                                        15.0,
                                                                    letterSpacing:
                                                                        0.0,
                                                                  ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Align(
                                                        alignment:
                                                            const AlignmentDirectional(
                                                                0.0, 0.0),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      0.0,
                                                                      0.0,
                                                                      0.0,
                                                                      16.0),
                                                          child: FFButtonWidget(
                                                            onPressed:
                                                                () async {
                                                              GoRouter.of(
                                                                      context)
                                                                  .prepareAuthEvent();

                                                              final user =
                                                                  await authManager
                                                                      .signInWithEmail(
                                                                context,
                                                                _model
                                                                    .patientEmailTextController
                                                                    .text,
                                                                _model
                                                                    .patientpasswordTextController
                                                                    .text,
                                                              );
                                                              if (user ==
                                                                  null) {
                                                                return;
                                                              }

                                                              context.goNamedAuth(
                                                                  'HomePagee',
                                                                  context
                                                                      .mounted);
                                                            },
                                                            text:
                                                                'تسجيل الدخول',
                                                            options:
                                                                FFButtonOptions(
                                                              width: 346.0,
                                                              height: 52.0,
                                                              padding:
                                                                  const EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          0.0,
                                                                          0.0,
                                                                          0.0),
                                                              iconPadding:
                                                                  const EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          0.0,
                                                                          0.0,
                                                                          0.0),
                                                              color: const Color(
                                                                  0xFF66AFA5),
                                                              textStyle: FlutterFlowTheme
                                                                      .of(context)
                                                                  .headlineMedium
                                                                  .override(
                                                                    fontFamily:
                                                                        'Urbanist',
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .secondaryBackground,
                                                                    letterSpacing:
                                                                        0.0,
                                                                  ),
                                                              elevation: 3.0,
                                                              borderSide:
                                                                  const BorderSide(
                                                                color: Colors
                                                                    .transparent,
                                                                width: 1.0,
                                                              ),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          40.0),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Align(
                                                        alignment:
                                                            const AlignmentDirectional(
                                                                0.0, 0.0),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      0.0,
                                                                      4.0,
                                                                      0.0,
                                                                      24.0),
                                                          child: InkWell(
                                                            splashColor: Colors
                                                                .transparent,
                                                            focusColor: Colors
                                                                .transparent,
                                                            hoverColor: Colors
                                                                .transparent,
                                                            highlightColor:
                                                                Colors
                                                                    .transparent,
                                                            onTap: () async {
                                                              context.pushNamed(
                                                                  'CreateAccount');
                                                            },
                                                            child: RichText(
                                                              textScaler:
                                                                  MediaQuery.of(
                                                                          context)
                                                                      .textScaler,
                                                              text: TextSpan(
                                                                children: [
                                                                  TextSpan(
                                                                    text:
                                                                        'ليس لديك حساب مسجل ؟ ',
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .labelMedium
                                                                        .override(
                                                                          fontFamily:
                                                                              'Plus Jakarta Sans',
                                                                          letterSpacing:
                                                                              0.0,
                                                                        ),
                                                                  ),
                                                                  const TextSpan(
                                                                    text:
                                                                        ' إنشاء حساب جديد',
                                                                    style:
                                                                        TextStyle(
                                                                      color: Color(
                                                                          0xFF06A881),
                                                                    ),
                                                                  )
                                                                ],
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .override(
                                                                      fontFamily:
                                                                          'Plus Jakarta Sans',
                                                                      letterSpacing:
                                                                          0.0,
                                                                    ),
                                                              ),
                                                              textAlign:
                                                                  TextAlign
                                                                      .start,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ).animateOnPageLoad(animationsMap[
                                                    'columnOnPageLoadAnimation3']!),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Align(
                              alignment: const AlignmentDirectional(0.0, -1.0),
                              child: Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    0.0, 12.0, 0.0, 0.0),
                                child: Text(
                                  'تسجيل الدخول',
                                  style: FlutterFlowTheme.of(context)
                                      .titleLarge
                                      .override(
                                        fontFamily: 'Urbanist',
                                        fontSize: 30.0,
                                        letterSpacing: 0.0,
                                      ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ).animateOnPageLoad(
                        animationsMap['containerOnPageLoadAnimation']!),
                  ),
                  Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            32.0, 12.0, 32.0, 32.0),
                        child: Container(
                          width: double.infinity,
                          height: 228.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          alignment: const AlignmentDirectional(0.0, 0.0),
                        ),
                      ),
                      Align(
                        alignment: const AlignmentDirectional(-0.02, -0.71),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.asset(
                            'assets/images/logoG.png',
                            width: 300.0,
                            height: 142.0,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Align(
                alignment: const AlignmentDirectional(0.0, 0.0),
                child: Stack(
                  children: [
                    Align(
                      alignment: const AlignmentDirectional(0.0, -1.19),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.asset(
                          'assets/images/Vector_6.png',
                          width: 642.0,
                          height: 268.0,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Align(
                      alignment: const AlignmentDirectional(0.0, -1.24),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.asset(
                          'assets/images/Vector_7.png',
                          width: 465.0,
                          height: 217.0,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
