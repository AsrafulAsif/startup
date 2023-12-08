class AppUserLogInRequest {
  String mobileNumber;
  String appPassword;
  String deviceType;
  String fcmToken;

  AppUserLogInRequest({
    required this.mobileNumber,
    required this.appPassword,
    required this.deviceType,
    required this.fcmToken,
  });

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['mobileNumber'] = mobileNumber;
    data['appPassword'] = appPassword;
    data['deviceType'] = deviceType;
    data['fcmToken'] = fcmToken;
    return data;
  }
}
