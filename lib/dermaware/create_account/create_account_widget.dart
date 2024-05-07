import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'create_account_model.dart';
export 'create_account_model.dart';

class CreateAccountWidget extends StatefulWidget {
  const CreateAccountWidget({super.key});

  @override
  State<CreateAccountWidget> createState() => _CreateAccountWidgetState();
}

class _CreateAccountWidgetState extends State<CreateAccountWidget> {
  late CreateAccountModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CreateAccountModel());

    _model.fullnameTextController ??= TextEditingController();
    _model.fullnameFocusNode ??= FocusNode();

    _model.phonenumberTextController ??= TextEditingController();
    _model.phonenumberFocusNode ??= FocusNode();

    _model.emailAddressTextController ??= TextEditingController();
    _model.emailAddressFocusNode ??= FocusNode();

    _model.passwordTextController ??= TextEditingController();
    _model.passwordFocusNode ??= FocusNode();

    _model.passwordConfirmTextController ??= TextEditingController();
    _model.passwordConfirmFocusNode ??= FocusNode();
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
        backgroundColor: const Color(0xFF73BCB2),
        body: SafeArea(
          top: true,
          child: Form(
            key: _model.formKey,
            autovalidateMode: AutovalidateMode.always,
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0.0, 60.0, 0.0, 0.0),
              child: Container(
                width: 424.0,
                height: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xFFE1E1E1),
                  borderRadius: BorderRadius.circular(40.0),
                ),
                alignment: const AlignmentDirectional(0.0, -1.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Align(
                        alignment: const AlignmentDirectional(0.0, 0.0),
                        child: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              25.0, 20.0, 25.0, 32.0),
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                FlutterFlowIconButton(
                                  borderColor: Colors.transparent,
                                  borderRadius: 20.0,
                                  borderWidth: 1.0,
                                  buttonSize: 40.0,
                                  icon: const Icon(
                                    Icons.dangerous,
                                    color: Color(0xFF037562),
                                    size: 30.0,
                                  ),
                                  onPressed: () async {
                                    context.safePop();
                                  },
                                ),
                                Align(
                                  alignment: const AlignmentDirectional(1.0, 0.0),
                                  child: Text(
                                    'تسجيل حساب جديد',
                                    style: FlutterFlowTheme.of(context)
                                        .displaySmall
                                        .override(
                                          fontFamily: 'Urbanist',
                                          fontSize: 30.0,
                                          letterSpacing: 0.0,
                                        ),
                                  ),
                                ),
                                Align(
                                  alignment: const AlignmentDirectional(1.0, 0.0),
                                  child: Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(
                                        0.0, 12.0, 0.0, 10.0),
                                    child: Text(
                                      'قم بتعبئة البيانات التالية لإكمال تسجيل حسابك',
                                      style: FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .override(
                                            fontFamily: 'Plus Jakarta Sans',
                                            letterSpacing: 0.0,
                                          ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 0.0, 16.0),
                                  child: SizedBox(
                                    width: 370.0,
                                    child: TextFormField(
                                      controller: _model.fullnameTextController,
                                      focusNode: _model.fullnameFocusNode,
                                      autofocus: true,
                                      autofillHints: const [AutofillHints.name],
                                      obscureText: false,
                                      decoration: InputDecoration(
                                        labelText: 'الإسم الكامل',
                                        labelStyle: FlutterFlowTheme.of(context)
                                            .labelMedium
                                            .override(
                                              fontFamily: 'Plus Jakarta Sans',
                                              letterSpacing: 0.0,
                                            ),
                                        alignLabelWithHint: false,
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: FlutterFlowTheme.of(context)
                                                .primaryBackground,
                                            width: 2.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            color: Color(0xFF77C0B6),
                                            width: 2.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: FlutterFlowTheme.of(context)
                                                .error,
                                            width: 2.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                        ),
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: FlutterFlowTheme.of(context)
                                                .error,
                                            width: 2.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                        ),
                                        filled: true,
                                        fillColor: FlutterFlowTheme.of(context)
                                            .primaryBackground,
                                      ),
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'Plus Jakarta Sans',
                                            letterSpacing: 0.0,
                                          ),
                                      textAlign: TextAlign.end,
                                      maxLength: 100,
                                      buildCounter: (context,
                                              {required currentLength,
                                              required isFocused,
                                              maxLength}) =>
                                          null,
                                      validator: _model
                                          .fullnameTextControllerValidator
                                          .asValidator(context),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 0.0, 16.0),
                                  child: SizedBox(
                                    width: 370.0,
                                    child: TextFormField(
                                      controller:
                                          _model.phonenumberTextController,
                                      focusNode: _model.phonenumberFocusNode,
                                      onChanged: (_) => EasyDebounce.debounce(
                                        '_model.phonenumberTextController',
                                        const Duration(milliseconds: 2000),
                                        () => setState(() {}),
                                      ),
                                      autofocus: true,
                                      textCapitalization:
                                          TextCapitalization.none,
                                      obscureText: false,
                                      decoration: InputDecoration(
                                        isDense: false,
                                        labelText: 'رقم الجوال',
                                        alignLabelWithHint: true,
                                        hintText: '05********',
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: FlutterFlowTheme.of(context)
                                                .primaryBackground,
                                            width: 2.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            color: Color(0xFF77C0B6),
                                            width: 2.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: FlutterFlowTheme.of(context)
                                                .error,
                                            width: 2.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                        ),
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: FlutterFlowTheme.of(context)
                                                .error,
                                            width: 2.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                        ),
                                        filled: true,
                                        fillColor: FlutterFlowTheme.of(context)
                                            .primaryBackground,
                                        suffixIcon: _model
                                                .phonenumberTextController!
                                                .text
                                                .isNotEmpty
                                            ? InkWell(
                                                onTap: () async {
                                                  _model
                                                      .phonenumberTextController
                                                      ?.clear();
                                                  setState(() {});
                                                },
                                                child: const Icon(
                                                  Icons.clear,
                                                  color: Color(0xFF757575),
                                                  size: 22.0,
                                                ),
                                              )
                                            : null,
                                      ),
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'Plus Jakarta Sans',
                                            letterSpacing: 0.0,
                                          ),
                                      textAlign: TextAlign.end,
                                      maxLength: 10,
                                      maxLengthEnforcement:
                                          MaxLengthEnforcement.enforced,
                                      validator: _model
                                          .phonenumberTextControllerValidator
                                          .asValidator(context),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 0.0, 16.0),
                                  child: SizedBox(
                                    width: 370.0,
                                    child: TextFormField(
                                      controller:
                                          _model.emailAddressTextController,
                                      focusNode: _model.emailAddressFocusNode,
                                      onChanged: (_) => EasyDebounce.debounce(
                                        '_model.emailAddressTextController',
                                        const Duration(milliseconds: 2000),
                                        () => setState(() {}),
                                      ),
                                      autofocus: true,
                                      autofillHints: const [AutofillHints.email],
                                      obscureText: false,
                                      decoration: InputDecoration(
                                        labelText: 'البريد الإلكتروني',
                                        labelStyle: FlutterFlowTheme.of(context)
                                            .labelMedium
                                            .override(
                                              fontFamily: 'Plus Jakarta Sans',
                                              letterSpacing: 0.0,
                                            ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: FlutterFlowTheme.of(context)
                                                .primaryBackground,
                                            width: 2.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            color: Color(0xFF77C0B6),
                                            width: 2.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: FlutterFlowTheme.of(context)
                                                .error,
                                            width: 2.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                        ),
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: FlutterFlowTheme.of(context)
                                                .error,
                                            width: 2.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                        ),
                                        filled: true,
                                        fillColor: FlutterFlowTheme.of(context)
                                            .primaryBackground,
                                        suffixIcon: _model
                                                .emailAddressTextController!
                                                .text
                                                .isNotEmpty
                                            ? InkWell(
                                                onTap: () async {
                                                  _model
                                                      .emailAddressTextController
                                                      ?.clear();
                                                  setState(() {});
                                                },
                                                child: const Icon(
                                                  Icons.clear,
                                                  color: Color(0xFF757575),
                                                  size: 22.0,
                                                ),
                                              )
                                            : null,
                                      ),
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'Plus Jakarta Sans',
                                            letterSpacing: 0.0,
                                          ),
                                      textAlign: TextAlign.end,
                                      keyboardType: TextInputType.emailAddress,
                                      validator: _model
                                          .emailAddressTextControllerValidator
                                          .asValidator(context),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 0.0, 16.0),
                                  child: SizedBox(
                                    width: 370.0,
                                    child: TextFormField(
                                      controller: _model.passwordTextController,
                                      focusNode: _model.passwordFocusNode,
                                      autofocus: true,
                                      autofillHints: const [AutofillHints.password],
                                      obscureText: !_model.passwordVisibility,
                                      decoration: InputDecoration(
                                        labelText: 'كلمة المرور',
                                        labelStyle: FlutterFlowTheme.of(context)
                                            .labelMedium
                                            .override(
                                              fontFamily: 'Plus Jakarta Sans',
                                              letterSpacing: 0.0,
                                            ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: FlutterFlowTheme.of(context)
                                                .primaryBackground,
                                            width: 2.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            color: Color(0xFF77C0B6),
                                            width: 2.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: FlutterFlowTheme.of(context)
                                                .error,
                                            width: 2.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                        ),
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: FlutterFlowTheme.of(context)
                                                .error,
                                            width: 2.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                        ),
                                        filled: true,
                                        fillColor: FlutterFlowTheme.of(context)
                                            .primaryBackground,
                                        suffixIcon: InkWell(
                                          onTap: () => setState(
                                            () => _model.passwordVisibility =
                                                !_model.passwordVisibility,
                                          ),
                                          focusNode:
                                              FocusNode(skipTraversal: true),
                                          child: Icon(
                                            _model.passwordVisibility
                                                ? Icons.visibility_outlined
                                                : Icons.visibility_off_outlined,
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryText,
                                            size: 24.0,
                                          ),
                                        ),
                                      ),
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'Plus Jakarta Sans',
                                            letterSpacing: 0.0,
                                          ),
                                      textAlign: TextAlign.end,
                                      validator: _model
                                          .passwordTextControllerValidator
                                          .asValidator(context),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 370.0,
                                  child: TextFormField(
                                    controller:
                                        _model.passwordConfirmTextController,
                                    focusNode: _model.passwordConfirmFocusNode,
                                    autofocus: true,
                                    autofillHints: const [AutofillHints.password],
                                    obscureText:
                                        !_model.passwordConfirmVisibility,
                                    decoration: InputDecoration(
                                      labelText: 'تأكيد كلمة المرور',
                                      labelStyle: FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .override(
                                            fontFamily: 'Plus Jakarta Sans',
                                            letterSpacing: 0.0,
                                          ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(context)
                                              .primaryBackground,
                                          width: 2.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Color(0xFF77C0B6),
                                          width: 2.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(context)
                                              .error,
                                          width: 2.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(context)
                                              .error,
                                          width: 2.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                      ),
                                      filled: true,
                                      fillColor: FlutterFlowTheme.of(context)
                                          .primaryBackground,
                                      suffixIcon: InkWell(
                                        onTap: () => setState(
                                          () => _model
                                                  .passwordConfirmVisibility =
                                              !_model.passwordConfirmVisibility,
                                        ),
                                        focusNode:
                                            FocusNode(skipTraversal: true),
                                        child: Icon(
                                          _model.passwordConfirmVisibility
                                              ? Icons.visibility_outlined
                                              : Icons.visibility_off_outlined,
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryText,
                                          size: 24.0,
                                        ),
                                      ),
                                    ),
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Plus Jakarta Sans',
                                          letterSpacing: 0.0,
                                        ),
                                    textAlign: TextAlign.end,
                                    minLines: 1,
                                    validator: _model
                                        .passwordConfirmTextControllerValidator
                                        .asValidator(context),
                                  ),
                                ),
                                Align(
                                  alignment: const AlignmentDirectional(1.0, 0.0),
                                  child: Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(
                                        0.0, 10.0, 20.0, 0.0),
                                    child: Text(
                                      'الجنس',
                                      style: FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .override(
                                            fontFamily: 'Plus Jakarta Sans',
                                            fontSize: 20.0,
                                            letterSpacing: 0.0,
                                          ),
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: const AlignmentDirectional(0.0, 0.0),
                                  child: Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 0.0, 10.0),
                                    child: FlutterFlowDropDown<String>(
                                      controller:
                                          _model.genderValueController ??=
                                              FormFieldController<String>(null),
                                      options: const ['ذكر', 'أنثى'],
                                      onChanged: (val) => setState(
                                          () => _model.genderValue = val),
                                      width: 299.0,
                                      height: 54.0,
                                      textStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'Plus Jakarta Sans',
                                            letterSpacing: 0.0,
                                          ),
                                      hintText: 'أنا..',
                                      icon: Icon(
                                        Icons.keyboard_arrow_down_rounded,
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryText,
                                        size: 24.0,
                                      ),
                                      fillColor: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                      elevation: 2.0,
                                      borderColor: FlutterFlowTheme.of(context)
                                          .alternate,
                                      borderWidth: 2.0,
                                      borderRadius: 8.0,
                                      margin: const EdgeInsetsDirectional.fromSTEB(
                                          16.0, 4.0, 16.0, 4.0),
                                      hidesUnderline: true,
                                      isOverButton: true,
                                      isSearchable: false,
                                      isMultiSelect: false,
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: const AlignmentDirectional(1.0, -1.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        valueOrDefault<String>(
                                          dateTimeFormat(
                                              'd/M/y', _model.datePicked),
                                          'date',
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'Plus Jakarta Sans',
                                              letterSpacing: 0.0,
                                            ),
                                      ),
                                      Align(
                                        alignment:
                                            const AlignmentDirectional(0.0, 0.0),
                                        child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: FFButtonWidget(
                                            onPressed: () async {
                                              await showModalBottomSheet<bool>(
                                                  context: context,
                                                  builder: (context) {
                                                    final datePickedCupertinoTheme =
                                                        CupertinoTheme.of(
                                                            context);
                                                    return Container(
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height /
                                                              3,
                                                      width:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                      color: FlutterFlowTheme
                                                              .of(context)
                                                          .secondaryBackground,
                                                      child: CupertinoTheme(
                                                        data:
                                                            datePickedCupertinoTheme
                                                                .copyWith(
                                                          textTheme:
                                                              datePickedCupertinoTheme
                                                                  .textTheme
                                                                  .copyWith(
                                                            dateTimePickerTextStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .headlineMedium
                                                                    .override(
                                                                      fontFamily:
                                                                          'Urbanist',
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .primaryText,
                                                                      letterSpacing:
                                                                          0.0,
                                                                    ),
                                                          ),
                                                        ),
                                                        child:
                                                            CupertinoDatePicker(
                                                          mode:
                                                              CupertinoDatePickerMode
                                                                  .date,
                                                          minimumDate:
                                                              DateTime(1900),
                                                          initialDateTime: DateTime
                                                              .fromMicrosecondsSinceEpoch(
                                                                  1714942800000000),
                                                          maximumDate: DateTime
                                                              .fromMicrosecondsSinceEpoch(
                                                                  1714942800000000),
                                                          backgroundColor:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .secondaryBackground,
                                                          use24hFormat: false,
                                                          onDateTimeChanged:
                                                              (newDateTime) =>
                                                                  safeSetState(
                                                                      () {
                                                            _model.datePicked =
                                                                newDateTime;
                                                          }),
                                                        ),
                                                      ),
                                                    );
                                                  });

                                              await currentUserReference!
                                                  .update(
                                                      createUserssRecordData(
                                                dateOfBirth: _model.datePicked,
                                              ));
                                            },
                                            text: 'ادخل التاريخ',
                                            options: FFButtonOptions(
                                              height: 40.0,
                                              padding: const EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      24.0, 0.0, 24.0, 0.0),
                                              iconPadding: const EdgeInsetsDirectional
                                                  .fromSTEB(0.0, 0.0, 0.0, 0.0),
                                              color: const Color(0xFF9BC8C3),
                                              textStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .titleSmall
                                                      .override(
                                                        fontFamily:
                                                            'Plus Jakarta Sans',
                                                        color: Colors.white,
                                                        letterSpacing: 0.0,
                                                      ),
                                              elevation: 3.0,
                                              borderSide: const BorderSide(
                                                color: Colors.transparent,
                                                width: 1.0,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment:
                                            const AlignmentDirectional(0.0, 0.0),
                                        child: Padding(
                                          padding:
                                              const EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 0.0, 20.0, 0.0),
                                          child: Text(
                                            'تاريخ الميلاد',
                                            style: FlutterFlowTheme.of(context)
                                                .labelMedium
                                                .override(
                                                  fontFamily:
                                                      'Plus Jakarta Sans',
                                                  fontSize: 20.0,
                                                  letterSpacing: 0.0,
                                                ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Align(
                                  alignment: const AlignmentDirectional(0.0, 0.0),
                                  child: Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 0.0, 16.0),
                                    child: FFButtonWidget(
                                      onPressed: () async {
                                        if (_model.formKey.currentState ==
                                                null ||
                                            !_model.formKey.currentState!
                                                .validate()) {
                                          return;
                                        }
                                        if (_model.genderValue == null) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                'خطأ: حقل الجنس مطلوب',
                                                style: GoogleFonts.getFont(
                                                  'Roboto',
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primaryText,
                                                  fontSize: 8.0,
                                                  height: 16.0,
                                                ),
                                              ),
                                              duration:
                                                  const Duration(milliseconds: 4000),
                                              backgroundColor:
                                                  FlutterFlowTheme.of(context)
                                                      .error,
                                            ),
                                          );
                                          return;
                                        }
                                        if (_model.datePicked == null) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                'خطأ: تاريخ الميلاد مطلوب',
                                                style: TextStyle(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primaryText,
                                                ),
                                              ),
                                              duration:
                                                  const Duration(milliseconds: 4000),
                                              backgroundColor:
                                                  FlutterFlowTheme.of(context)
                                                      .error,
                                            ),
                                          );
                                          return;
                                        }
                                        GoRouter.of(context).prepareAuthEvent();
                                        if (_model
                                                .passwordTextController.text !=
                                            _model.passwordConfirmTextController
                                                .text) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                              content: Text(
                                                'Passwords don\'t match!',
                                              ),
                                            ),
                                          );
                                          return;
                                        }

                                        final user = await authManager
                                            .createAccountWithEmail(
                                          context,
                                          _model
                                              .emailAddressTextController.text,
                                          _model.passwordTextController.text,
                                        );
                                        if (user == null) {
                                          return;
                                        }

                                        await UserssRecord.collection
                                            .doc(user.uid)
                                            .update(createUserssRecordData(
                                              email: _model
                                                  .emailAddressTextController
                                                  .text,
                                              fullname: _model
                                                  .fullnameTextController.text,
                                              password: _model
                                                  .passwordTextController.text,
                                              gender: _model.genderValue,
                                              displayName: '',
                                              photoUrl: '',
                                              uid: '',
                                              phoneNumber: _model
                                                  .phonenumberTextController
                                                  .text,
                                              dateOfBirth: _model.datePicked,
                                            ));

                                        await authManager
                                            .sendEmailVerification();

                                        context.pushNamedAuth(
                                            'HomePagee', context.mounted);
                                      },
                                      text: 'تسجيل',
                                      options: FFButtonOptions(
                                        width: 339.0,
                                        height: 57.0,
                                        padding: const EdgeInsetsDirectional.fromSTEB(
                                            0.0, 0.0, 0.0, 0.0),
                                        iconPadding:
                                            const EdgeInsetsDirectional.fromSTEB(
                                                0.0, 0.0, 0.0, 0.0),
                                        color: const Color(0xFF66AFA5),
                                        textStyle: FlutterFlowTheme.of(context)
                                            .headlineMedium
                                            .override(
                                              fontFamily: 'Urbanist',
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryBackground,
                                              letterSpacing: 0.0,
                                            ),
                                        elevation: 3.0,
                                        borderSide: const BorderSide(
                                          color: Colors.transparent,
                                          width: 1.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                      ),
                                    ),
                                  ),
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
            ),
          ),
        ),
      ),
    );
  }
}
