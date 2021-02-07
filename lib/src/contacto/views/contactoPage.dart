import 'package:application_casa_cambios/src/contacto/model/contactoModel.dart';
import 'package:application_casa_cambios/src/core/preferencias/preferenciasUsuario.dart';
import 'package:flutter/material.dart';

//PROVIDER
import 'package:provider/provider.dart';
import 'package:application_casa_cambios/src/contacto/provider/contactoProvider.dart';
import 'package:application_casa_cambios/src/convertidor/provider/divisaProvider.dart';

//DIALOGS
import 'package:application_casa_cambios/src/constants/notification_dialog.dart'
    as dialog;
import 'package:flushbar/flushbar.dart';

//CONSTANTS
import 'package:application_casa_cambios/src/constants/colors.dart';
import 'package:application_casa_cambios/src/constants/styles.dart';

class ContactoPage extends StatefulWidget {
  ContactoPage({Key key}) : super(key: key);

  @override
  _ContactoPageState createState() => _ContactoPageState();
}

class _ContactoPageState extends State<ContactoPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController controllerNombre,
      controllerApellido,
      controllerCorreo,
      controllerTelefono;
  final prefs = PreferenciasUsuario();

  @override
  void initState() {
    super.initState();
    controllerNombre = TextEditingController();
    controllerApellido = TextEditingController();
    controllerCorreo = TextEditingController(text: prefs.correo);
    controllerTelefono = TextEditingController(text: prefs.telefono);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Card(
        color: colorIndigo,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(25))),
        margin: EdgeInsets.symmetric(horizontal: 25),
        child: Form(
          key: _formKey,
          child: Stack(
            children: [
              Positioned(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                  child: SingleChildScrollView(
                    child: Column(mainAxisSize: MainAxisSize.min, children: [
                      Text('Contacto', style: textStyleTitleConvertidor),
                      TextFormField(
                          controller: controllerNombre,
                          maxLines: 1,
                          style: styleTextField,
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                              labelText: 'Nombres',
                              labelStyle: styleHintTextField,
                              errorBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.orange)),
                              errorStyle: TextStyle(color: Colors.orange)),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Por favor complete el campo';
                            }
                            return null;
                          }),
                      TextFormField(
                          controller: controllerApellido,
                          maxLines: 1,
                          style: styleTextField,
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                              labelText: 'Apellidos',
                              labelStyle: styleHintTextField,
                              errorBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.orange)),
                              errorStyle: TextStyle(color: Colors.orange)),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Por favor complete el campo';
                            }
                            return null;
                          }),
                      TextFormField(
                          controller: controllerCorreo,
                          maxLines: 1,
                          style: styleTextField,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                              labelText: 'Correo',
                              labelStyle: styleHintTextField,
                              errorBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.orange)),
                              errorStyle: TextStyle(color: Colors.orange)),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Por favor complete el campo';
                            }
                            return null;
                          }),
                      TextFormField(
                          controller: controllerTelefono,
                          maxLines: 1,
                          style: styleTextField,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                              labelText: 'Telefono',
                              labelStyle: styleHintTextField,
                              errorBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.orange)),
                              errorStyle: TextStyle(color: Colors.orange)),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Por favor complete el campo';
                            }
                            return null;
                          }),
                      TextFormField(
                        maxLines: 1,
                        style: styleTextField,
                        readOnly: true,
                        decoration: InputDecoration(
                            labelText: 'Moneda',
                            labelStyle: styleHintTextField),
                        controller: TextEditingController(
                            text: context.watch<DivisaProvider>().model.divisa),
                      ),
                      DropdownButtonFormField(
                          value: context.watch<ContactoProvider>().bancoIndex,
                          icon:
                              Icon(Icons.arrow_downward, color: Colors.orange),
                          iconSize: 22,
                          elevation: 16,
                          style: dropDouwnStyleDivisa,
                          onChanged: (val) {
                            setState(() {
                              context.read<ContactoProvider>().selectIndex(val);
                            });
                          },
                          items: context
                              .watch<ContactoProvider>()
                              .listaBancos
                              .map<DropdownMenuItem<String>>((val) {
                            return DropdownMenuItem<String>(
                                value: val, child: Text(val));
                          }).toList()),
                      SizedBox(height: 20),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('Num.Cuenta: ',
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white)),
                          SelectableText(
                            '${context.read<ContactoProvider>().numCuentaIndex}',
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      RaisedButton(
                        onPressed: () {
                          final providerContacto =
                              Provider.of<ContactoProvider>(context,
                                  listen: false);

                          final providerDivisa = Provider.of<DivisaProvider>(
                              context,
                              listen: false);
                          if (_formKey.currentState.validate()) {
                            //MOSTRAR FORMULARIO
                            dialog.dialogFormulario(
                                context,
                                'Aviso!',
                                'Si depositas en los proximos minutos tendra el dinero en tu cuenta en 1 hora como máximo',
                                '${providerContacto.numCuentaIndex}\n${providerContacto.bancoIndex}',
                                '${providerDivisa.model.divisa}',
                                'assets/images/money.png');
                            //GUARDAR DATOS EN EL PROVIDER
                            providerContacto.model = ContactoModel(
                                nombres: controllerNombre.text,
                                apellidos: controllerApellido.text,
                                correo: controllerCorreo.text,
                                telefono: controllerTelefono.text,
                                moneda: providerDivisa.model.divisa,
                                banco: providerContacto.bancoIndex,
                                numeroCuenta: providerContacto.numCuentaIndex);
                          } else {
                            Flushbar(
                              title: 'Alerta',
                              message: 'Complete los campos, por favor.',
                              icon: Icon(Icons.warning, color: Colors.red),
                              duration: Duration(seconds: 3),
                              flushbarPosition: FlushbarPosition.BOTTOM,
                            )..show(context);
                          }
                        },
                        color: colorVerdeA,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: Text('Aceptar', style: styleTextButtonConvertir),
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(25))),
                      )
                    ]),
                  ),
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
