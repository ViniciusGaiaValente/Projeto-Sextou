import 'package:flutter/material.dart';
import 'package:sextou_cadastro/widgets/custom_form/feedback_label/feedback_label_bloc.dart';

class FeedbackLabel extends StatelessWidget {

  FeedbackLabelBloc _feedbackLabelBloc = FeedbackLabelBloc();

  changeStatus({@required Status status}) {
    _feedbackLabelBloc.changeStatus(status: status);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _feedbackLabelBloc.stream,
      builder: (context, snapshot) {
        return snapshot.data;
      },
    );
  }
}
