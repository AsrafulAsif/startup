import 'package:startup/model/reponse/simple_response.dart';

class AuthResponse {
  String? userName;
  bool? status;
  String? authorizationToken;

  AuthResponse({
    this.userName,
    this.status,
    this.authorizationToken,
  });
  AuthResponse.fromJson(Map<String, dynamic> json) {
    userName = json['userName']?.toString();
    status = json['status'];
    authorizationToken = json['authorizationToken']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['userName'] = userName;
    data['status'] = status;
    data['authorizationToken'] = authorizationToken;
    return data;
  }
}

class AuthResponseRest extends SimpleResponse {
  AuthResponse? authResponse;

  AuthResponseRest({
    super.message,
    super.statusCode,
    this.authResponse,
  });

  AuthResponseRest.fromJson(Map<String, dynamic> json) {
    message = json['message']?.toString();
    statusCode = json['statusCode']?.toInt();
    authResponse = (json['authResponse'] != null)
        ? AuthResponse.fromJson(json['authResponse'])
        : null;
  }

  @override
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['message'] = message;
    data['statusCode'] = statusCode;
    if (authResponse != null) {
      data['authResponse'] = authResponse!.toJson();
    }
    return data;
  }
}
