import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:sextou_cadastro/models/navigator_bloc.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.dark,
        accentColor: Colors.white38,
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
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('pt', 'BR'),
        const Locale('en', 'US'),
      ],
      home: StreamBuilder(
        stream: NavigationBloc.shared.stream,
        initialData: NavigationBloc.shared.initialData,
        builder: (context, snapshot) {
          if (snapshot.data != null) {
            return snapshot.data;
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}


