import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';

class ImageSelectorBloc {

  File _imageFile;

  final _controller = StreamController<File>();
  get stream => _controller.stream;
  get _sink => _controller.sink;

  void changeFile({@required File file}) {
    _imageFile = file;
    _sink.add(_imageFile);
  }

  void clearPhoto() {
    _imageFile = null;
    _sink.add(_imageFile);
  }

  File getFile() {
    return _imageFile;
  }

  void dispose() {
    stream.dispose();
    _sink.dispose();
  }
}


