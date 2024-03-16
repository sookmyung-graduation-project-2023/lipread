class UserModel {
  final String id;
  final String name;
  final String email;
  final String? deviceToken;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.deviceToken,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = {};
    json['id'] = id;
    json['name'] = name;
    json['email'] = email;
    json['deviceToken'] = deviceToken;
    return json;
  }
}
