class RegisterModel {
  String name, email, password, passwordConfirmation, gender;
  int age;

  RegisterModel(
      {required this.name,
      required this.email,
      required this.password,
      required this.passwordConfirmation,
      required this.age,
      required this.gender});

  Map<String, String> toJson() {
    return {
      "name": name,
      "email": email,
      "password": password,
      "password_confirmation": passwordConfirmation,
      "age": age.toString(),
      "gender": gender
    };
  }
}
