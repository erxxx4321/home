import 'package:flutter/material.dart';
import 'package:home/screens/home_screen.dart';
import 'package:home/widgets/input.dart';
import 'package:home/widgets/button.dart';
import 'package:home/services/app_theme.dart';
import 'package:home/providers/auth_provider.dart';
import 'package:provider/provider.dart';
import 'account_screen.dart';
import 'package:home/models/user.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  String _account = "", _password = "";

  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    AuthProvider auth = Provider.of<AuthProvider>(context);

    void doLogin() {
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
                          child: Text("登入中...")),
                    ],
                  ),
                ));
        var response = auth.login(_account, _password);

        response.then((res) {
          if (res['success']) {
            showDialog(
                context: context,
                builder: (context) => SimpleDialog(title: Text('登入成功')));
            Future.delayed(const Duration(milliseconds: 3), () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()));
            });
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('登入失敗，${res["message"]}')));
          }
        });
      }
    }

    return SafeArea(
        child: Scaffold(
            body: SingleChildScrollView(
                padding: EdgeInsets.all(40.0),
                child: Form(
                  key: formKey,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('登入'),
                        Container(
                            margin: EdgeInsets.only(top: 15.0),
                            child: TextFormField(
                                decoration:
                                    buildInputDecoration('輸入帳號', Icons.person),
                                validator: (value) =>
                                    value!.isEmpty ? "請輸入帳號" : null,
                                onSaved: (value) => _account = value!)),
                        Container(
                            margin: EdgeInsets.only(top: 15.0),
                            child: TextFormField(
                                decoration: buildInputDecoration(
                                    '輸入密碼', Icons.password),
                                validator: (value) =>
                                    value!.isEmpty ? "請輸入密碼" : null,
                                onSaved: (value) => _password = value!)),
                        Container(
                            margin: EdgeInsets.only(top: 15.0),
                            child: longButtons(
                                '登入', doLogin, AppTheme.primaryColor)),
                        TextButton(
                            child: Text('註冊',
                                style: TextStyle(
                                    color: AppTheme.primaryColorDark,
                                    fontSize: 16)),
                            onPressed: () {
                              Navigator.pushNamed(context, '/register');
                            })
                      ]),
                ))));
  }
}
