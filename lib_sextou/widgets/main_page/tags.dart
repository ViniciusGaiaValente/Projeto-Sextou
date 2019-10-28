 import 'package:flutter/material.dart';
import 'package:sextou/models/globals.dart';
import 'package:sextou/models/navigation_bloc.dart';

class Tags extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 20, bottom: 2),
              child: Text(
                "Para onde ir",
                style: Theme.of(context).textTheme.title,
              )
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
        Container(
          margin: EdgeInsets.only(left: 15),
          height: 100,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 4,
            itemBuilder: (context, i) {
              Category _category;
              AssetImage _fundo;
              Image _icone;
              VoidCallback _callback;
              double right = 5;
              double left = 5;

              if (i == 0) {
                left = 0;
              }

              if (i == 3) {
                right = 0;
              }

              switch (i) {
                case 0:
                  _fundo = AssetImage("assets/fundo-mix.png");
                  _icone = Image.asset("assets/icone-mix.png");
                  _category = Category.mix;
                  break;
                case 1:
                  _fundo = AssetImage("assets/fundo-alternativa.png");
                  _icone = Image.asset("assets/icone-alternativa.png");
                  _category = Category.alternative;
                  break;
                case 2:
                  _fundo = AssetImage("assets/fundo-lgbt.png");
                  _icone = Image.asset("assets/icone-lgbt.png");
                  _category = Category.lgbt;;
                  break;
                case 3:
                  _fundo = AssetImage("assets/fundo-festival.png");
                  _icone = Image.asset("assets/icone-festival.png");
                  _category = Category.festival;
                  break;
              }

              return GestureDetector(
                onTap: () => NavigationBloc.shared.goToCategory(
                  category: _category,
                  getBack: () => NavigationBloc.shared.goToMain(),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: _fundo,
                    ),
                    borderRadius: BorderRadius.all(
                        Radius.circular(10)
                    ),
                  ),
                  margin: EdgeInsets.only(top: 10, right: right, left: left),
                  height: 100,
                  width: 150,
                  child: Container(
                    padding: EdgeInsets.all(8),
                    child: _icone,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}