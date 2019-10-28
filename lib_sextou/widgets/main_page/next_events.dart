import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sextou/models/event.dart';
import 'package:sextou/models/firebase_connection.dart';
import 'package:sextou/models/globals.dart';
import 'package:sextou/models/navigation_bloc.dart';

class NextEvents extends StatefulWidget {

  String _title;

  NextEvents() {
    switch (today.weekday) {
      case 5:
        _title = "Sextou?!";
        break;
      case 6:
        _title = "Sabadou?!";
        break;
      default:
        _title = "Rolês da semana";
        break;

    }
  }

  @override
  _NextEventsState createState() => _NextEventsState();
}

class _NextEventsState extends State<NextEvents> {

  FirebaseConnection _firebaseConnection;

  @override
  void initState() {
    _firebaseConnection = FirebaseConnection();
    super.initState();
  }

  @override
  void dispose() {
    _firebaseConnection.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 20, bottom: 2),
              child: RichText(
                overflow: TextOverflow.ellipsis,
                text: TextSpan(
                  text: widget._title,
                  style: Theme.of(context).textTheme.title,
                ),
              ),
            ),
          ],
        ),
        Row(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
              ),
              height: 5,
              width: 100,
            ),
          ],
        ),
        StreamBuilder(
          stream: _firebaseConnection.stream,
          builder: (context, snapshot) {

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Container(
                margin: EdgeInsets.all(10),
                width: MediaQuery.of(context).size.width,
                height: 100,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }

            if (snapshot.hasError || !snapshot.hasData) {
              return Container(
                margin: EdgeInsets.all(10),
                width: MediaQuery.of(context).size.width,
                height: 100,
                child: Center(
                  child: Text("Erro ao Carregar os Eventos"),
                ),
              );
            }

            if (snapshot.data.isEmpty) {
              return Container(
                margin: EdgeInsets.all(10),
                width: MediaQuery.of(context).size.width,
                height: 100,
                child: Center(
                  child: Center(
                    child: Text("Nenhum Evento Para Mostrar Aqui"),
                  ),
                ),
              );
            }

            return Container(
              child: _getContent(events: snapshot.data, context: context),
            );
          },
        ),
      ],
    );
  }
}

_getContent({@required BuildContext context, @required List<Event> events}) {

  List<Widget> rows = [];
  List<Event> filteredEvents = [];
  Function filter;

  switch (today.weekday) {
    case 5:
      filter = (Event event) {
        if (event.date.toDate().isAtSameMomentAs(today)) {
          return true;
        } else {
          return false;
        }
      };
      break;
    case 6:
      filter = (Event event) {
        if (event.date.toDate().isAtSameMomentAs(today)) {
          return true;
        } else {
          return false;
        }
      };
      break;
    default:
      filter = (Event event) {
        if (
            (
              event.date.toDate().isAtSameMomentAs(today) ||
              event.date.toDate().isAfter(today)
            )
                &&
            (
              event.date.toDate().isAtSameMomentAs(today.add(Duration(days: 7))) ||
              event.date.toDate().isBefore(today.add(Duration(days: 7)))
            )
        ) {
          return true;
        } else {
          return false;
        }
      };
      break;

  }

  events.forEach((event) {
    if (filter(event)) {
      filteredEvents.add(event);
    }
  });

  filteredEvents.forEach((event) {
    rows.add(
      GestureDetector(
        onTap: () => NavigationBloc.shared.goToDetails(
          event: event,
          getBack: () => NavigationBloc.shared.goToMain()),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          textDirection: TextDirection.ltr,
          children: <Widget>[
            CachedNetworkImage(
              imageUrl: event.photoPath,
              imageBuilder: (context, imageProvider) => Container(
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
                width: 100,
                height: 100,
              ),
              placeholder: (context, url) => Container(
                width: 100,
                height: 100,
                child: Center(child: CircularProgressIndicator()),
              ),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
            Flexible(
              fit: FlexFit.loose,
              child: Container(
                margin: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    RichText(
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left,
                      text: TextSpan(
                        text: event.name,
                        style: Theme.of(context).textTheme.subtitle,
                      ),
                    ),
                    RichText(
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left,
                      text: TextSpan(
                        text: event.description,
                        style: Theme.of(context).textTheme.body1,
                      ),
                    ),
                    RichText(
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left,
                      text: TextSpan(
                        text: event.local.split(",")[0],
                        style: Theme.of(context).textTheme.headline,
                      ),
                    ),
                    RichText(
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left,
                      text: TextSpan(
                        text: getFormattedDate(date: event.date.toDate()),
                        style: Theme.of(context).textTheme.headline,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  });

  if(rows.isEmpty) {
    return Container(
      margin: EdgeInsets.only(top: 30),
      child: Center(
        child: Text("Nenhum Evento Nesta Semana"),
      ),
    );
  } else {
    return Column(
      children: rows,
    );
  }
}