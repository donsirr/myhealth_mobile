import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PassportProvider extends ChangeNotifier {
  // Passport data fields
  String _fullName = '';
  String _bloodType = '';
  String _emergencyContact = '';
  String _allergies = '';

  // SharedPreferences instance
  SharedPreferences? _prefs;

  // Getters
  String get fullName => _fullName;
  String get bloodType => _bloodType;
  String get emergencyContact => _emergencyContact;
  String get allergies => _allergies;

  // Check if passport data exists
  bool get hasData => _fullName.isNotEmpty;

  // Generate QR data string (same format as Next.js version)
  String get qrData =>
      '$_fullName | $_bloodType | $_emergencyContact | $_allergies';

  /// Load data from SharedPreferences
  Future<void> loadData() async {
    _prefs = await SharedPreferences.getInstance();

    _fullName = _prefs?.getString('passport_fullName') ?? '';
    _bloodType = _prefs?.getString('passport_bloodType') ?? '';
    _emergencyContact = _prefs?.getString('passport_emergencyContact') ?? '';
    _allergies = _prefs?.getString('passport_allergies') ?? '';

    notifyListeners();
  }

  /// Save data to SharedPreferences
  Future<bool> saveData({
    required String fullName,
    required String bloodType,
    required String emergencyContact,
    required String allergies,
  }) async {
    try {
      _prefs ??= await SharedPreferences.getInstance();

      await _prefs!.setString('passport_fullName', fullName);
      await _prefs!.setString('passport_bloodType', bloodType);
      await _prefs!.setString('passport_emergencyContact', emergencyContact);
      await _prefs!.setString('passport_allergies', allergies);

      // Update local state
      _fullName = fullName;
      _bloodType = bloodType;
      _emergencyContact = emergencyContact;
      _allergies = allergies;

      notifyListeners();
      return true;
    } catch (e) {
      debugPrint('Error saving passport data: $e');
      return false;
    }
  }

  /// Clear all passport data
  Future<void> clearData() async {
    _prefs ??= await SharedPreferences.getInstance();

    await _prefs!.remove('passport_fullName');
    await _prefs!.remove('passport_bloodType');
    await _prefs!.remove('passport_emergencyContact');
    await _prefs!.remove('passport_allergies');

    _fullName = '';
    _bloodType = '';
    _emergencyContact = '';
    _allergies = '';

    notifyListeners();
  }
}
