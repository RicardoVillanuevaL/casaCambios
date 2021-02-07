import 'package:application_casa_cambios/src/contacto/services/funtions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

dialogImagen(
    BuildContext context, String title, String mensaje, String imagen) {
  return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text(title),
          content: Column(
            children: [
              Container(
                child: Image.asset(imagen),
                height: 50,
                margin: EdgeInsets.only(top: 20, bottom: 20),
              ),
              Text(mensaje),
            ],
          ),
          actions: [
            CupertinoDialogAction(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Ok'),
            )
          ],
        );
      });
}

dialogFormulario(BuildContext context, String title, String mensaje,
    String banco, String moneda, String imagen) {
  return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text(title),
          content: Column(
            children: [
              Container(
                child: Image.asset(imagen),
                height: 50,
                margin: EdgeInsets.only(top: 20, bottom: 20),
              ),
              Text(mensaje),
              SelectableText(banco, textAlign: TextAlign.center),
              Text(moneda)
            ],
          ),
          actions: [
            CupertinoDialogAction(
              onPressed: () {
                funtionContacto.registrarContacto(context);
              },
              child: Text('Aceptar'),
            )
          ],
        );
      });
}
