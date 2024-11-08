import 'package:flutter/material.dart';

showAlertDialog({required BuildContext context, required String message, String? button_text}) {
  return showDialog(context: context, builder: (conter) {
    return AlertDialog(
      content: Text(message, style: TextStyle(color: Colors.black, fontSize: 15),),
      contentPadding: const EdgeInsets.fromLTRB(20, 20, 20, 5),
      actions: [
        TextButton(onPressed: () => Navigator.of(context).pop(),
        child:Text(button_text ?? "OK" ,
        style: TextStyle(color:Colors.cyan)))
      ],
    );
  });
  }