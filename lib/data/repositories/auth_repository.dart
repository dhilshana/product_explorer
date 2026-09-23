import 'package:firebase_auth/firebase_auth.dart';
import 'package:product_explorer/data/services/firebase_auth_service.dart';

class AuthRepository {
  final FirebaseAuthService _service;

  AuthRepository({FirebaseAuthService? service})
      : _service = service ?? FirebaseAuthService();

  Stream<User?> get authStateChanges => _service.authStateChanges;

  User? get currentUser => _service.currentUser;

  Future<User?> signUp({
    required String email,
    required String password,
    String? displayName,
  }) {
    return _service.signUp(
      email: email,
      password: password,
      displayName: displayName,
    );
  }

  Future<User?> login({
    required String email,
    required String password,
  }) {
    return _service.login(
      email: email,
      password: password,
    );
  }

  Future<void> logout() {
    return _service.logout();
  }
}
