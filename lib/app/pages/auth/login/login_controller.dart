import 'package:bloc/bloc.dart';
import 'package:dart_week_delivery/app/core/exceptions/unauthorized_exceptions.dart';
import 'package:dart_week_delivery/app/pages/auth/login/login_state.dart';
import 'package:dart_week_delivery/app/repositories/auth/auth_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends Cubit<LoginState> {
  final AuthRepository _authRepository;

  LoginController(this._authRepository) : super(const LoginState.initial());

  Future<void> login(String email, String password) async {
    try {
      emit(state.copyWith(status: LoginStatus.login));
      final authModel = await _authRepository.login(email, password);
      final sp = await SharedPreferences.getInstance();
      sp.setString('accessToken', authModel.aceessToken);
      sp.setString('refreshToken', authModel.refreshToken);
      emit(state.copyWith(status: LoginStatus.success));
    } on UnauthorizedExceptions {
      emit(state.copyWith(status: LoginStatus.loginError, message: 'Login  ou Senha inválidos'));
    } catch (e) {
      emit(state.copyWith(status: LoginStatus.error, message: 'Erro ao fazer login'));
    }
  }
}
