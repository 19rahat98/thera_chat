import 'package:dio/dio.dart';
import 'package:theta_chat/common/constants/app_global_network_constant.dart';
import 'package:theta_chat/di/service_locator.dart';
import 'package:theta_chat/feature/auth/common/data/repository/authorized_repository.dart';
import 'package:theta_chat/feature/auth/common/data/repository/global_personal_secure_data_repository.dart';

/// interceptor для отправки авторизационного хэдера
/// и обработки ошибок [401] и [403]
class BearerTokenInterceptor extends InterceptorsWrapper {
  BearerTokenInterceptor(this.dio)
      : _secureDataRepository = sl(),
        _authRepository = sl();

  final Dio dio;
  final AuthRepository _authRepository;
  final GlobalPersonalSecureDataRepository _secureDataRepository;

  /// максимальное количесво повтори при авторизационных ошибках
  static const maxRepeatCount = 3;

  /// счетчик для повторов запроса в случае авторизационных ошибок [401] и [403]
  int _repeatCounter = 0;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final accessToken = await _secureDataRepository.accessToken;
    options.headers[GlobalNetworkConstant.authorization] =
        '${GlobalNetworkConstant.bearer} $accessToken';
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    _resetRepeatCounter();
    return handler.next(response);
  }

  @override
  Future onError(DioError err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 403 || err.response?.statusCode == 401) {
      final requestOptions = err.response?.requestOptions;

      try {
        final authResponse = await _authRepository.refreshToken();
        final accessToken = authResponse.access;
        _secureDataRepository.setAccessToken(accessToken);
        requestOptions?.headers[GlobalNetworkConstant.authorization] =
            '${GlobalNetworkConstant.bearer} $accessToken';

        /// обновляем счетчик если количество повторов превисило лимит
        if (_repeatCounter >= maxRepeatCount) {
          _resetRepeatCounter();
          return handler.reject(err);
        }

        _repeatCounter++;

        // TODO need check for null safety
        final response = await dio.fetch<dynamic>(requestOptions!);
        return handler.resolve(response);
      } catch (ex) {
        _resetRepeatCounter();
        return handler.reject(err);
      }
    } else {
      _resetRepeatCounter();
      return handler.reject(err);
    }
  }

  /// обновляет счетчик _repeatCounter
  /// необходимо обновление в случае успешного ответа от сервера
  /// или при ошибках кроме 401 и 403
  void _resetRepeatCounter() {
    _repeatCounter = 0;
  }
}
