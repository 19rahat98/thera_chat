class SignUpEmailParam {
  final String name;
  final String surname;
  final String? email;
  final String? phone;
  final String password;

  SignUpEmailParam({
    this.phone,
    this.email,
    required this.name,
    required this.surname,
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