import 'package:flutter/material.dart';

//NOTIFICATIONS
import 'package:flushbar/flushbar.dart';
import 'package:application_casa_cambios/src/core/push_notifications/push_notifications.dart';

//ROUTES
import 'package:application_casa_cambios/src/convertidor/views/convertidorPage.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GlobalKey<NavigatorState> globalKey = new GlobalKey<NavigatorState>();

  @override
  void initState() {
    final pushNotificationProvider = new PushNotificationProvider();
    super.initState();
    pushNotificationProvider.initNotifications();
    pushNotificationProvider.mensajes.listen((onData) {
      Flushbar(
        title: 'Casa de Cambios',
        message: onData,
        flushbarPosition: FlushbarPosition.TOP,
        icon: Icon(
          Icons.notifications,
          size: 28,
          color: Colors.indigo,
        ),
        leftBarIndicatorColor: Colors.indigoAccent,
        duration: Duration(seconds: 3),
      )..show(globalKey.currentContext);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Casa de Cambios',
      navigatorKey: globalKey,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ConvertidorPage(),
    );
  }
}
