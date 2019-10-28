import 'package:flutter/material.dart';
import 'package:sextou/widgets/main_page/spotlight.dart';
import 'package:sextou/widgets/main_page/tags.dart';
import 'package:sextou/widgets/main_page/next_events.dart';

class MainPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Container(
            color: Colors.transparent,
            margin: EdgeInsets.only(right: 20, bottom: 20,),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Flexible(
                  fit: FlexFit.loose,
                  child: Spotlight(),
                ),
                Flexible(
                  fit: FlexFit.loose,
                  child: Tags(),
                ),
                Flexible(
                  fit: FlexFit.loose,
                  child: NextEvents(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}