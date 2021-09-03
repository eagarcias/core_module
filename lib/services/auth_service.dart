import 'dart:convert';
import 'package:core/models/user_model.dart';
import 'package:http/http.dart' as http;

class AuthService {
  Future<UserSessionModel?> login(
      {required String url,
      required String email,
      required String password}) async {
    final body = jsonEncode(
        {"email": email, "password": password, "source": 'flutter ios - v2.0'});
    final response = await http.post(Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Require-Language': 'de',
        },
        body: body);
    if (response.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(response.body);
      bool isSuccessful = json['successful'];
      if (isSuccessful) {
        return userSessionFromJson(response.body);
      } else {
        return null;
      }
    }
    return null;
  }
}
