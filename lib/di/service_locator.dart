import 'package:get_it/get_it.dart';
import 'package:theta_chat/common/constants/app_global_network_constant.dart';
import 'package:theta_chat/common/network/authorized_api_service.dart';
import 'package:theta_chat/common/network/unauthorized_api_service.dart';
import 'package:theta_chat/config/core_network.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:theta_chat/feature/auth/common/data/local/global_personal_secure_data_source.dart';
import 'package:theta_chat/feature/auth/common/data/repository/authorized_repository.dart';
import 'package:theta_chat/feature/auth/common/data/repository/global_personal_secure_data_repository.dart';
import 'package:theta_chat/feature/auth/common/domain/use_cases/authentication_use_cases.dart';
import 'package:theta_chat/feature/auth/common/domain/use_cases/get_user_data_use_case.dart';
import 'package:theta_chat/feature/auth/common/domain/use_cases/updata_user_data_use_case.dart';
import 'package:theta_chat/feature/auth/login/domain/use_cases/sign_in_with_email_use_case.dart';
import 'package:theta_chat/feature/auth/login/domain/use_cases/sign_in_with_number_use_case.dart';
import 'package:theta_chat/feature/auth/sign_up/domain/use_cases/sign_up_with_email_use_case.dart';
import 'package:theta_chat/feature/chat/guest/data/repository/guest_chat_repository.dart';
import 'package:theta_chat/feature/chat/guest/domain/use_cases/get_guest_chat_history_use_case.dart';
import 'package:theta_chat/feature/chat/guest/domain/use_cases/sent_guest_message_use_case.dart';
import 'package:theta_chat/feature/chat/guest/domain/use_cases/start_guest_chat_use_case.dart';
import 'package:theta_chat/feature/chat/thera_chat/data/repository/thera_chat_repository.dart';
import 'package:theta_chat/feature/chat/thera_chat/domain/use_cases/get_thera_chat_history_use_case.dart';
import 'package:theta_chat/feature/chat/thera_chat/domain/use_cases/sent_message_to_thera_use_case.dart';
import 'package:theta_chat/feature/chat/thera_chat/domain/use_cases/start_thera_chat_use_case.dart';

final sl = GetIt.instance;

Future<void> initLocator() async {
  _commonModule();
  _apiServiceModule();
  await _dataSourceModule();
  _repositoryModule();
  _registerAuthorizedHttpClient();
  _registerServices();
  _useCaseModule();
}

/// для общих зависимостей
void _commonModule() {
  /// Shared preferences
  final sharedPreferences = SharedPreferences.getInstance();
  sl
    ..registerSingletonAsync(() => sharedPreferences)
    ..registerSingleton(const FlutterSecureStorage())
    ..registerSingletonAsync(() => createHttpClient(GlobalNetworkConstant.url));
}

void _apiServiceModule() {
  /// для неавторизованной зоны
  sl.registerSingleton(UnauthorizedApiService(sl.getAsync()));
}

/// для локального хранения данных
Future<void> _dataSourceModule() async {
  sl.registerSingleton(GlobalPersonalSecureDataSource());
}

void _repositoryModule() {
  sl
    ..registerFactory(AuthRepository.new)
    ..registerFactory(GlobalPersonalSecureDataRepository.new)
    ..registerFactory(TheraChatRepository.new)
    ..registerFactory(GuestChatRepository.new);
}

void _registerAuthorizedHttpClient() {
  sl.registerSingletonAsync(
    () => createAuthorizedHttpClient(GlobalNetworkConstant.url),
    instanceName: GlobalNetworkConstant.authorized,
  );

  /// для авторизованной зоны
  sl.registerSingleton(
    AuthorizedApiService(
      sl.getAsync(
        instanceName: GlobalNetworkConstant.authorized,
      ),
    ),
  );
}

void _registerServices() {}

void _useCaseModule() {
  sl
    ..registerFactory(GlobalSignInWithEmailUseCase.new)
    ..registerFactory(GlobalSignUpWithEmailUseCase.new)
    ..registerFactory(GlobalGetUserDataUseCase.new)
    ..registerFactory(StartGuestChatUseCase.new)
    ..registerFactory(GetGuestChatHistoryUseCase.new)
    ..registerFactory(GetTheraChatHistoryUseCase.new)
    ..registerFactory(SendMessageToTheraChatUseCase.new)
    ..registerFactory(StartNewTheraChatUseCase.new)
    ..registerFactory(SendMessageAsGuestChatUseCase.new)
    ..registerFactory(GlobalUpdateUserDataUseCase.new)
    ..registerFactory(GlobalSignUpWithPhoneUseCase.new)
    ..registerFactory(GlobalSignInWithPhoneUseCase.new)
    ..registerFactory(CheckUserAccessUseCase.new);
}
