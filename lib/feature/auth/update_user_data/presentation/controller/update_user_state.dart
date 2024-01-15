part of 'update_user_controller.dart';

enum UpdateUserStatus {
  common,
  success,
  failure,
}

class UpdateUserState extends Equatable {
  const UpdateUserState({
    this.user,
    this.errorMessage,
    this.isLoading = false,
    this.status = UpdateUserStatus.common,
  });

  final bool isLoading;
  final String? errorMessage;
  final UpdateUserStatus status;
  final UserDetailEntity? user;

  @override
  List<Object?> get props => [isLoading, status, errorMessage ?? 0, user ?? 0];
}
