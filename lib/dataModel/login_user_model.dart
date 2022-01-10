class LogInUserModel {
  LogInUserModel({
    required this.result,
    required this.message,
    required this.accessToken,
    required this.tokenType,
    required this.expiresAt,
    required this.user,
  });
  late final bool result;
  late final String message;
  late final String accessToken;
  late final String tokenType;
  late final String expiresAt;
  late final User user;

  LogInUserModel.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    message = json['message'];
    accessToken = json['access_token'];
    tokenType = json['token_type'];
    expiresAt = json['expires_at'];
    user = User.fromJson(json['user']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['result'] = result;
    _data['message'] = message;
    _data['access_token'] = accessToken;
    _data['token_type'] = tokenType;
    _data['expires_at'] = expiresAt;
    _data['user'] = user.toJson();
    return _data;
  }
}

class User {
  User({
    required this.id,
    required this.type,
    required this.name,
    required this.email,
    this.avatar,
    required this.avatarOriginal,
    this.phone,
  });
  late final int id;
  late final String type;
  late final String name;
  //late final String email;
  late final String? email;
  late final dynamic avatar;
  late final String avatarOriginal;
  late final dynamic phone;

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    name = json['name'];
    email = json['email'];
    avatar = json["avatar"];
    avatarOriginal = json['avatar_original'];
    phone = json["phone"];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['type'] = type;
    _data['name'] = name;
    _data['email'] = email;
    _data['avatar'] = avatar;
    _data['avatar_original'] = avatarOriginal;
    _data['phone'] = phone;
    return _data;
  }
}
