class SimpleResponse{

  String? message;
  int? statusCode;

  SimpleResponse({
    this.message,
    this.statusCode,
  });
  SimpleResponse.fromJson(Map<String, dynamic> json) {
    message = json['message']?.toString();
    statusCode = json['statusCode']?.toInt();
  }

  
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['message'] = message;
    data['statusCode'] = statusCode;
    return data;
  }

}