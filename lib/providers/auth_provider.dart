import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:home/services/app_config.dart';
import 'package:home/services/shared_preference.dart';
import 'package:home/models/user.dart';

class AuthProvider extends ChangeNotifier {
  Future<Map<String, dynamic>> login(String account, String password) async {
    var result;
    notifyListeners();
    Response response = await post(Uri.parse(AppConfig.login),
        body: json.encode({'account': account, 'password': password}),
        headers: {"Content-Type": "application/json"});

    if (response.statusCode == 200) {
      User userData = User.fromJson(json.decode(response.body));
      UserPreferences().setUser(userData);
      notifyListeners();
      result = {'success': true, 'user': userData};
    } else {
      notifyListeners();
      result = {'success': false, 'message': response.body};
    }
    return result;
  }

  Future<Map<String, dynamic>> register(User user) async {
    var result;
    Response response = await post(Uri.parse(AppConfig.user),
        body: json.encode(user), headers: {"Content-Type": "application/json"});
    if (response.statusCode == 200) {
      result = {'success': true};
    } else {
      result = {'success': false, 'message': response.body};
    }
    return result;
  }
}
