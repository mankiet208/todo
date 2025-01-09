import 'package:firebase_auth/firebase_auth.dart';
import 'package:logging/logging.dart';
import 'package:todo/data/repositories/auth/auth_repository.dart';
import 'package:todo/data/services/firebase/auth_firebase_service.dart';
import 'package:todo/data/services/firebase/model/login_request/login_request.dart';
import 'package:todo/utils/result.dart';

class AuthFirebaseRepository extends AuthRepository {
  AuthFirebaseRepository({
    required AuthFirebaseService service,
  }) : _service = service;

  final AuthFirebaseService _service;

  final _log = Logger('AuthRepositoryFirebase');

  @override
  User? get currentUser => _service.currentUser;

  @override
  bool get isAuthenticated => _service.currentUser != null;

  @override
  Future<Result<void>> login({
    required String email,
    required String password,
  }) async {
    try {
      final result = await _service.login(
        LoginRequest(
          email: email,
          password: password,
        ),
      );
      return result;
    } finally {
      notifyListeners();
    }
  }

  @override
  Future<Result<void>> register({
    required String email,
    required String password,
  }) async {
    try {
      final result = await _service.register(
        LoginRequest(
          email: email,
          password: password,
        ),
      );
      return result;
    } finally {
      notifyListeners();
    }
  }

  @override
  Future<Result<void>> logout() {
    _log.info('User logged out');
    try {
      return _service.logout();
    } finally {
      notifyListeners();
    }
  }
}
