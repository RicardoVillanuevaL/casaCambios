import 'package:application_casa_cambios/src/contacto/model/contactoModel.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ContactoProvider with ChangeNotifier, DiagnosticableTreeMixin {
  List<String> _listaBancos = [
    'BCP',
    'InterBank',
    'ScotiaBank',
    'International Bank'
  ];
  List<String> _listaNumCuenta = [
    '202011110000',
    '101011001100',
    '303011110000',
    '404011001100'
  ];

  int _indexBanco = 0;

  //LISTA DE BANCOS
  List<String> get listaBancos => _listaBancos;
  List<String> get listaNumCuenta => _listaNumCuenta;
  int get indexBanco => _indexBanco;

  String get bancoIndex => _listaBancos[indexBanco];
  String get numCuentaIndex => _listaNumCuenta[indexBanco];

  set indexBanco(int index) {
    this._indexBanco = index;
    notifyListeners();
  }

  void selectIndex(String val) {
    int indexTemp = _listaBancos.indexOf(val);
    this._indexBanco = indexTemp;
    notifyListeners();
  }

  //CONTACTO MODEL
  ContactoModel _model = ContactoModel();
  ContactoModel get model => _model;

  set model(ContactoModel model) {
    this._model = model;
  }
}
