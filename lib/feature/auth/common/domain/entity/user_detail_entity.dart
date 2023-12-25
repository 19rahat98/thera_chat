import 'package:equatable/equatable.dart';
import 'package:theta_chat/common/constants/app_core_constant.dart';

class UserDetailEntity extends Equatable {
  const UserDetailEntity({
    this.name = CoreConstant.empty,
    this.email = CoreConstant.empty,
  });

  factory UserDetailEntity.empty() => const UserDetailEntity();

  final String name;

  final String email;

  @override
  List<Object> get props => [email, name];
}
