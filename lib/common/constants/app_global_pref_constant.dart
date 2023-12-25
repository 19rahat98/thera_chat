/// содержит все ключи для глобальных преференсов
class GlobalPrefConstant {
  /// launcher (первичный запуск и действия пользователя)
  static const isBeforeViewOnboarding = 'isBeforeViewOnboarding';
  static const isBeforeViewInstruction = 'isBeforeViewInstruction';

  /// notification
  static const isBeforeRequestNotificationPermission = 'isBeforeRequestNotificationPermission';
  static const enableSendNotification = 'enableSendNotification';

  /// анкета
  static const questionnaire = 'questionnaire';

  /// настроики юзера
  static const prefOtcStatus = 'prefOtcStatus';

  /// настройки
  static const prefLocalization = 'prefLocalization';
  static const prefPushNotification = 'prefPushNotification';
  static const prefGeoLocation = 'prefGeoLocation';

  /// персональные данные
  static const prefAccessToken = 'prefAccessToken';
  static const prefRefreshToken = 'prefRefreshToken';
  static const prefPhoneNumber = 'prefPhoneNumber';
  static const prefPassword = 'prefPassword';
  static const prefPinCode = 'prefPinCode';
  static const prefUseBiometric = 'prefUseBiometric';

  /// данные юзера
  static const prefUserData = 'prefUserData';

  static const prefUserEmail = 'prefUserEmail';

  /// локальная сессия
  static const prefLastTimeActionSession = 'prefLastTimeActionSession';

  /// apple wallet
  static const prefShowAppleWalletOnboarding = 'prefShowAppleWalletOnboarding';
}
