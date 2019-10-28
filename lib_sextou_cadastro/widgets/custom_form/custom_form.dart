import 'package:flutter/material.dart';
import 'package:sextou_cadastro/models/event.dart';
import 'package:sextou_cadastro/models/firebase_connection.dart';
import 'package:sextou_cadastro/models/navigator_bloc.dart';
import 'package:sextou_cadastro/widgets/custom_form/custom_field/custom_field.dart';
import 'package:sextou_cadastro/widgets/custom_form/custom_switcher/custom_switcher.dart';
import 'package:sextou_cadastro/widgets/custom_form/date_selector/date_selector.dart';
import 'package:sextou_cadastro/widgets/custom_form/feedback_label/feedback_label_bloc.dart';
import 'package:sextou_cadastro/widgets/custom_form/image_selector/image_selector.dart';
import '../../models/navigator_bloc.dart';

class CustomForm extends StatefulWidget {

  @override
  _CustomFormState createState() => _CustomFormState();
}

class _CustomFormState extends State<CustomForm> {

  FeedbackLabelBloc _feedbackLabelBloc = FeedbackLabelBloc();

  validateEvent({@required Event event}) {
    if (event.image == null || event.name == null || event.description == null || event.local == null || event.date == null || event.mix == null || event.alternative == null || event.lgbt == null || event.festival == null || event.spotlight == null) {
      return false;
    } else {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Cadastre um Novo Evento"),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => NavigationBloc.shared.goToEventsList(),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              ImageSelector(
                callback: (image) => Event.shared.image = image,
              ),
              CustomField(
                hint: "Nome",
                label: "Digite o Nome do Evento",
                callback: (value) => Event.shared.name = value,
              ),
              CustomField(
                hint: "Descrissão",
                label: "Uma Descrição Para o Evento",
                callback: (value) => Event.shared.description = value,
              ),
              CustomField(
                hint: "Local",
                label: "Onde Acontecerá o Evento",
                callback: (value) => Event.shared.local = value,
              ),
              DateSelector(
                label: "Quando Acontecerá o Evento",
                callback: (value) => Event.shared.date = value,
              ),
              CustomSwitcher(
                label: "Destaque",
                value: Event.shared.spotlight,
                callback: () {
                  Event.shared.spotlight = !Event.shared.spotlight;
                },
              ),
              CustomSwitcher(
                label: "Mix",
                value: Event.shared.mix,
                callback: () {
                  Event.shared.mix = !Event.shared.mix;
                },
              ),
              CustomSwitcher(
                label: "Alternativa",
                value: Event.shared.alternative,
                callback: () {
                  Event.shared.alternative = !Event.shared.alternative;
                },
              ),
              CustomSwitcher(
                label: "LGBT",
                value: Event.shared.lgbt,
                callback: () {
                  Event.shared.lgbt = !Event.shared.lgbt;
                },
              ),
              CustomSwitcher(
                label: "Festival",
                value: Event.shared.festival,
                callback: () {
                  Event.shared.festival = !Event.shared.festival;
                },
              ),
              Container(
                margin: EdgeInsets.only(
                  top: 20,
                  bottom: 20,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(
                          right: 10
                      ),
                      child: FlatButton(
                        padding: EdgeInsets.only(right: 30, left: 30),
                        child: Text("confirmar"),
                        color: Theme.of(context).primaryColor,
                        onPressed: () {

                          if (validateEvent(event: Event.shared) == false) {
                            _feedbackLabelBloc.changeStatus(status: Status.invalid);
                            return;
                          }

                          _feedbackLabelBloc.changeStatus(status: Status.loading);

                          FirebaseConnection.sendEvent(
                            onSuccess: () {
                              Event.shared = Event.initial;
                              NavigationBloc.shared.goToEventsList();
                            },
                            onError: () {
                              _feedbackLabelBloc.changeStatus(status: Status.error);
                            },
                          );
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          left: 10
                      ),
                      child: StreamBuilder(
                        stream: _feedbackLabelBloc.stream,
                        initialData: Container(),
                        builder: (context, snapshot) {
                          return snapshot.data;
                        },
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

  @override
  void dispose() {
    super.dispose();
    _feedbackLabelBloc.dispose();
  }
}
