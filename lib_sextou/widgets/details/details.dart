import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sextou/models/event.dart';
import 'package:sextou/models/globals.dart';

class Details extends StatefulWidget {

  Details({@required this.event, @required this.getBack});

  Event event;
  VoidCallback getBack;

  @override
  _DetailsState createState() => _DetailsState(event: event, getBack: getBack);
}

class _DetailsState extends State<Details> {

  _DetailsState({@required this.event, @required this.getBack});

  Event event;
  VoidCallback getBack;

  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;

    Image icon;

    if (event.festival == true) {
      icon = getCategoryIcon(category: Category.festival);
    }

    if (event.lgbt == true) {
      icon = getCategoryIcon(category: Category.lgbt);
    }

    if (event.alternative == true) {
      icon = getCategoryIcon(category: Category.alternative);
    }

    if (event.mix == true) {
      icon = getCategoryIcon(category: Category.mix);
    }

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: getBack,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(10),
              child: CachedNetworkImage(
                imageUrl: event.photoPath,
                imageBuilder: (context, imageProvider) => Container(
                  width: width,
                  height: (width * 7) /11,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                placeholder: (context, url) => Container(
                  width: width,
                  height: (width * 7) /11 ,
                  child: Center(child: CircularProgressIndicator()),
                ),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
            Container(
              padding: EdgeInsets.all(18),
              width: width,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Flexible(
                    child: RichText(
                      textAlign: TextAlign.start,
                      text: TextSpan(
                        text: event.name,
                        style: Theme.of(context).textTheme.title.apply(fontWeightDelta: 3),
                      ),
                    ),
                  ),
                  Container(
                    height: 50,
                    width: 60,
                    child: icon,
                  ),
                ],
              )
            ),
            Container(
              padding: EdgeInsets.all(18),
              child: RichText(
                textAlign: TextAlign.start,
                text: TextSpan(
                  text: event.description,
                  style: Theme.of(context).textTheme.subtitle,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(18),
              child: RichText(
                textAlign: TextAlign.justify,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "Data: ",
                      style: Theme.of(context).textTheme.subtitle.apply(fontWeightDelta: 3),
                    ),
                    TextSpan(
                      text: getFormattedDate(date: event.date.toDate()),
                      style: Theme.of(context).textTheme.subtitle,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(18),
              child: RichText(
                textAlign: TextAlign.justify,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "Local: ",
                      style: Theme.of(context).textTheme.subtitle.apply(fontWeightDelta: 3),
                    ),
                    TextSpan(
                      text: event.local,
                      style: Theme.of(context).textTheme.subtitle,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
