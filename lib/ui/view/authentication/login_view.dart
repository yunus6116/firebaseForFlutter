import 'package:firebasedemo/core/model/user/user_auth_error.dart';
import 'package:firebasedemo/core/model/user/user_request.dart';
import 'package:firebasedemo/core/services/firebase_service.dart';
import 'package:firebasedemo/ui/view/home/fire_home_view.dart';
import 'package:flutter/material.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  String username;
  String password;

  FirebaseService service = FirebaseService();

  GlobalKey<ScaffoldState> scaffold = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffold,
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              onChanged: (value) {
                setState(() {
                  username = value;
                });
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Username',
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              onChanged: (value) {
                setState(() {
                  password = value;
                });
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Password',
              ),
            ),
            SizedBox(
              height: 10,
            ),
            FloatingActionButton.extended(
              onPressed: () async {
                var result = await service.postUser(UserRequest(
                  email: username,
                  returnSecureToken: true,
                  password: password,
                ));
                if (result is FirebaseAuthError) {
                  var error = result.error.message;
                  scaffold.currentState.showSnackBar(
                    SnackBar(
                      content: Text(error),
                    ),
                  );
                } else {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => FireHomeView()),
                  );
                }
              },
              label: Text("Login"),
              icon: Icon(Icons.android),
            ),
          ],
        ),
      ),
    );
  }
}
