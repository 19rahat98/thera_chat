class GlobalRegexConstant {
  /// регулярное для таймера
  static final regTimer = RegExp(r'((^0*[1-9]\d*:)?\d{2}:\d{2})\.\d+$');

  /// проверка на символы
  static final regDigits = RegExp('[^0-9]');

  static const pointZero = '.0';

  static const pointZeroZero = '.00';

  static final regAlphabet = RegExp('^[a-zA-Z]');

  static final cyrillic = RegExp(
    r'[\u0400-\u04FF\u0500-\u052F\u2DE0-\u2DFF\uA640-\uA69F\u1C80-\u1C88]',
  );

  static final regPhoneNumber = RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)');

  static final urlPattern = RegExp(
    r'(https?://[^\s<>]+)|(?:<a href="(https?://[^\s<>]+)">([^<]+)</a>)',
    caseSensitive: false,
  );

  /// регулярное для email
  static final regEmail = RegExp(
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
  );

  /// проверка на цифры
  static final regNumbers = RegExp(r'\D');

  /// проверка на символы в платежах
  static final regPayments = RegExp('[,+,-]');

  /// регулярное выражение на параль
  static final regPassword = RegExp(
    r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#$&*~%_\-+=;:,.<>?[\]"\\/{}()|^]).{8,}$',
  );

  /// резулярное выражения для проверки mp3
  static final mp3Regex = RegExp('.mp3');

  /// регулярное выражение для добавление пробела через каждые 3 символа
  static final regBalance = RegExp(r'\B(?=(\d{3})+(?!\d))');

  /// Должен содержать хотя бы один большие буквы
  static final shouldContainAtLeastOneUpperCase = RegExp('^(?=.*?[A-Z])');

  /// Должен содержать хотя бы один маленькие буквы
  static final shouldContainAtLeastOneLowerCase = RegExp('^(?=.*?[a-z])');

  /// Должен содержать хотя бы одну цифру
  static final shouldContainAtLeastOneDigit = RegExp('^(?=.*?[0-9])');

  /// Должен содержать хотя бы один специальный символ
  static final shouldContainAtLeastOneSpecialCharacter =
  RegExp(r'^(?=.*?[!?@#$&*~])');

  /// Должен быть не менее 8 символов в длину
  static final mustBeAtLeastEightCharactersInLength = RegExp(r'^.{8,}$');

  ///
  static final taxNumber = RegExp(r'^[a-zA-Z0-9/-]+$');
}
