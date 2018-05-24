import 'package:flutter/material.dart';

class FormWidget extends StatelessWidget {
  final String label;

  final Widget child;

  FormWidget({this.label, this.child});

  @override
  Widget build(BuildContext context) {
    return new Padding(
        padding: new EdgeInsets.all(5.0),
        child: new Row(
          children: <Widget>[
            new Text(label, style: new TextStyle(fontSize: 20.0)),
            new Expanded(
                child:
                    new Align(alignment: Alignment.centerRight, child: child))
          ],
        ));
  }
}

class NumberPad extends StatelessWidget {
  final VoidCallback onSub;
  final VoidCallback onAdd;
  final int number;

  NumberPad({this.onAdd, this.onSub, this.number});

  @override
  Widget build(BuildContext context) {
    return new Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        new IconButton(icon: new Icon(Icons.exposure_neg_1), onPressed: onSub),
        new Text(
          number.toString(),
          style: new TextStyle(fontSize: 14.0),
        ),
        new IconButton(icon: new Icon(Icons.exposure_plus_1), onPressed: onAdd)
      ],
    );
  }
}
