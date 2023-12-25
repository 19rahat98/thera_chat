import 'dart:async';
import 'dart:convert';
import 'package:theta_chat/common/exception/auth_error_entity.dart';
import 'package:theta_chat/common/exception/exception.dart';
import 'package:theta_chat/utils/http_call_utils.dart';

enum ExceptionType {
  /// проблема с авторизации
  authError,

  /// показывает сообщение об ошибке с возможность передачи http кода
  errorHttp,

  /// показывает сообщение об ошибке при отсутвии интернета
  internetErrorConnection,

  /// показывает сообщение об ошибке при cбое самого приложения
  errorException,
  defaultError,
}

typedef CoreResultData<T> = void Function(T result);

typedef CoreErrorData<T> = void Function(T? result, ExceptionType);

/// результат выполнения загрузчика (лоадера)
typedef CoreLoadingData = void Function(bool isLoading);

mixin CoreRequestWorkedMixin {
  /// Timer для запроса
  Timer? timer;

  final String _defaultError = 'Произошла ошибка';

  /// функиця безопастно запускает запрос без обработки пользовательской
  ///  ошибки(выводиться ошибки в стандартных полях предусмотренные сервером)
  /// [request] запрос принимает фнкция useCase
  /// [loading] callback функция информирующая старт загрузки
  /// [resultData] callback успешном результате
  /// [errorData]  callback при ошибке

  Future<void> launch<T>({
    required Future<T> request,
    CoreLoadingData? loading,
    CoreResultData<T>? resultData,
    required CoreErrorData errorData,
  }) async {
    loading?.call(true);
    try {
      final result = await request;
      loading?.call(false);
      resultData?.call(result);
    } on GlobalAuthException catch (ex) {
      loading?.call(false);
      _makeHttpException<String>(ex, errorData);
    } catch (ex) {
      loading?.call(false);
      _makeException<String>(ex, errorData);
    }
  }

  /// функиця безопастного подслушование сокета, и с возможностю обработки
  ///  ошибки(выводиться ошибки в стандартных полях предусмотренные сервером)
  /// [socket] запрос принимает фнкция useCase
  /// [jsonCall] callback функция для парсинга списка
  /// [resultData] callback успешном результате
  /// [errorData]  callback при ошибке
  void listenSocketWithError<T>(
    Stream socket,
    ResponseListJson<T> jsonCall, {
    Function(T)? resultData,
    required CoreErrorData errorData,
  }) {
    try {
      socket.listen((dynamic event) {
        final result = jsonDecode(event as String) as List<dynamic>;
        final json = jsonCall.call(result);
        resultData?.call(json);
      });
    } catch (ex) {
      _makeException<String>(ex, errorData);
    }
  }

  /// функиця безопастно запускает запрос c обработкой пользовательской
  ///  ошибки c возможностью добавить задержку
  /// [delay] время задержки запроса
  /// [request] запрос принимает фнкция useCase
  /// [loading] callback функция информирующая старт загрузки
  /// [resultData] callback успешном результате
  /// [errorData]  callback при ошибке
  void launchDelayWithError<T, V extends HttpRequestException<V>>(
    int delay, {
    required Future<T> request,
    CoreLoadingData? loading,
    CoreResultData<T>? resultData,
    required CoreErrorData errorData,
  }) {
    _delay(delay, () async {
      loading?.call(true);
      try {
        final result = await request;
        loading?.call(false);
        resultData?.call(result);
      } on GlobalAuthException catch (ex) {
        loading?.call(false);
        _makeHttpException<V>(ex, errorData);
      } catch (ex, s) {
        loading?.call(false);
        _makeException<V>(s, errorData);
      }
    });
  }

  /// функиця безопастно запускает запрос c обработкой
  /// [request] запрос принимает фнкция useCase
  /// [loading] callback функция информирующая старт загрузки
  /// [resultData] callback успешном результате
  /// [errorData]  callback при ошибке
  Future<void> launchWithError<T, V>({
    required Future<T> request,
    CoreLoadingData? loading,
    CoreResultData<T>? resultData,
    required CoreErrorData errorData,
  }) async {
    loading?.call(true);
    try {
      final result = await request;
      loading?.call(false);
      resultData?.call(result);
    } on HttpRequestException catch (ex) {
      loading?.call(false);
      _makeHttpException<V>(ex, errorData);
    } catch (ex, s) {
      loading?.call(false);
      _makeException<String>(s, errorData);
    }
  }

  /// функиця безопастно запускает запрос c обработкой пользовательской
  ///  ошибки для авторизованных юзеров
  /// [request] запрос принимает фнкция useCase
  /// [loading] callback функция информирующая старт загрузки
  /// [resultData] callback успешном результате
  /// [errorData]  callback при ошибке
  Future<void> launchWithAuthError<T, V>({
    required Future<T> request,
    CoreLoadingData? loading,
    CoreResultData<T>? resultData,
    required CoreErrorData<V> errorData,
  }) async {
    loading?.call(true);
    try {
      final result = await request;
      loading?.call(false);
      resultData?.call(result);
    } on GlobalAuthException catch (ex) {
      _makeHttpException<V>(ex, errorData);
      loading?.call(false);
    } catch (ex) {
      errorData(null, ExceptionType.defaultError);
      loading?.call(false);
    }
  }

  /// функиця безопастно запускает запрос без обработки пользовательской
  /// ошибки(выводиться ошибки в стандартных полях предусмотренные сервером)
  /// [delay] время задержки запроса
  /// [request] запрос принимает фнкция useCase
  void launchDelay(
    int delay, {
    required Function() request,
    required Function() onLoading,
  }) {
    if (timer?.isActive ?? false) timer?.cancel();
    onLoading.call();
    timer = Timer(Duration(milliseconds: delay), () {
      request.call();
    });
  }

  void clear() {
    timer = null;
  }

  /// отображает http ошибки
  void _makeHttpException<T>(
    HttpRequestException ex,
    CoreErrorData<T> errorData,
  ) {
    if (ex.httpTypeError == HttpTypeError.notInternetConnection) {
      errorData.call(null, ExceptionType.internetErrorConnection);
      return;
    }

    if (ex.code == 401) {
      errorData.call(null, ExceptionType.authError);
      return;
    }

    if (ex is T) {
      errorData.call(ex as T, ExceptionType.defaultError);
      return;
    }

    if (ex.httpTypeError == HttpTypeError.http) {
      errorData.call(null, ExceptionType.errorHttp);
      return;
    }
  }

  /// функция запускает таймер на определенное время
  void _delay(int delay, Function() run) {
    if (timer != null) {
      timer!.cancel();
    }
    timer = Timer(Duration(milliseconds: delay), () {
      run();
    });
  }

  /// отображает различные исключения
  void _makeException<String>(dynamic ex, CoreErrorData errorData) {
    errorData.call(_defaultError, ExceptionType.defaultError);
  }
}
