import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class GlobalContext {
  //! ATENÇÃO: NUNCA USAR ESTE MÉTODO PARA NAVEGAR ENTRE PÁGINAS
  static GlobalContext? _instance;
  late final GlobalKey<NavigatorState> _navigatorKey;
  GlobalContext._();
  static GlobalContext get instance {
    _instance ??= GlobalContext._();
    return _instance!;
  }

  set navigatorKey(GlobalKey<NavigatorState> key) => _navigatorKey = key;

  Future<void> loginExpired() async {
    final sp = await SharedPreferences.getInstance();
    sp.clear();
    showTopSnackBar(
        _navigatorKey.currentState!.overlay!,
        const CustomSnackBar.error(
          message: 'Sua sessão expirou!',
          backgroundColor: Colors.black,
        ));
    _navigatorKey.currentState!.popUntil(ModalRoute.withName('/home'));
  }
}
