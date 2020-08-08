import 'package:firebasedemo/core/model/user/user_auth_error.dart';
import 'package:firebasedemo/core/model/user/user_request.dart';
import 'package:firebasedemo/core/services/firebase_service.dart';
import 'package:firebasedemo/core/services/google_signin.dart';
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
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.exit_to_app),
        onPressed: () async {
          await GoogleSignHelper.instance.signOut();
        },
      ),
      key: scaffold,
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            usernameTextField(),
            emptySizedBox(),
            passwordTextField(),
            emptySizedBox(),
            Wrap(
              spacing: 10,
              children: <Widget>[
                FloatingActionButton.extended(
                  backgroundColor: Colors.green,
                  label: Text('Google Login'),
                  icon: Icon(Icons.outlined_flag),
                  onPressed: () async {
                    var data = await GoogleSignHelper.instance.signIn();
                    if (data != null) {
                      var userData =
                          await GoogleSignHelper.instance.firebaseSignin();
                      // print(userData.accessToken);
                      // print(userData.idToken);
                    }
                  },
                ),
                customLoginFAButton(context),
              ],
            ),
          ],
        ),
      ),
    );
  }

  SizedBox emptySizedBox() {
    return SizedBox(
      height: 10,
    );
  }

  FloatingActionButton customLoginFAButton(BuildContext context) {
    return FloatingActionButton.extended(
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
    );
  }

  TextField passwordTextField() {
    return TextField(
      onChanged: (value) {
        setState(() {
          password = value;
        });
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Password',
      ),
    );
  }

  TextField usernameTextField() {
    return TextField(
      onChanged: (value) {
        setState(() {
          username = value;
        });
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Username',
      ),
    );
  }
}
