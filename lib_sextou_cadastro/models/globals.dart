import 'package:flutter/material.dart';

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
