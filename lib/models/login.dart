class Login {
  int id;
  String username;
  String email;
  String sessionToken;
  String firstName;
  String lastName;

  Login(this.id, this.username, this.email, this.sessionToken, this.firstName,
      this.lastName);

  factory Login.fromJson(Map<String, dynamic> json) {
    return Login(
      json["id"] ?? 0,
      json["username"] ?? "",
      json["email"] ?? "",
      json["session_token"] ?? "",
      json["first_name"] ?? "",
      json["last_name"] ?? "",
    );
  }
}
