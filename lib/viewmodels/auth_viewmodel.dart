import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:product_explorer/core/error/app_exception.dart';
import 'package:product_explorer/data/repositories/auth_repository.dart';

class AuthViewModel extends ChangeNotifier {
  final AuthRepository repository;

  User? user;
  bool isLoading = false;
  String? errorMessage;

  AuthViewModel({AuthRepository? repository})
      : repository = repository ?? AuthRepository() {
    user = this.repository.currentUser;
  }

  bool get isAuthenticated => user != null;

  Future<bool> signUp({
    required String email,
    required String password,
    String? name,
  }) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      user = await repository.signUp(
        email: email,
        password: password,
        displayName: name,
      );

      return true;
    } on AppException catch (e) {
      errorMessage = e.message;
      return false;
    } catch (e) {
      errorMessage = 'An unexpected error occurred. Please try again.';
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> login({
    required String email,
    required String password,
  }) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      user = await repository.login(
        email: email,
        password: password,
      );

      return true;
    } on AppException catch (e) {
      errorMessage = e.message;
      return false;
    } catch (e) {
      errorMessage = 'An unexpected error occurred. Please try again.';
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> logout() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      await repository.logout();
      user = null;
    } catch (e) {
      errorMessage = 'Failed to sign out.';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void clearError() {
    errorMessage = null;
    notifyListeners();
  }
}