import 'package:flutter/foundation.dart';
import '../services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _auth = AuthService();
  bool _loading = false;

  bool get isLoading => _loading;
  Stream<User?> get authStateChanges => _auth.authStateChanges;

  Future<String?> register({required String email, required String password}) async {
    _loading = true; notifyListeners();
    try {
      await _auth.register(email: email, password: password);
      return null;
    } catch (e) {
      return e.toString();
    } finally {
      _loading = false; notifyListeners();
    }
  }

  Future<String?> login({required String email, required String password}) async {
    _loading = true; notifyListeners();
    try {
      await _auth.login(email: email, password: password);
      return null;
    } catch (e) {
      return e.toString();
    } finally {
      _loading = false; notifyListeners();
    }
  }

  Future<void> logout() => _auth.logout();

  Future<String?> sendPasswordReset({required String email}) async {
    _loading = true; notifyListeners();
    try {
      await _auth.sendPasswordReset(email: email);
      return null;
    } catch (e) {
      return e.toString();
    } finally {
      _loading = false; notifyListeners();
    }
  }
}
