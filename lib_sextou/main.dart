import 'package:flutter/material.dart';
import 'package:sextou/models/navigation_bloc.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "Livvic",
        textTheme: TextTheme(
          title: TextStyle(
            fontSize: 25,
            color: Colors.white,
          ),
          subtitle: TextStyle(
            fontSize: 20,
            color: Colors.white,
          ),
          subhead: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          headline: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          body1: TextStyle(
            fontSize: 13,
            color: Colors.white,
          ),
          body2: TextStyle(
            fontSize: 12,
            color: Colors.white,
          ),
        )
      ),
      home: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromRGBO(135, 0, 71, 1),
              Color.fromRGBO(54, 24, 58 , 1),
            ],
            begin: FractionalOffset.topLeft,
            end: FractionalOffset.bottomRight,
          ),
        ),
        child: Stack(
          children: <Widget>[
            StreamBuilder(
              stream: NavigationBloc.shared.stream,
              initialData: NavigationBloc.shared.initialData,
              builder: (context, snapshot) {
                return Container(
                  child: snapshot.data,
                );
              },
            ),
          ],
        )
      )
    );
  }

  @override
  void dispose() {
    super.dispose();
    NavigationBloc.shared.dispose();
  }
}
