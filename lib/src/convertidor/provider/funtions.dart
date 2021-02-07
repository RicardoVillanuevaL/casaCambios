import 'package:application_casa_cambios/src/contacto/views/contactoPage.dart';
import 'package:application_casa_cambios/src/convertidor/services/services.dart';
import 'package:flutter/material.dart';
//PROVIDER
import 'package:provider/provider.dart';
import 'package:application_casa_cambios/src/convertidor/provider/divisaProvider.dart';
//DIALOG
import 'package:application_casa_cambios/src/constants/notification_dialog.dart'
    as dialog;

class FuntionsConvertidor {
  String toggleDivisaResult(String val) {
    if (val == 'USD') {
      return 'PEN';
    } else {
      return 'USD';
    }
  }

  void generarConversion(BuildContext context) async {
    final provider = Provider.of<DivisaProvider>(context, listen: false);
    String divisa = provider.model.divisa;
    double monto = provider.model.monto;
    print(divisa);
    if (monto == 0.0) {
      dialog.dialogImagen(context, 'Oh no!', 'Por favor digite un monto',
          'assets/images/connectionError.png');
    } else {
      // aca iria lo de dirigirse al API ... Y ESPERAR EL RESULTADO DESPUES SE MUESTRA ...
      await servicesConvertidor.apiConvertidorGoogle(context);
      if (provider.cambio != 0.0) {
        if (divisa == 'PEN') {
          provider.resultMonto = monto / provider.cambio;
          provider.resultExist = true;
        } else {
          provider.resultMonto = monto * provider.cambio;
          provider.resultExist = true;
        }
      } else {
        provider.resultMonto = monto;
        dialog.dialogImagen(
            context,
            'Error!',
            'Algo falló, verifique su conexión a internet',
            'assets/images/connectionError.png');
      }
    }
  }

  void goToFormularioContacto(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => ContactoPage()));
  }
}

final funtion = FuntionsConvertidor();
