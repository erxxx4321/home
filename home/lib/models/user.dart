class User {
  String? uid;
  String? name;
  String createdAt;
  String? email;
  String account;
  String password;

  User(
      {this.uid,
      this.name,
      required this.createdAt,
      this.email,
      required this.account,
      required this.password});

  factory User.fromJson(Map<String, dynamic> response) {
    return User(
        uid: response['_id'],
        name: response['name'],
        createdAt: response['createdAt'],
        email: response['email'],
        account: response['account'],
        password: response['password']);
  }
}
