import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:sextou_cadastro/models/event.dart';

class FirebaseConnection {

  static sendEvent ({
    Function onSuccess,
    Function onError,
  }) {

    final storage = FirebaseStorage(storageBucket: "SEU_LINK_PARA_O_STORAGE_BUCKET").ref();
    final collection = Firestore.instance.collection("events");
    final id = Event.shared.name.toLowerCase().replaceAll(" ", "_");
    final path = "images/${id}.jpeg";
    final child = storage.child(path);
    final task = child.putFile(Event.shared.image);

    task.onComplete
        .whenComplete(() {
      child.getDownloadURL()
          .then((imagePath) {
        collection
            .document(id)
            .setData({
          'name': Event.shared.name,
          'photoPath' : imagePath,
          'description' : Event.shared.description,
          'local' : Event.shared.local,
          'date' : Timestamp.fromDate(Event.shared.date),
          'mix' : Event.shared.mix,
          'alternative' : Event.shared.alternative,
          'lgbt' : Event.shared.lgbt,
          'festival' : Event.shared.festival,
          'spotlight' : Event.shared.spotlight,
        }).whenComplete(() {
          onSuccess();
        }).catchError((e) {
          onError();
        });
      });
    }).catchError((e) {
      onError();
    });
  }

  static deleteEvent({
    @required String name,
    Function onSuccess,
    Function onError,
  }) {

    final id = name.replaceAll(" ", "_").toLowerCase();
    final collection = Firestore.instance.collection("events");
    final task = collection.document(id).delete();
    
    task.whenComplete(() {
      onSuccess();
    })
    .catchError((e) {
      onError();
    });
  }
}
