import 'package:shared_preferences/shared_preferences.dart';

class PreferenciasUsuario {
  static final PreferenciasUsuario _instancia =
      new PreferenciasUsuario._internal();

  factory PreferenciasUsuario() {
    return _instancia;
  }

  PreferenciasUsuario._internal();

  SharedPreferences _prefs;

  initPrefs() async {
    this._prefs = await SharedPreferences.getInstance();
  }

  get token {
    return _prefs.getString('token') ?? '';
  }

  set token(String value) {
    _prefs.setString('token', value);
  }

  get celtoken {
    return _prefs.getString('celtoken') ?? '';
  }

  set celtoken(String value) {
    _prefs.setString('celtoken', value);
  }

  get usuario {
    return _prefs.getString('usuario') ?? '';
  }

  set usuario(String value) {
    _prefs.setString('usuario', value);
  }

  get correo {
    return _prefs.getString('correo') ?? '';
  }

  set correo(String value) {
    _prefs.setString('correo', value);
  }

  get telefono {
    return _prefs.getString('telefono') ?? '';
  }

  set telefono(String value) {
    _prefs.setString('telefono', value);
  }
}
