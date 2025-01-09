import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo/data/services/firebase/model/login_request/login_request.dart';
import 'package:todo/utils/exception.dart';
import 'package:todo/utils/result.dart';

class AuthFirebaseService {
  User? get currentUser => FirebaseAuth.instance.currentUser;

  Future<Result<void>> login(LoginRequest loginRequest) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: loginRequest.email,
        password: loginRequest.password,
      );
      if (credential.user != null) {
        return Result.ok(null);
      } else {
        return Result.error(AppException('Login failed'));
      }
    } on FirebaseAuthException catch (e) {
      return Result.error(AppException(e.code));
    }
  }

  Future<Result<void>> register(LoginRequest loginRequest) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: loginRequest.email,
        password: loginRequest.password,
      );
      if (credential.user != null) {
        return Result.ok(null);
      } else {
        return Result.error(AppException('Register failed'));
      }
    } on FirebaseAuthException catch (e) {
      return Result.error(AppException(e.code));
    }
  }

  Future<Result<void>> logout() async {
    await FirebaseAuth.instance.signOut();
    return Result.ok(null);
  }
}
