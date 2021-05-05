import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

alertSuccessfull(BuildContext context, String success, String msj) {
  AwesomeDialog(
    context: context,
    dialogType: DialogType.SUCCES,
    animType: AnimType.BOTTOMSLIDE,
    title: '$success',
    desc: '$msj',
    //btnCancelOnPress: () {},
    //btnOkOnPress: () {},
  )..show();
}

alertWelcome(BuildContext context, String success, String msj) {
  AwesomeDialog(
    context: context,
    dialogType: DialogType.INFO,
    animType: AnimType.BOTTOMSLIDE,
    title: '$success',
    desc: '$msj',
    //btnCancelOnPress: () {},
    //btnOkOnPress: () {},
  )..show();
}

alertError(BuildContext context, String error, String msj) {
  AwesomeDialog(
    context: context,
    dialogType: DialogType.ERROR,
    animType: AnimType.BOTTOMSLIDE,
    title: '$error',
    desc: '$msj',
    //btnCancelOnPress: () {},
    //btnOkOnPress: () {},
  )..show();
}
