import 'package:flutter/material.dart';

class RelativeSizeImage extends StatelessWidget {

  ImageProvider _image;
  BoxFit _fit;

  double _width;
  double _height;

  double _widthFactor;
  double _heightFactor;

  bool _isWidthFixed;
  bool _isHeightFixed;

  RelativeSizeImage._({

    @required ImageProvider image,
    @required BoxFit fit,
    @required bool isWidthFixed,
    @required bool isHeightFixed,
    double width = 1,
    double height = 1,
    double widthFactor = 1,
    double heightFactor = 1,}) {

    _image = image;
    _fit = fit;

    _widthFactor = widthFactor;
    _heightFactor = heightFactor;

    _width = width;
    _height = height;

    _isWidthFixed = isWidthFixed;
    _isHeightFixed = isHeightFixed;

  }

  factory RelativeSizeImage.relative({

    @required ImageProvider image,
    @required BoxFit fit,
    @required double widthFactor,
    @required double heightFactor,}) {

    return RelativeSizeImage._(
      image: image,
      fit: fit,
      widthFactor: widthFactor,
      heightFactor: heightFactor,
      isHeightFixed: false,
      isWidthFixed: false,
    );
  }

  factory RelativeSizeImage.relativeWidthFixedHeight({

    @required ImageProvider image,
    @required BoxFit fit,
    @required double height,
    @required double widthFactor,}) {

    return RelativeSizeImage._(
      image: image,
      fit: fit,
      widthFactor: widthFactor,
      height: height,
      isWidthFixed: false,
      isHeightFixed: true,
    );
  }

  factory RelativeSizeImage.fixedWidthRelativeHeight({

    @required ImageProvider image,
    @required BoxFit fit,
    @required double width,
    @required double heightFactor,}) {

    return RelativeSizeImage._(
      image: image,
      width: width,
      heightFactor: heightFactor,
      fit: fit,
      isWidthFixed: true,
      isHeightFixed: false,
    );
  }

  factory RelativeSizeImage.fixed({

    @required ImageProvider image,
    @required BoxFit fit,
    @required double width,
    @required double height,}) {

    return RelativeSizeImage._(
      image: image,
      width: width,
      height: height,
      fit: fit,
      isWidthFixed: true,
      isHeightFixed: true,
    );
  }

  @override
  Widget build(BuildContext context) {

    if (_isWidthFixed == false) {
      _width = MediaQuery.of(context).size.width * _widthFactor;
    }

    if (_isHeightFixed == false) {
      _height = MediaQuery.of(context).size.height * _heightFactor;
    }

    return Container(
      width: _width,
      height: _height,
      alignment: Alignment.center,
      decoration: new BoxDecoration(
        image: DecorationImage(
          image: _image,
          fit: _fit,
        ),
      ),
    );
  }
}