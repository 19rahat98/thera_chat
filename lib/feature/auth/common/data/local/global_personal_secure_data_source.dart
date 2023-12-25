import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:theta_chat/common/constants/app_global_pref_constant.dart';
import 'package:theta_chat/di/service_locator.dart';

class GlobalPersonalSecureDataSource {
  GlobalPersonalSecureDataSource() : _secureStorage = sl();

  final FlutterSecureStorage _secureStorage;

  /// получает токен пользователя
  Future<String?> get accessToken => _secureStorage.read(
        key: GlobalPrefConstant.prefAccessToken,
      );

  /// получаем refresh токен полтзователя
  Future<String?> get refreshToken => _secureStorage.read(
        key: GlobalPrefConstant.prefRefreshToken,
      );

  /// получает номер телефона пользователя
  Future<String?> get phoneNumber => _secureStorage.read(
        key: GlobalPrefConstant.prefPhoneNumber,
      );

  /// получает пароль пользователя
  Future<String?> get password => _secureStorage.read(
        key: GlobalPrefConstant.prefPassword,
      );

  /// получаем пин код пользователя
  Future<String?> get pinCode => _secureStorage.read(
        key: GlobalPrefConstant.prefPinCode,
      );

  /// задаем флаг для использования беометрических данных
  void setUseBiometric(bool isUseBiometric) {
    _secureStorage.write(
      key: GlobalPrefConstant.prefUseBiometric,
      value: isUseBiometric.toString(),
    );
  }

  /// получаем флаг использует ли пользователь биометрические данные
  Future<String?> get isUseBiometric =>
      _secureStorage.read(key: GlobalPrefConstant.prefUseBiometric);

  /// записавыет токен пользователя
  void setAccessToken(String accessToken) {
    _secureStorage.write(
      key: GlobalPrefConstant.prefAccessToken,
      value: accessToken,
    );
  }

  /// удаляет access токен пользователя
  void removeAccessToken() {
    _secureStorage.delete(
      key: GlobalPrefConstant.prefAccessToken,
    );
  }

  /// удаляет refresh токен пользователя
  void removeRefreshToken() {
    _secureStorage.delete(
      key: GlobalPrefConstant.prefRefreshToken,
    );
  }

  /// записывает refresh токен пользователя
  void setRefreshToken(String refreshToken) {
    _secureStorage.write(
      key: GlobalPrefConstant.prefRefreshToken,
      value: refreshToken,
    );
  }

  /// записывает номер телефона пользователя
  void setPhoneNumber(String phoneNumber) {
    _secureStorage.write(
      key: GlobalPrefConstant.prefPhoneNumber,
      value: phoneNumber,
    );
  }

  /// записывает пароль пользователя
  void setPassword(String password) {
    _secureStorage.write(
      key: GlobalPrefConstant.prefPassword,
      value: password,
    );
  }

  /// сохраняет пин код пользователя
  void savePinCode(String pinCode) {
    _secureStorage.write(
      key: GlobalPrefConstant.prefPinCode,
      value: pinCode,
    );
  }

  /// записывает userName пользователя
  void setUserName(String userString) {
    _secureStorage.write(
      key: GlobalPrefConstant.prefUserData,
      value: userString,
    );
  }

  /// записывает userName пользователя
  void setUserEmail(String userEmailString) {
    _secureStorage.write(
      key: GlobalPrefConstant.prefUserEmail,
      value: userEmailString,
    );
  }

  /// возвращает данные юзера в json
  Future<String?> get userName => _secureStorage.read(
        key: GlobalPrefConstant.prefUserData,
      );

  /// возвращает данные юзера в json
  Future<String?> get userEmail => _secureStorage.read(
        key: GlobalPrefConstant.prefUserEmail,
      );

  /// очищает все данные
  Future<void> clearAll() async => _secureStorage.deleteAll();

  /// очищает пин код и использование биометрии
  void clearPinCodeAndBiometrics() {
    _secureStorage
      ..delete(key: GlobalPrefConstant.prefPinCode)
      ..delete(key: GlobalPrefConstant.prefPassword)
      ..delete(key: GlobalPrefConstant.prefUseBiometric);
  }

  void removeUserEmail() {
    _secureStorage.delete(
      key: GlobalPrefConstant.prefUserEmail,
    );
  }

  /// очищает access и refresh токены
  void clearTokens() {
    _secureStorage
      ..delete(key: GlobalPrefConstant.prefAccessToken)
      ..delete(key: GlobalPrefConstant.prefRefreshToken);
  }
}
