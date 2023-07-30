class SignupBody {
  String name;
  String phone;
  String email;
  String password;

  SignupBody({
    required this.name,
    required this.email,
    required this.password,
    required this.phone,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["f_name"] = name;
    data["phone"] = phone;
    data["email"] = email;
    data["password"] = password;

    return data;
  }
}
