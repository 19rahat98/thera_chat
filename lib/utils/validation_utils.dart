import 'package:theta_chat/common/constants/global_regex_constant.dart';

/// проверка корректности email
bool isEmailValid(String emailValue) {
  return GlobalRegexConstant.regEmail.hasMatch(emailValue);
}

/// валидация iin
/// [iin] - Индивидуальный идентификационный номер
bool isValidIIN(String iin) {
  if (iin.length != 12) return false;

  final yy = int.parse(iin.substring(0, 2));
  final mm = int.parse(iin.substring(2, 4));
  final dd = int.parse(iin.substring(4, 6));

  if (yy > 99 || yy < 0) return false;
  if (mm > 12 || mm < 1) return false;
  if (dd > 31 || dd < 1) return false;

  final genderCentury = int.parse(iin.substring(6, 7));

  if (genderCentury > 6 || genderCentury < 0) return false;

  final b1 = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11];
  final b2 = [3, 4, 5, 6, 7, 8, 9, 10, 11, 1, 2];

  final a = <int>[];

  var control = 0;

  for (var i = 0; i < 12; i++) {
    a.add(int.parse(iin.substring(i, i + 1)));
    if (i < 11) control += a[i] * b1[i];
  }

  control = control % 11;
  if (control == 10) {
    control = 0;
    for (var i = 0; i < 11; i++) {
      control += a[i] * b2[i];
    }
    control = control % 11;
  }

  if (control != a[11]) return false;

  return true;
}

/// валидация пароля
/// [password] пароль
bool isValidPassword(String password) =>
    GlobalRegexConstant.regPassword.hasMatch(password);

bool isHasLatinChart(String input) =>
    GlobalRegexConstant.cyrillic.hasMatch(input);
