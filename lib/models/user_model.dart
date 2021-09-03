import 'dart:convert';

UserSessionModel userSessionFromJson(String str) =>
    UserSessionModel.fromJson(json.decode(str));

String userSessionToJson(UserSessionModel data) => json.encode(data.toJson());

class UserSessionModel{
  UserSessionModel({
    this.successful,
    this.data,
  });

  final bool? successful;
  final DataModel? data;

  factory UserSessionModel.fromJson(Map<String, dynamic> json) =>
      UserSessionModel(
        successful: json["successful"] == null ? null : json["successful"],
        data: json["data"] == null ? null : DataModel.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "successful": successful == null ? null : successful,
        "data": data == null ? null : data!.toJson(),
      };
}

class DataModel{
  DataModel(
      {this.token,
      this.userType,
      this.registrationPhase,
      this.firebaseKey,
      this.nextRegistrationPhase})
      : super();

  final String? token;
  final String? userType;
  final String? registrationPhase;
  final String? firebaseKey;
  final String? nextRegistrationPhase;

  factory DataModel.fromJson(Map<String, dynamic> json) => DataModel(
      token: json["token"] == null ? null : json["token"],
      userType: json["user_type"] == null ? null : json["user_type"],
      registrationPhase: json["registration_phase"] == null
          ? null
          : json["registration_phase"],
      nextRegistrationPhase: json["next_registration_phase"] == null
          ? null
          : json["next_registration_phase"],
      firebaseKey: json["firebase_key"] == null ? null : json["firebase_key"]);

  Map<String, dynamic> toJson() => {
        "token": token == null ? null : token,
        "user_type": userType == null ? null : userType,
        "registration_phase":
            registrationPhase == null ? null : registrationPhase,
        "firebase_key": firebaseKey == null ? null : firebaseKey
      };
}