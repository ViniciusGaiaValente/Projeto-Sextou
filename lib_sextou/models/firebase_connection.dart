import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sextou/models/event.dart';

class FirebaseConnection {

  //State

  StreamSubscription _subscription;

  //StreamValues

  var _controller = StreamController<List<Event>>();
  get stream => _controller.stream;
  get _sink => _controller.sink;

  //LifeCycle

  FirebaseConnection() {
    _subscription = Firestore.instance.collection("events")
        .orderBy("date", descending: false)
        .snapshots()
        .listen((snap) {
      List<Event> events = [];
      snap.documents.forEach((document) {
        events.add(Event.fromMap(document.data));
      });
      _sink.add(events);
    });
  }

  dispose() {
    _subscription.cancel();
    _controller.close();
  }
}