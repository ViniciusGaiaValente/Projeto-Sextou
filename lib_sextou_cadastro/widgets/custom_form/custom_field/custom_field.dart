import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomField extends StatelessWidget {

  TextEditingController _controller = TextEditingController();
  String label;
  String hint;
  Function callback;

  CustomField({
    @required this.label,
    @required this.hint,
    @required this.callback,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: TextFormField(
        style: Theme.of(context).textTheme.body1,
        cursorColor: Colors.white38,
        onChanged: callback,
        controller: _controller,
        maxLines: null,
        keyboardType: TextInputType.multiline,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(25),
            )
          ),
          suffixIcon: IconButton(
            onPressed: () {
              _controller.text = "";
              callback("");
            },
            icon: Icon(Icons.backspace),
          ),
        ),
      ),
    );
  }
}
