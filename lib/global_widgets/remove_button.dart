import 'package:flutter/material.dart';

class RemoveButton extends StatelessWidget {

  final Icon icon;
  final Function onPressed;


  RemoveButton({@required this.icon, @required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: icon,
      onPressed: this.onPressed
    );
  }
}
