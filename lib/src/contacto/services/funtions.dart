import 'package:application_casa_cambios/src/contacto/model/contactoModel.dart';
import 'package:application_casa_cambios/src/contacto/services/servicesContacto.dart';
import 'package:application_casa_cambios/src/convertidor/provider/divisaProvider.dart';
import 'package:application_casa_cambios/src/convertidor/views/convertidorPage.dart';
import 'package:application_casa_cambios/src/core/push_notifications/push_notifications.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';

//FIREBASE
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

//PROVIDER AND MODEL
import 'package:provider/provider.dart';
import 'package:application_casa_cambios/src/contacto/provider/contactoProvider.dart';

//PREFERENCIAS
import 'package:application_casa_cambios/src/core/preferencias/preferenciasUsuario.dart';

class FuntionsContacto {
  PreferenciasUsuario preferenciasUsuario = PreferenciasUsuario();
  FirebaseAuth _auth = FirebaseAuth.instance;
  final databaseReference = FirebaseDatabase.instance.reference();
  final pushNotification = new PushNotificationProvider();

  void registrarContacto(BuildContext context) async {
    final provider = Provider.of<ContactoProvider>(context, listen: false);
    final providerDiv = Provider.of<DivisaProvider>(context, listen: false);
    final ContactoModel model = provider.model;

    // QUE SE VAYA REGISTRANDO EL USUARIO
    registrarUsuarioToken(context, model);

    //REGISTRAMOS LA DATA
    databaseReference.child('Contacto').push().set({
      "nombre": model.nombres,
      "apellido": model.apellidos,
      "correo": model.correo,
      "telefono": model.telefono,
      "moneda": model.moneda,
      "banco": model.banco,
      "numeroCuenta": model.numeroCuenta,
    });
    Flushbar(message: 'Operación Exitosa').show(context);
    Future.delayed(Duration(seconds: 2), () {
      //ENVIAMOS UNA NOTIFICACION Y UN EMAIL PARA CONFIRMAR QUE SE REALIZO CON EXITO SU REGISTRO
      enviarNotificacionCorreo(model);
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => ConvertidorPage()),
          (_) => false);
    });
    //SE HACE UN CLEAR
    providerDiv.resultExist = false;
    providerDiv.resultMonto = 0.0;
  }

  void registrarUsuarioToken(BuildContext context, ContactoModel model) async {
    //ACA REGISTRAMOS PARA OBTENER EL TOKEN PARA LA NOTIFICACION
    final String correo = preferenciasUsuario.correo;
    final String telefono = preferenciasUsuario.telefono;
    if (correo.isEmpty || telefono.isEmpty) {
      //SI ESTA VACIO REGISTRAR
      try {
        final response = await _auth.createUserWithEmailAndPassword(
            email: model.correo, password: model.telefono);
        print('${response.user}');
        databaseReference.child('Usuario').push().set({
          "correo": model.correo,
          "telefono": model.telefono,
          "token": response.user.uid
        });
        //REGISTRAMOS PREFERENCIAS
        preferenciasUsuario.correo = model.correo;
        preferenciasUsuario.telefono = model.telefono;
        preferenciasUsuario.usuario = '${model.nombres} ${model.apellidos}';
        preferenciasUsuario.token = response.user.uid;
      } catch (e) {
        print(e);
      }
    } else {
      //SI ESTA CON DATOS LOGUEAR
      try {
        final response = await _auth.signInWithEmailAndPassword(
            email: correo, password: telefono);
        print('${response.user.uid}');
        preferenciasUsuario.correo = model.correo;
        preferenciasUsuario.telefono = model.telefono;
        preferenciasUsuario.usuario = '${model.nombres} ${model.apellidos}';
        preferenciasUsuario.token = response.user.uid;
      } catch (e) {
        print(e);
      }
    }
    print(preferenciasUsuario.celtoken);
  }

  void enviarNotificacionCorreo(ContactoModel model) {
    servicesContacto.mandarnotification(
        preferenciasUsuario.celtoken,
        'Casa de Cambios',
        'Hola ${model.nombres}, se acabá de registrar su solicitud, estamos a la espera del depositó',
        'Hola ${model.nombres}, se acabá de registrar su solicitud, estamos a la espera del depositó');
    servicesContacto.mandarCorreo(model,
        '${model.nombres} ${model.apellidos}.\nSe acabá de registrar su solicitud, estamos a la espera del depositó');
  }
}

final funtionContacto = FuntionsContacto();
