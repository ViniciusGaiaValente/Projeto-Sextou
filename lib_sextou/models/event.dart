import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class Event {

  String photoPath;
  String name;
  String description;
  String local;
  Timestamp date;
  bool mix;
  bool alternative;
  bool lgbt;
  bool festival;
  bool spotlight;

  Event({
    @required this.photoPath,
    @required this.name,
    @required this.description,
    @required this.local,
    @required this.date,
    @required this.mix,
    @required this.alternative,
    @required this.lgbt,
    @required this.festival,
    @required this.spotlight,
  });

  Event.fromMap(Map data) {
    photoPath = data["photoPath"] ?? "";
    name = data["name"] ?? "";
    description = data["description"] ?? "";
    local = data["local"] ?? "";
    date = data["date"] ?? Timestamp.now();
    mix = data["mix"] ?? false;
    alternative = data["alternative"] ?? false;
    lgbt = data["lgbt"] ?? false;
    festival = data["festival"] ?? false;
    spotlight = data["spotlight"] ?? false;
  }
}