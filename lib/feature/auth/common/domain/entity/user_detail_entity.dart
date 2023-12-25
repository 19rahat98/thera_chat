import 'package:equatable/equatable.dart';
import 'package:theta_chat/common/constants/app_core_constant.dart';
import 'package:theta_chat/feature/auth/common/data/dto/user_detail_dto.dart';

class UserDetailEntity extends Equatable {
  const UserDetailEntity({
    this.id = CoreConstant.empty,
    this.roles = CoreConstant.empty,
    this.name = CoreConstant.empty,
    this.thread = CoreConstant.empty,
    this.email = CoreConstant.empty,
  });

  factory UserDetailEntity.fromDto(UserDetailDto dto) => UserDetailEntity(
        id: dto.id ?? CoreConstant.empty,
        roles: dto.roles ?? CoreConstant.empty,
        name: dto.name ?? CoreConstant.empty,
        thread: dto.thread ?? CoreConstant.empty,
        email: dto.email ?? CoreConstant.empty,
      );

  final String id;
  final String roles;
  final String thread;
  final String name;
  final String email;

  @override
  List<Object> get props => [email, name, id, roles, thread];
}
