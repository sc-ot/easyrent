


class Client{
  int id;
  String name;
  String backendUrl;

  Client(this.id, this.name, this.backendUrl);

  factory Client.fromJson(Map<String, dynamic> json) {
    return Client(
      json["id"] ?? 0,
      json["name"] ?? "",
      json["backend_url"] ?? "",
    );
  }
}
