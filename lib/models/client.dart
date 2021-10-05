class Client {
  int id;
  String name;
  String backendUrl;
  String theme;

  Client(
    this.id,
    this.name,
    this.backendUrl,
    this.theme,
  );

  factory Client.fromJson(Map<String, dynamic> json) {
    return Client(
      json["id"] ?? 0,
      json["name"] ?? "",
      json["backend_url"] ?? "",
      json["angular_theme"] ?? "theme-1",
    );
  }
}
