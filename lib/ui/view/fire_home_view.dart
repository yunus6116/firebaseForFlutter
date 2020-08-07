import 'package:firebasedemo/core/services/firebase_service.dart';
import 'package:flutter/material.dart';
import '../../core/model/user.dart';

class FireHomeView extends StatefulWidget {
  @override
  _FireHomeViewState createState() => _FireHomeViewState();
}

class _FireHomeViewState extends State<FireHomeView> {
  FirebaseService service;

  @override
  void initState() {
    super.initState();
    service = FirebaseService();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder<List<User>>(
        future: service.getUsers(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              if (snapshot.hasData) {
                return _listUser(snapshot.data);
              } else {
                return _notFoundWidget;
              }
              break;
            default:
              return _waitingWidget;
          }
        },
      ),
    );
  }

  Widget _listUser(List<User> list) {
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (context, index) => _userCard(list[index]),
    );
  }

  Widget _userCard(User user) {
    return Card(
      child: ListTile(
        title: Text(user.name),
      ),
    );
  }

  Widget get _notFoundWidget => Center(
        child: Text('Not Found'),
      );
  Widget get _waitingWidget => Center(child: CircularProgressIndicator());
}
