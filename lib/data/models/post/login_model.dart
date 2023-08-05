class LoginModel {
  String email, password;
  LoginModel({required this.email, required this.password});

  Map<String, String> toJson() {
    return {"email": email, "password": password};
  }
}
