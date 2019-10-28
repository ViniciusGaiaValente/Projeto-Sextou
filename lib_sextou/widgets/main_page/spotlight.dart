import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sextou/models/event.dart';
import 'package:sextou/models/firebase_connection.dart';
import 'package:sextou/models/globals.dart';
import 'package:sextou/models/navigation_bloc.dart';

class Spotlight extends StatefulWidget {

  @override
  _SpotlightState createState() => _SpotlightState();
}

class _SpotlightState extends State<Spotlight> {

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
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 20, bottom: 2),
              child: RichText(
                overflow: TextOverflow.ellipsis,
                text: TextSpan(
                  text: "Destaques",
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
                height: 175,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }

            if (snapshot.hasError || !snapshot.hasData) {
              return Container(
                margin: EdgeInsets.all(10),
                width: MediaQuery.of(context).size.width,
                height: 175,
                child: Center(
                  child: Text("Erro ao Carregar os Eventos"),
                ),
              );
            }

            if (snapshot.data.isEmpty) {
              return Container(
                margin: EdgeInsets.all(10),
                width: MediaQuery.of(context).size.width,
                height: 175,
                child: Center(
                  child: Center(
                    child: Text("Nenhum Evento Em Destaque No Momento"),
                  ),
                ),
              );
            }

            return Container(
              child: _getContent(events: snapshot.data),
            );
          },
        ),
      ],
    );
  }
}

_getContent({@required List<Event> events}) {

  return Container(
    margin: EdgeInsets.only(left: 20),
    height: 175,
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: events.length,
      itemBuilder: (context, i) {
        Event event = events[i];
        double left = 10;
        double right = 10;

        if (event == events.first) {
          left = 0;
        }

        if (event == events.last) {
          right = 0;
        }

        return GestureDetector(
          onTap: () => NavigationBloc.shared.goToDetails(
            event: event,
            getBack: () => NavigationBloc.shared.goToMain(),
          ),
          child: CachedNetworkImage(
            imageUrl: event.photoPath,
            imageBuilder: (context, imageProvider) => Container(
              margin: EdgeInsets.only(
                top: 10,
                left: left,
                right: right,
              ),
              width: 275,
              height: 175,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(Colors.black.withAlpha(215), BlendMode.multiply),
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
                          text: event.name,
                          style: Theme.of(context).textTheme.subtitle,
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
                          text: event.description,
                          style: Theme.of(context).textTheme.body1,
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
                              text: event.local.split(",")[0],
                              style: Theme.of(context).textTheme.subhead,
                            ),
                            TextSpan(
                              text: " - ",
                              style: Theme.of(context).textTheme.subhead,
                            ),
                            TextSpan(
                              text: getWeekDay(date: event.date.toDate()),
                              style: Theme.of(context).textTheme.subhead,
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
              width: 300,
              height: 200,
              child: Center(child: CircularProgressIndicator()),
            ),
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),
        );
      },
    ),
  );
}