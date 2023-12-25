class UserDetailDto {
  final String? createdAt;
  final String? email;
  final String? id;
  final String? name;
  final String? phone;
  final String? roles;
  final String? surname;
  final String? thread;

  UserDetailDto({
    this.createdAt,
    this.email,
    this.id,
    this.name,
    this.phone,
    this.roles,
    this.surname,
    this.thread,
  });

  // Конструктор для создания объекта из JSON
  factory UserDetailDto.fromJson(Map<String, dynamic> json) {
    return UserDetailDto(
      email: json['email'] as String?,
      id: json['id'] as String?,
      name: json['name'] as String?,
      phone: json['phone'] as String?,
      roles: json['roles'] as String?,
      thread: json['thread'] as String?,
      surname: json['surname'] as String?,
      createdAt: json['createdAt'] as String?,
    );
  }

  // Метод для преобразования объекта обратно в JSON
  Map<String, dynamic> toJson() {
    return {
      'createdAt': createdAt,
      'email': email,
      'id': id,
      'name': name,
      'phone': phone,
      'roles': roles,
      'surname': surname,
      'thread': thread,
    };
  }
}
