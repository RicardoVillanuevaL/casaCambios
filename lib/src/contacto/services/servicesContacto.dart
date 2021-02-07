import 'dart:convert';
import 'package:application_casa_cambios/src/contacto/model/contactoModel.dart';
import 'package:http/http.dart' as http;

import 'package:application_casa_cambios/src/core/preferencias/preferenciasUsuario.dart';

class ServicesContacto {
  PreferenciasUsuario preferenciasUsuario = PreferenciasUsuario();
  Future<bool> mandarnotification(
      String token, String titulo, String mensaje, String data) async {
    print('CONFIRMACION DE TOKEN $token');
    final url = 'https://api-services2021.herokuapp.com/enviarNotificacion';
    final body = {
      'token': token,
      'title': titulo,
      'body': mensaje,
      'data': data
    };
    final resp = await http.post(url,
        headers: {
          'authorization': preferenciasUsuario.token,
          "Content-Type": "application/json",
        },
        body: json.encode(body));
    print(resp);
    final decodedData1 = json.decode(resp.body);
    print(decodedData1);
    return true;
  }

  Future<void> mandarCorreo(ContactoModel model, String mensaje) async {
    final url = 'https://api-services2021.herokuapp.com/enviarCorreo';
    final body = {'correo': model.correo, 'message': mensaje};
    final resp = await http.post(url,
        headers: {
          "Content-Type": "application/json",
        },
        body: json.encode(body));
    print(resp);
    final decodedData1 = json.decode(resp.body);
    print(decodedData1);
  }
}

final servicesContacto = ServicesContacto();
