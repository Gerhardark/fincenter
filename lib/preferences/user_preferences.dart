import 'package:shared_preferences/shared_preferences.dart';

class PreferenciasUsuarios {
  static late SharedPreferences _prefs;

  static Future init() async {
    _prefs = await SharedPreferences.getInstance();
  }
  String get ultimaPagina {
    return _prefs.getString('ultimaPagina')?? 'login';
  }
  set ultimaPagina(String value) {
    if (value == '/dashboard') {
      _prefs.remove('ultimaPagina'); // Elimina la preferencia para que get ultimaPagina devuelva null
      // Opcionalmente, puedes usar un valor especial:
      // _prefs.setString('ultimaPagina', 'null');
    } else {
      _prefs.setString('ultimaPagina', value);
    }
  }
}

