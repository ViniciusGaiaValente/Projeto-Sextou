import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sextou_cadastro/widgets/custom_form/custom_form.dart';
import 'package:sextou_cadastro/widgets/events_list/events_list.dart';

class NavigationBloc {

  //State

  Widget _page = EventsList();
  Widget initialData = EventsList();

  //SingletonConfiguration

  NavigationBloc._();

  static NavigationBloc shared = NavigationBloc._();

  //StreamValues

  var _controller = StreamController<Widget>();
  get stream => _controller.stream;
  get _sink => _controller.sink;

  //LifeCycle

  dispose() {
    _controller.close();
  }

  //Navigation Methods

  goToForm() {
    _page = Container(
      child: CustomForm(),
    );
    _sink.add(_page);
  }

  goToEventsList() {
    _page = Container(
      child: EventsList(),
    );
    _sink.add(_page);
  }
}
