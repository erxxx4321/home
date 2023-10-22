import 'package:flutter/material.dart';
import 'package:home/models/user.dart';
import 'package:home/providers/auth_provider.dart';
import 'package:home/widgets/button.dart';
import 'package:home/services/app_theme.dart';
import 'package:home/services/validator.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatelessWidget {
  final formKey = GlobalKey<FormState>();
  String _name = "", _email = "", _account = "", _password = "";

  @override
  Widget build(BuildContext context) {
    AuthProvider auth = Provider.of<AuthProvider>(context);

    void doRegister() {
      final form = formKey.currentState;
      if (form!.validate()) {
        form.save();

        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  content: Row(
                    children: [
                      const CircularProgressIndicator(),
                      Container(
                          margin: EdgeInsets.only(left: 7),
                          child: Text("送出中...")),
                    ],
                  ),
                ));

        User user = User(
            name: _name,
            email: _email,
            account: _account,
            password: _password,
            createdAt: DateTime.now().toString());

        var response = auth.register(user);
        response.then((res) {
          if (res['success']) {
            showDialog(
                context: context,
                builder: (context) => SimpleDialog(title: Text('註冊成功')));
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('註冊失敗，${res["message"]}')));
          }
        });
      }
    }

    return Scaffold(
        appBar: AppBar(title: Text("註冊")),
        body: SingleChildScrollView(
            padding: EdgeInsets.all(10.0),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(labelText: "名稱"),
                    onSaved: (newValue) => _name = newValue!,
                  ),
                  TextFormField(
                    validator: (value) => validateEmail(value ?? ""),
                    decoration: InputDecoration(labelText: "Email"),
                    onSaved: (newValue) => _email = newValue!,
                  ),
                  TextFormField(
                    validator: (value) => value!.isEmpty ? "請輸入帳號" : null,
                    decoration: InputDecoration(labelText: "帳號"),
                    onSaved: (newValue) => _account = newValue!,
                  ),
                  TextFormField(
                    validator: (value) => value!.isEmpty ? "請輸入密碼" : null,
                    decoration: InputDecoration(labelText: "密碼"),
                    onSaved: (newValue) => _password = newValue!,
                  ),
                  longButtons('送出', doRegister, AppTheme.primaryColor)
                ],
              ),
            )));
  }
}
