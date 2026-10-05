import 'package:shared_preferences/shared_preferences.dart';

/// Persists the "Continue without account" choice on this device.
class AuthLocalDatasource {
  const AuthLocalDatasource();

  static const _guestKey = 'continue_without_account';

  Future<bool> isGuest() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_guestKey) ?? false;
  }

  Future<void> setGuest(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_guestKey, value);
  }
}
