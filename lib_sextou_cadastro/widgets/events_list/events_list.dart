import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sextou_cadastro/models/firebase_connection.dart';
import 'package:sextou_cadastro/models/globals.dart';
import 'package:sextou_cadastro/models/navigator_bloc.dart';
import '../../models/globals.dart';

class EventsList extends StatefulWidget {
  EventsList({Key key}) : super(key: key);
  @override
  EventsListState createState() => EventsListState();
}

class EventsListState extends State<EventsList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de Eventos"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => NavigationBloc.shared.goToForm(),
        ),
        ],
      ),
      body: StreamBuilder(
        stream: Firestore.instance.collection("events")
        .orderBy("date", descending: false)
        .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }
          return ListView.builder(
            itemCount: snapshot.data.documents.length,
            itemBuilder: (context, i) {
              return Dismissible(
                key: Key(snapshot.data.documents[i]["name"]),
                child: Container(
                  child: GestureDetector(
                    onTap: () => print(""),
                    child: CachedNetworkImage(
                      imageUrl: snapshot.data.documents[i]["photoPath"],
                      imageBuilder: (context, imageProvider) => Container(
                        margin: EdgeInsets.all(10),
                        width: MediaQuery.of(context).size.width,
                        height: 110,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                            colorFilter: ColorFilter.mode(Colors.black.withAlpha(150), BlendMode.multiply),
                          ),
                          borderRadius: BorderRadius.all(
                              Radius.circular(5)
                          ),
                        ),
                        child: Container(
                          margin: EdgeInsets.all(10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: RichText(
                                  textAlign: TextAlign.left,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  text: TextSpan(
                                    text: snapshot.data.documents[i]["name"],
                                    style: Theme.of(context).textTheme.subtitle.copyWith(color: Colors.white),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: RichText(
                                  textAlign: TextAlign.left,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  text: TextSpan(
                                    text: snapshot.data.documents[i]["description"],
                                    style: Theme.of(context).textTheme.body2.copyWith(color: Colors.white),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: RichText(
                                  textAlign: TextAlign.left,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: snapshot.data.documents[i]["local"].split(",")[0],
                                        style: Theme.of(context).textTheme.subhead.copyWith(color: Colors.white),
                                      ),
                                      TextSpan(
                                        text: " - ",
                                        style: Theme.of(context).textTheme.subhead.copyWith(color: Colors.white),
                                      ),
                                      TextSpan(
                                        text: getFormattedDate(date: snapshot.data.documents[i]["date"].toDate()),
                                        style: Theme.of(context).textTheme.subhead.copyWith(color: Colors.white),
                                      ),
                                    ]
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      placeholder: (context, url) => Container(
                        width: MediaQuery.of(context).size.width,
                        height: 150,
                        child: Center(child: CircularProgressIndicator()),
                      ),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  ),
                ),
                background: Container(
                  margin: EdgeInsets.all(10),
                  color: Colors.red,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Icon(
                        Icons.delete,
                        color: Colors.white,
                        size: 90,
                      ),
                    ],
                  ),
                ),
                onDismissed: (e) {
                  FirebaseConnection.deleteEvent(name: snapshot.data.documents[i]["name"]);
                },
              );
            },
          );
        }
      ),
    );
  }
}
