import '/flutter_flow/flutter_flow_util.dart';
import 'case_page_widget.dart' show CasePageWidget;
import 'package:flutter/material.dart';

class CasePageModel extends FlutterFlowModel<CasePageWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
  }
}
