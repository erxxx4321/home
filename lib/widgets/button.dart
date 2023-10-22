import 'package:flutter/material.dart';

MaterialButton longButtons(
    String title, void Function() fun, Color primaryColor,
    {Color textColor = Colors.white}) {
  return MaterialButton(
    onPressed: fun,
    textColor: textColor,
    color: primaryColor,
    child: SizedBox(
      width: double.infinity,
      child: Text(
        title,
        textAlign: TextAlign.center,
      ),
    ),
    height: 45,
    minWidth: 600,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10))),
  );
}
