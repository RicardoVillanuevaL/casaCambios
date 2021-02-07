import 'dart:convert';

import 'package:application_casa_cambios/src/convertidor/provider/divisaProvider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class ServicesConvertidor {
  Future<void> apiConvertidorGoogle(BuildContext context) async {
    final provider = Provider.of<DivisaProvider>(context, listen: false);
    final url =
        'http://apilayer.net/api/live?access_key=f717001bf2494d892f1affd474c955f1&currencies=PEN&source=USD&format=1';
    final response = await http.get(url);
    print(response);
    final temp = json.decode(response.body);
    double tipoCambio = temp['quotes']['USDPEN'] ?? 0.0;
    provider.cambio = tipoCambio;
    return null;
  }
}

final servicesConvertidor = ServicesConvertidor();
