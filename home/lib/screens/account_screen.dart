import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:home/providers/auth_provider.dart';
import 'package:home/services/shared_preference.dart';
import 'package:home/models/user.dart';
import 'package:home/services/app_theme.dart';
import 'package:home/screens/home_screen.dart';
import 'package:provider/provider.dart';
import 'login_screen.dart';
import 'package:home/widgets/button.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  Widget build(BuildContext context) {
    Future<User> getUser() => UserPreferences().getUser();

    void initState() {
      super.initState();
    }

    void doLogout() {
      UserPreferences().removeUser();
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                content: Text('確定登出?'),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('取消')),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HomeScreen()));
                      },
                      child: Text('確定'))
                ],
              ));
    }

    return MultiProvider(
        providers: [ChangeNotifierProvider(create: (_) => AuthProvider())],
        child: Container(
            child: FutureBuilder(
                future: getUser(),
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                    case ConnectionState.waiting:
                      return CircularProgressIndicator();
                    default:
                      if (snapshot.hasError)
                        return Text('Error: ${snapshot.error}');
                      else if (snapshot.data?.uid == "")
                        return LoginScreen();
                      else
                        return Container(
                          padding: EdgeInsets.all(10.0),
                          decoration: BoxDecoration(color: Colors.white),
                          child: Table(
                            children: [
                              TableRow(children: [
                                Text('名稱'),
                                Text('${snapshot.data?.name}'),
                              ]),
                              TableRow(children: [
                                Text('信箱'),
                                Text('${snapshot.data?.email}')
                              ]),
                              TableRow(children: [
                                Text('建立日期'),
                                Text('${snapshot.data?.createdAt}')
                              ]),
                              TableRow(children: [
                                Container(
                                  margin: EdgeInsets.only(top: 20.0),
                                  child: longButtons('登出', doLogout,
                                      AppTheme.primaryColorLight),
                                ),
                                Text('')
                              ])
                            ],
                          ),
                        );
                  }
                })));
  }
}
