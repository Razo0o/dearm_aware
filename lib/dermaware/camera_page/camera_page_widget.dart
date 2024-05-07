import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/custom_functions.dart' as functions;
import '/flutter_flow/random_data_util.dart' as random_data;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'camera_page_model.dart';
export 'camera_page_model.dart';

class CameraPageWidget extends StatefulWidget {
  const CameraPageWidget({super.key});

  @override
  State<CameraPageWidget> createState() => _CameraPageWidgetState();
}

class _CameraPageWidgetState extends State<CameraPageWidget> {
  late CameraPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CameraPageModel());
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        drawer: SizedBox(
          width: double.infinity,
          child: Drawer(
            elevation: 16.0,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Align(
                  alignment: const AlignmentDirectional(1.0, 0.0),
                  child: Container(
                    width: MediaQuery.sizeOf(context).width * 1.0,
                    height: MediaQuery.sizeOf(context).height * 0.157,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                      border: Border.all(
                        color: const Color(0xFF037562),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Align(
                          alignment: const AlignmentDirectional(-1.0, 1.0),
                          child: Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 15.0),
                            child: FlutterFlowIconButton(
                              borderColor: Colors.transparent,
                              borderRadius: 50.0,
                              borderWidth: 1.0,
                              buttonSize: 49.0,
                              fillColor: const Color(0xFF66AFA5),
                              icon: Icon(
                                Icons.arrow_back_ios,
                                color: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                                size: 18.0,
                              ),
                              onPressed: () async {
                                context.safePop();
                              },
                            ),
                          ),
                        ),
                        Align(
                          alignment: const AlignmentDirectional(1.0, 1.0),
                          child: Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 10.0),
                            child: Text(
                              'طريقة التصوير',
                              textAlign: TextAlign.end,
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Plus Jakarta Sans',
                                    color: const Color(0xFF037562),
                                    fontSize: 25.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w800,
                                  ),
                            ),
                          ),
                        ),
                      ]
                          .divide(const SizedBox(width: 16.0))
                          .around(const SizedBox(width: 16.0)),
                    ),
                  ),
                ),
                Align(
                  alignment: const AlignmentDirectional(0.0, -1.0),
                  child: Container(
                    width: MediaQuery.sizeOf(context).width * 1.0,
                    height: MediaQuery.sizeOf(context).height * 0.562,
                    decoration: const BoxDecoration(),
                    child: Align(
                      alignment: const AlignmentDirectional(0.0, -1.0),
                      child: Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0.0, 50.0, 0.0, 0.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Flexible(
                              child: Align(
                                alignment: const AlignmentDirectional(0.0, 1.0),
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 15.0, 0.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        'تأكد من أن المنطقة التي تريد\n تشخيصها مضاءة جيدًا ومرئية\n .بالكامل في إطار الكاميرا',
                                        textAlign: TextAlign.end,
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'Plus Jakarta Sans',
                                              fontSize: 18.0,
                                              letterSpacing: 0.0,
                                            ),
                                      ),
                                      Icon(
                                        Icons.camera_front,
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryText,
                                        size: 100.0,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Align(
                              alignment: const AlignmentDirectional(0.0, -1.0),
                              child: Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    0.0, 45.0, 0.0, 0.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Icon(
                                      Icons.camera_enhance_sharp,
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryText,
                                      size: 90.0,
                                    ),
                                    Padding(
                                      padding: const EdgeInsetsDirectional.fromSTEB(
                                          18.0, 0.0, 0.0, 0.0),
                                      child: Text(
                                        'أمسك الكاميرا بثبات أو استخدم سطحًا\n .ثابتًا لتجنب التشويش',
                                        textAlign: TextAlign.end,
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'Plus Jakarta Sans',
                                              fontSize: 18.0,
                                              letterSpacing: 0.0,
                                            ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Align(
                              alignment: const AlignmentDirectional(0.0, -1.0),
                              child: Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    0.0, 45.0, 0.0, 20.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Align(
                                      alignment:
                                          const AlignmentDirectional(0.0, -1.0),
                                      child: Padding(
                                        padding: const EdgeInsetsDirectional.fromSTEB(
                                            12.0, 0.0, 0.0, 0.0),
                                        child: Text(
                                          '.تحقق من وضوح وإضاءة صورك قبل إرسالها',
                                          textAlign: TextAlign.end,
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily: 'Plus Jakarta Sans',
                                                fontSize: 17.0,
                                                letterSpacing: 0.0,
                                              ),
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: const AlignmentDirectional(0.0, 1.0),
                                      child: Icon(
                                        Icons.upload_rounded,
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryText,
                                        size: 100.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: SizedBox(
          width: MediaQuery.sizeOf(context).width * 1.0,
          height: MediaQuery.sizeOf(context).height * 1.0,
          child: Stack(
            children: [
              Align(
                alignment: const AlignmentDirectional(0.0, 0.0),
                child: Container(
                  width: MediaQuery.sizeOf(context).width * 1.0,
                  height: MediaQuery.sizeOf(context).height * 1.0,
                  decoration: const BoxDecoration(
                    color: Color(0xC27AAAA1),
                  ),
                  child: Align(
                    alignment: const AlignmentDirectional(0.0, -0.2),
                    child: SizedBox(
                      width: MediaQuery.sizeOf(context).width * 1.0,
                      height: MediaQuery.sizeOf(context).height * 0.74,
                      child: custom_widgets.CameraPhoto(
                        width: MediaQuery.sizeOf(context).width * 1.0,
                        height: MediaQuery.sizeOf(context).height * 0.74,
                      ),
                    ),
                  ),
                ),
              ),
              if (FFAppState().isTake == false)
                Align(
                  alignment: const AlignmentDirectional(0.0, 1.0),
                  child: Padding(
                    padding:
                        const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 20.0),
                    child: InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () async {
                        setState(() {
                          FFAppState().makePhoto = true;
                        });
                      },
                      child: Container(
                        width: 100.0,
                        height: 100.0,
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).accent4,
                          shape: BoxShape.circle,
                        ),
                        child: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              5.0, 5.0, 5.0, 5.0),
                          child: Container(
                            width: 100.0,
                            height: 100.0,
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context).accent4,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: const Color(0x7B4B986C),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              if (FFAppState().isTake == false)
                Align(
                  alignment: const AlignmentDirectional(0.76, 1.02),
                  child: Padding(
                    padding:
                        const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 10.0, 50.0),
                    child: FlutterFlowIconButton(
                      borderColor: Colors.transparent,
                      borderRadius: 20.0,
                      borderWidth: 1.0,
                      buttonSize: 54.0,
                      fillColor: const Color(0xFF3B4447),
                      icon: Icon(
                        Icons.sync,
                        color: FlutterFlowTheme.of(context).secondaryBackground,
                        size: 24.0,
                      ),
                      onPressed: () async {
                        FFAppState().update(() {
                          FFAppState().isBackCamera =
                              FFAppState().isBackCamera == true ? false : true;
                        });
                      },
                    ),
                  ),
                ),
              if (FFAppState().isTake == true)
                Align(
                  alignment: const AlignmentDirectional(0.0, -0.2),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.memory(
                      functions.base64toFile(FFAppState().fileBase64)?.bytes ??
                          Uint8List.fromList([]),
                      width: MediaQuery.sizeOf(context).width * 1.0,
                      height: MediaQuery.sizeOf(context).height * 0.74,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              if (FFAppState().isTake == false)
                Align(
                  alignment: const AlignmentDirectional(0.97, -0.94),
                  child: Padding(
                    padding:
                        const EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 10.0, 0.0),
                    child: FlutterFlowIconButton(
                      borderColor: Colors.transparent,
                      borderRadius: 100.0,
                      borderWidth: 1.0,
                      buttonSize: 55.0,
                      icon: Icon(
                        Icons.help_outline,
                        color: FlutterFlowTheme.of(context).secondaryBackground,
                        size: 40.0,
                      ),
                      onPressed: () async {
                        scaffoldKey.currentState!.openDrawer();
                      },
                    ),
                  ),
                ),
              if (FFAppState().isTake == false)
                Align(
                  alignment: const AlignmentDirectional(-0.92, -0.94),
                  child: Padding(
                    padding:
                        const EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 10.0, 0.0),
                    child: FlutterFlowIconButton(
                      borderColor: Colors.transparent,
                      borderRadius: 100.0,
                      borderWidth: 0.0,
                      buttonSize: 55.0,
                      icon: Icon(
                        Icons.arrow_back_sharp,
                        color: FlutterFlowTheme.of(context).secondaryBackground,
                        size: 40.0,
                      ),
                      onPressed: () async {
                        context.safePop();
                      },
                    ),
                  ),
                ),
              if (FFAppState().isTake == true)
                Align(
                  alignment: const AlignmentDirectional(-0.84, 0.85),
                  child: FFButtonWidget(
                    onPressed: () async {
                      await ImagesRecord.collection
                          .doc()
                          .set(createImagesRecordData(
                            photo: random_data.randomImageUrl(
                              200,
                              200,
                            ),
                          ));
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'تم حفظ الصورة بنجاح',
                            style: TextStyle(
                              color: FlutterFlowTheme.of(context)
                                  .primaryBackground,
                            ),
                          ),
                          duration: const Duration(milliseconds: 4000),
                          backgroundColor: FlutterFlowTheme.of(context).success,
                        ),
                      );

                      context.pushNamed('CasePage');
                    },
                    text: 'حفظ الصورة',
                    icon: const Icon(
                      Icons.done_outline_rounded,
                      size: 20.0,
                    ),
                    options: FFButtonOptions(
                      height: 51.0,
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
                      iconPadding:
                          const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                      color: FlutterFlowTheme.of(context).primary,
                      textStyle:
                          FlutterFlowTheme.of(context).titleSmall.override(
                                fontFamily: 'Plus Jakarta Sans',
                                color: Colors.white,
                                fontSize: 18.0,
                                letterSpacing: 0.0,
                              ),
                      elevation: 3.0,
                      borderSide: const BorderSide(
                        color: Colors.transparent,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
              if (FFAppState().isTake == true)
                Align(
                  alignment: const AlignmentDirectional(0.81, 0.85),
                  child: FFButtonWidget(
                    onPressed: () async {
                      setState(() {
                        FFAppState().isTake = false;
                      });
                    },
                    text: 'إعادة التقاط',
                    icon: const Icon(
                      Icons.refresh,
                      size: 20.0,
                    ),
                    options: FFButtonOptions(
                      height: 51.0,
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
                      iconPadding:
                          const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                      color: FlutterFlowTheme.of(context).error,
                      textStyle:
                          FlutterFlowTheme.of(context).titleSmall.override(
                                fontFamily: 'Plus Jakarta Sans',
                                color: Colors.white,
                                fontSize: 18.0,
                                letterSpacing: 0.0,
                              ),
                      elevation: 3.0,
                      borderSide: const BorderSide(
                        color: Colors.transparent,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
