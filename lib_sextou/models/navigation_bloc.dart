import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sextou/models/event.dart';
import 'package:sextou/widgets/category_page/category_page.dart';
import 'package:sextou/widgets/details/details.dart';
import 'package:sextou/widgets/main_page/main_page.dart';
import 'package:sextou/models/globals.dart';

class NavigationBloc {

  //State

  Widget _page = MainPage();
  Widget initialData = MainPage();

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

  goToDetails({@required Event event, @required VoidCallback getBack}) {
    _page = Container(
      child: Details(event: event, getBack: getBack,),
    );
    _sink.add(_page);
  }

  goToMain() {
    _page = Container(
      child: MainPage(),
    );
    _sink.add(_page);
  }

  goToCategory({@required Category category, @required VoidCallback getBack}) {
    _page = CategoryPage(category: category, getBack: getBack);
    _sink.add(_page);
  }
}