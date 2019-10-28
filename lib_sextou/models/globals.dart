import 'package:flutter/material.dart';

enum Category { mix, alternative, lgbt, festival }

DateTime today = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 0, 0, 0, 0, 0,);

getFormattedDate({@required DateTime date}) {
  String _year = date.year.toString();
  String _month = date.month.toString();
  String _day = date.day.toString();

  if (_month.length == 1) {
    _month = "0${_month}";
  }

  if (_day.length == 1) {
    _day = "0${_day}";
  }

  return "${getWeekDay(date: date)} - ${_day}/${_month}/${_year}";
}

getWeekDay({@required DateTime date}) {
  switch (date.weekday) {
    case 1:
      return "Segunda-Feira";
      break;
    case 2:
      return "Terça-Feira";
      break;
    case 3:
      return "Quarta-Feira";
      break;
    case 4:
      return "Quinta-Feira";
      break;
    case 5:
      return "Sexta-Feira";
      break;
    case 6:
      return "Sabado";
      break;
    case 7:
      return "Domingo";
      break;
  }
}

getCategoryColor({@required Category category}) {
  switch (category) {
    case Category.mix:
      return Color.fromARGB(255, 135, 35, 35).withAlpha(215);
      break;
    case Category.alternative:
      return Color.fromARGB(255, 30, 30, 100).withAlpha(215);
      break;
    case Category.lgbt:
      return Color.fromARGB(255, 155, 115, 55).withAlpha(215);
      break;
    case Category.festival:
      return Color.fromARGB(255, 25, 145, 145).withAlpha(215);
      break;
  }
}

getCategoryIcon({@required Category category}) {
  switch (category) {
    case Category.mix:
      return Image.asset("assets/icone-mix.png",fit: BoxFit.fitHeight,);
      break;
    case Category.alternative:
      return Image.asset("assets/icone-alternativa.png",fit: BoxFit.fitHeight,);
      break;
    case Category.lgbt:
      return Image.asset("assets/icone-lgbt.png",fit: BoxFit.fitHeight,);
      break;
    case Category.festival:
      return Image.asset("assets/icone-festival.png",fit: BoxFit.fitHeight,);
      break;
  }
}
