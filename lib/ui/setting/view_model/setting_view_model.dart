import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:todo/data/repositories/auth/auth_repository.dart';
import 'package:todo/utils/command.dart';
import 'package:todo/utils/result.dart';

class SettingViewModel extends ChangeNotifier {
  SettingViewModel({
    required AuthRepository authRepository,
  }) : _authRepository = authRepository {
    logout = Command0<void>(_logout);
  }

  final AuthRepository _authRepository;
  final _log = Logger('HomeViewModel');

  late Command0 logout;

  Future<Result<void>> _logout() async {
    final result = await _authRepository.logout();

    if (result is Error) {
      _log.warning('Logout failed! ${result.exception}');
    }
    return result;
  }
}
