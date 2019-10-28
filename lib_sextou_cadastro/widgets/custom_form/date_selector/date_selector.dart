import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DateSelector extends StatelessWidget {

  DateSelector({@required this.label, @required this.callback});

  TextEditingController _controller = TextEditingController();
  String label;
  Function callback;

  getFormatedDate(DateTime date) {
    var rawText = date.toString();
    var year = rawText[0] + rawText[1] + rawText[2] + rawText[3];
    var month = rawText[5] + rawText[6];
    var day = rawText[8] + rawText[9];
    return day + "/" + month + "/" + year;
  }

  selectDate(BuildContext context) {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2018),
      lastDate: DateTime(2100),
      locale: Locale("pt", "BR",),
    ).then((value) {
      if (value != null) {
        var date = DateTime(
          value.year,
          value.month,
          value.day,
          0,
          0,
          0,
          0,
          0,
        );
        callback(date);
        _controller.text = getFormatedDate(date);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: TextFormField(
        style: Theme.of(context).textTheme.body1,
        readOnly: true,
        onTap: () => selectDate(context),
        controller: _controller,
        maxLines: null,
        keyboardType: TextInputType.multiline,
        decoration: InputDecoration(
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(25),
              )
          ),
          suffixIcon: Icon(Icons.calendar_today),
          labelText: label,
        ),
      ),
    );
  }
}
