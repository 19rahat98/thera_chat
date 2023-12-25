/// миксин для предотвращения двойного нажатия в кликабельных виджетах
mixin IgnoreDoubleTapMixin {
  DateTime? _loginClickTime;

  bool get isRedundantClick {
    final currentTime = DateTime.now();
    if (_loginClickTime == null) {
      _loginClickTime = currentTime;
      return false;
    }
    if (currentTime.difference(_loginClickTime!).inSeconds <= 1) {
      return true;
    }

    _loginClickTime = currentTime;
    return false;
  }
}
