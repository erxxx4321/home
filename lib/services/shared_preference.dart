import 'package:shared_preferences/shared_preferences.dart';
import 'package:home/models/user.dart';

class UserPreferences {
  Future<bool> setUser(User user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString('uid', user.uid ?? "");
    prefs.setString('name', user.name ?? "");
    prefs.setString('createdAt', user.createdAt);
    prefs.setString('email', user.email ?? "");
    prefs.setString('account', user.account);
    prefs.setString('password', user.password);

    return true;
  }

  Future<User> getUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return User(
      uid: prefs.getString('uid') ?? "",
      name: prefs.getString('name') ?? "",
      createdAt: prefs.getString('createdAt') ?? "",
      email: prefs.getString('email') ?? "",
      account: prefs.getString('account') ?? "",
      password: prefs.getString('password') ?? "",
    );
  }

  void removeUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('uid');
    prefs.remove('name');
    prefs.remove('createdAt');
    prefs.remove('email');
    prefs.remove('account');
    prefs.remove('password');
  }
}
