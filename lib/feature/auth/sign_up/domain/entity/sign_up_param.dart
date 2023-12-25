class SignUpEmailParam {
  final String name;
  final String surname;
  final String email;
  final String? phone;
  final String password;

  SignUpEmailParam({
    this.phone,
    required this.name,
    required this.surname,
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() => {
    'name': name,
    'email': email,
    'phone': phone,
    'surname': surname,
    'password': password,
    'rePassword': password,
  };
}