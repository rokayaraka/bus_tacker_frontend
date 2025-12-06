class LogInModel {
  final String? message;
  final bool? status;
  final String? userID;

  LogInModel({
    required this.message,
    required this.status,
    required this.userID,
  });

  factory LogInModel.fromJson(Map<String, dynamic> json) {
    return LogInModel(
      message: json['message'] as String,
      status: json['status'] as bool,
      userID: json['userID'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'status': status,
      'userID': userID,
    };
  }
}
class LoginParams {
  final String userID;
  final String password;
  LoginParams(this.userID, this.password);
  //  Map<String, dynamic> toJson() {
  //   return {
  //     'userID': userID,

  //   };
  // }
}