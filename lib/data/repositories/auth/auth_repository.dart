import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:todo/utils/result.dart';

abstract class AuthRepository extends ChangeNotifier {
  bool get isAuthenticated;

  User? get currentUser;

  Future<Result<void>> login({
    required String email,
    required String password,
  });

  Future<Result<void>> register({
    required String email,
    required String password,
  });

  Future<Result<void>> logout();
}
