class AppUserRegisterRequest{
  String userName;
  String phoneNumber;
  String appPassword;
  String fcmToken;
  String deviceType;

  AppUserRegisterRequest({
    required this.userName,
    required this.phoneNumber,
    required this.appPassword,
    required this.fcmToken,
    required this.deviceType,
  });

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['userName'] = userName;
    data['phoneNumber'] = phoneNumber;
    data['appPassword'] = appPassword;
    data['fcmToken'] = fcmToken;
    data['deviceType'] = deviceType;
    return data;
  }

}