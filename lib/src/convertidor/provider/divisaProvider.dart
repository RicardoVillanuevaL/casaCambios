import 'package:application_casa_cambios/src/convertidor/model/divisaModel.dart';
import 'package:flutter/foundation.dart';

class DivisaProvider with ChangeNotifier, DiagnosticableTreeMixin {
  DivisaModel _model = DivisaModel('', 0.0);
  double _cambio = 0.0;
  double _resultMonto = 0.0;

  bool _resultExist = false;

  DivisaModel get model => _model;
  double get resultMonto => _resultMonto;
  double get cambio => _cambio;
  bool get resultExist => _resultExist;

  set resultExist(bool result) {
    this._resultExist = result;
    notifyListeners();
  }

  set resultMonto(double monto) {
    this._resultMonto = monto;
    notifyListeners();
  }

  set cambio(double value) {
    this._cambio = value;
  }

  void saveDivisa(String div, double mont) {
    _model = DivisaModel(div, mont);
    notifyListeners();
  }

  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('divisa', model.divisa));
    properties.add(DoubleProperty('monto', model.monto));
  }
}
