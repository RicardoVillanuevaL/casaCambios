import 'package:application_casa_cambios/src/core/preferencias/preferenciasUsuario.dart';
import 'package:flutter/material.dart';

//FIREBASE
import 'package:firebase_core/firebase_core.dart';

//ROUTES
import 'package:application_casa_cambios/src/myapp.dart';

//PROVIDER
import 'package:provider/provider.dart';
import 'package:application_casa_cambios/src/contacto/provider/contactoProvider.dart';
import 'package:application_casa_cambios/src/convertidor/provider/divisaProvider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => DivisaProvider()),
    ChangeNotifierProvider(create: (_) => ContactoProvider()),
  ], child: MyApp()));
  await Firebase.initializeApp();
  final prefs = new PreferenciasUsuario();
  await prefs.initPrefs();
}
