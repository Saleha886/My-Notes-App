class UserStore {
  static final UserStore _instance = UserStore._internal();
  factory UserStore() => _instance;
  UserStore._internal();

  String? name;
  String? emailOrPhone;
  String? password;

  void saveUser({required String name, required String emailOrPhone, required String password}) {
    this.name = name;
    this.emailOrPhone = emailOrPhone;
    this.password = password;
  }

  bool validateUser({required String emailOrPhone, required String password}) {
    return this.emailOrPhone == emailOrPhone && this.password == password;
  }

  bool get hasUser => emailOrPhone != null && password != null;
}
