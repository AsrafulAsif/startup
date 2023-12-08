class ApiEndPoint {
  String baseUrl = "http://192.168.0.100:8080";

  late String userRegisterUrl = '$baseUrl/api/v1/user/register';
  late String userLogInUrl = '$baseUrl/api/v1/user/login';
  late String fileUploadUrl = '$baseUrl/api/v1/image-file/upload';
}
