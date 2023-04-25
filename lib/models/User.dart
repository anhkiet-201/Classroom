class User {
  final String? userName;
  final String email;
  final String password;
  final String? birthday;

  User(
      {this.userName,
      required this.email,
      required this.password,
      this.birthday});
}


