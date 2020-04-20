import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class MyAlertDialog {
  //Constructor
  static showAlert({
    @required BuildContext ctx,
    @required AlertType type,
    String title,
    String desc,
    List<DialogButton> buttons,
  }) {
    /////
    return Alert(
      context: ctx,
      type: type,
      title: title,
      desc: desc,
      buttons: buttons,
    ).show();
  }
}
