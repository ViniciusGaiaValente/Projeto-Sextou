import 'dart:async';
import 'package:flutter/material.dart';

enum Status {initial, loading, success, error, invalid}

class FeedbackLabelBloc {

  Widget _status = Container();

  final _controller = StreamController<Container>();
  get stream => _controller.stream;
  get _sink => _controller.sink;

  changeStatus({@required Status status}) {
    switch (status){
      case Status.initial:
        _status = Container();
        _sink.add(_status);
        break;
      case Status.loading:
        _status = Container(
          child: CircularProgressIndicator(),
        );
        _sink.add(_status);
        break;
      case Status.success:
        _status = Container(
          child: Text("Adicionado com Sucesso"),
        );
        _sink.add(_status);
        break;
      case Status.error:
        _status = Container(
          child: Text("Erro"),
        );
        _sink.add(_status);
        break;
      case Status.invalid:
        _status = Container(
          child: Text("Campos Invalidos"),
        );
        _sink.add(_status);
        break;
    }
  }

  void dispose() {
    _controller.close();
  }
}