import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:todo/data/repositories/auth/auth_repository.dart';
import 'package:todo/utils/command.dart';
import 'package:todo/utils/extensions/string_extension.dart';
import 'package:todo/utils/result.dart';

class LoginViewModel extends ChangeNotifier {
  LoginViewModel({
    required AuthRepository authRepository,
  }) : _authRepository = authRepository {
    login = Command1<void, (String email, String password)>(_login);
  }

  final AuthRepository _authRepository;
  late Command1 login;

  final _log = Logger('LoginViewModel');

  String _email = '';
  String _password = '';
  bool _hasEmailError = false;
  bool _hasPasswordError = false;

  String get email => _email;
  String get password => _password;
  bool get hasEmailError => _hasEmailError;
  bool get hasPasswordError => _hasPasswordError;

  bool get isFormValid =>
      _email.isNotEmpty &&
      _password.isNotEmpty &&
      !_hasEmailError &&
      !_hasPasswordError;

  void updateEmail(String email) {
    _email = email;
    _validateEmail();
    notifyListeners();
  }

  void updatePassword(String password) {
    _password = password;
    _validatePassword();
    notifyListeners();
  }

  void _validateEmail() {
    _hasEmailError = !_email.isValidEmail();
  }

  void _validatePassword() {
    _hasPasswordError = _password.length < 8;
  }

  Future<Result<void>> _login((String, String) credentials) async {
    final (email, password) = credentials;
    final result = await _authRepository.login(
      email: email,
      password: password,
    );

    if (result is Error) {
      _log.warning('Login failed! ${result.exception}');
    }
    return result;
  }
}
