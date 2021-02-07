import 'package:application_casa_cambios/src/convertidor/provider/divisaProvider.dart';
import 'package:flutter/material.dart';

//FUNTIONS
import 'package:provider/provider.dart';
import 'package:application_casa_cambios/src/convertidor/provider/funtions.dart';

//CONSTANTS
import 'package:application_casa_cambios/src/constants/colors.dart';
import 'package:application_casa_cambios/src/constants/styles.dart';

class ConvertidorPage extends StatefulWidget {
  ConvertidorPage({Key key}) : super(key: key);

  @override
  _ConvertidorPageState createState() => _ConvertidorPageState();
}

class _ConvertidorPageState extends State<ConvertidorPage> {
  String divisaValue;
  String divisaResult;
  double monto;

  @override
  void initState() {
    divisaValue = 'USD';
    divisaResult = 'PEN';
    monto = 0.0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Stack(children: [
        Card(
            margin: const EdgeInsets.only(top: 40, left: 20, right: 20),
            color: colorIndigo,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(25))),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
              child: SingleChildScrollView(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('BIENVENIDO LA CASA DE CAMBIOS ONLINE',
                          textAlign: TextAlign.center,
                          style: textStyleTitleConvertidor),
                      SizedBox(height: 40),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 200,
                            child: TextField(
                                keyboardType: TextInputType.number,
                                style: styleTextField,
                                maxLines: 1,
                                onChanged: (val) {
                                  monto = double.parse(val);
                                },
                                decoration: InputDecoration(
                                    hintText: 'Monto',
                                    hintStyle: styleHintTextField)),
                          ),
                          Container(
                            child: DropdownButton(
                                value: divisaValue,
                                icon: Icon(Icons.arrow_downward,
                                    color: Colors.orange),
                                iconSize: 22,
                                elevation: 16,
                                style: dropDouwnStyleDivisa,
                                onChanged: (val) {
                                  setState(() {
                                    divisaResult =
                                        funtion.toggleDivisaResult(val);
                                    divisaValue = val;
                                  });
                                },
                                items: [
                                  DropdownMenuItem(
                                    value: 'USD',
                                    child: Text('USD'),
                                  ),
                                  DropdownMenuItem(
                                    value: 'PEN',
                                    child: Text('PEN'),
                                  ),
                                ]),
                          )
                        ],
                      ),
                      SizedBox(height: 30),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                              width: 200,
                              child: TextField(
                                style: styleTextField,
                                controller: TextEditingController(
                                    text: context
                                        .watch<DivisaProvider>()
                                        .resultMonto
                                        .toStringAsFixed(2)),
                                readOnly: true,
                                decoration: InputDecoration(
                                    hintText: 'Monto Resultado',
                                    hintStyle: styleHintTextField),
                              )),
                          Container(
                              width: 70,
                              child: Text(divisaResult,
                                  style: dropDouwnStyleDivisa))
                        ],
                      ),
                      SizedBox(height: 20),
                      RaisedButton(
                        onPressed: () {
                          context
                              .read<DivisaProvider>()
                              .saveDivisa(divisaValue, monto);
                          funtion.generarConversion(context);
                        },
                        color: colorVerdeA,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: Text('Solicitar Cambio',
                            style: styleTextButtonConvertir),
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(25))),
                      ),
                      SizedBox(height: 20),
                      context.watch<DivisaProvider>().resultExist
                          ? RaisedButton(
                              color: colorVerdeA,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              child: Text('Solicitar Cotización',
                                  style: styleTextButtonConvertir),
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(25))),
                              onPressed: () {
                                funtion.goToFormularioContacto(context);
                              })
                          : SizedBox()
                    ]),
              ),
            )),
        Positioned(
          top: 0,
          right: 40,
          left: 40,
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: 35,
            child: Image.asset('assets/images/money.png', height: 200),
          ),
        ),
      ]),
    ));
  }
}
