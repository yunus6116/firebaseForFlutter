import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import '../model/user.dart';

class FirebaseService {
  static const String FIREBASE_URL = "https://ykdemo-6e6b5.firebaseio.com/";

  Future<List<User>> getUsers() async {
    final response = await http.get("$FIREBASE_URL/users.json");

    switch (response.statusCode) {
      case HttpStatus.ok:
        final jsonModel = json.decode(response.body);
        final userList = jsonModel
            .map((e) => User.fromJson(e as Map<String, dynamic>))
            .toList()
            .cast<User>();
        return userList;

      default:
        return Future.error(response.statusCode);
    }
  }
}
