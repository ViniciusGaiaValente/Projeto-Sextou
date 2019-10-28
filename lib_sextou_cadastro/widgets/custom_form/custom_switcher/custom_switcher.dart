import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomSwitcher extends StatefulWidget {

  String label;
  bool value;
  Function callback;

  CustomSwitcher({
    @required this.label,
    @required this.value,
    @required this.callback,
  });

  @override
  _CustomSwitcherState createState() => _CustomSwitcherState();
}

class _CustomSwitcherState extends State<CustomSwitcher> {

  Icon _icon;

  @override
  initState() {
    super.initState();
    if (widget.value) {
      _icon = Icon(Icons.radio_button_checked);
    } else {
      _icon = Icon(Icons.radio_button_unchecked);
    }
  }

  toggleIcon() {
    widget.value = !widget.value;
    if (widget.value) {
      _icon = Icon(Icons.radio_button_checked);
    } else {
      _icon = Icon(Icons.radio_button_unchecked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: 15,
        right: 15,
        top: 10,
        bottom: 10
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          RichText(
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            text: TextSpan(
              text: widget.label,
              style: Theme.of(context).textTheme.body1,
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                toggleIcon();
                widget.callback();
              });
            },
            child: _icon,
          )
        ],
      ),
    );
  }
}
