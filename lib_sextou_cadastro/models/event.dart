import 'dart:io';
import 'package:flutter/foundation.dart';

class Event {

  static get initial => Event._(
    image: null,
    name: null,
    description: null,
    local: null,
    date: null,
    mix: false,
    alternative: false,
    lgbt: false,
    festival: false,
    spotlight: false,
  );

  static Event shared = Event._(
    image: null,
    name: null,
    description: null,
    local: null,
    date: null,
    mix: false,
    alternative: false,
    lgbt: false,
    festival: false,
    spotlight: false,
  );

  File image;
  String name;
  String description;
  String local;
  DateTime date;
  bool mix;
  bool alternative;
  bool lgbt;
  bool festival;
  bool spotlight;

  Event._({
    @required this.image,
    @required this.name,
    @required this.description,
    @required this.local,
    @required this.date,
    @required this.mix,
    @required this.alternative,
    @required this.lgbt,
    @required this.festival,
    @required this.spotlight,
  }) {
    if (mix == false || alternative == false || lgbt == false || festival == false) {
      return;
    }
  }

  Event.fromMap(Map data) {
    this.name = data["name"] ?? "";
    this.description = data["description"] ?? "";
    this.local = data["local"] ?? "";
    this.date = data["date"] ?? DateTime.utc(2010);
    this.mix = data["mix"] ?? false;
    this.alternative = data["alternativa"] ?? false;
    this.lgbt = data["lgbt"] ?? false;
    this.festival = data["festival"] ?? false;
    this.spotlight = data["spotlight"] ?? false;
  }
}