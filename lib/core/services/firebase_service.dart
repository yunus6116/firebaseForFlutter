import 'dart:convert';
import 'dart:io';

import 'package:firebasedemo/core/model/student.dart';
import 'package:firebasedemo/core/model/user/user_auth_error.dart';
import 'package:firebasedemo/core/model/user/user_request.dart';
import 'package:http/http.dart' as http;
import '../model/user.dart';

class FirebaseService {
  static const String FIREBASE_URL = "https://ykdemo-6e6b5.firebaseio.com/";
  static const String FIREBASE_AUTH_URL =
      "https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyAb_w2CmURUJ4xaRgLpa0aA9NbemX2qkwk";

  // Post User
  Future postUser(UserRequest request) async {
    var jsonModel = json.encode(request.toJson());
    final response = await http.post(FIREBASE_AUTH_URL, body: jsonModel);

    switch (response.statusCode) {
      case HttpStatus.ok:
        return true;

      default:
        var errorJson = json.decode(response.body);
        var error = FirebaseAuthError.fromJson(errorJson);
        return error;
    }
  }

  // User'ları çek
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

  // Student'ları çek
  Future<List<Student>> getStudents() async {
    final response = await http.get("$FIREBASE_URL/students.json");

    switch (response.statusCode) {
      case HttpStatus.ok:
        final jsonModel = json.decode(response.body) as Map;
        final studentList = List<Student>();

        jsonModel.forEach((key, value) {
          Student student = Student.fromJson(value);
          student.key = key;
          studentList.add(student);
        });
        return studentList;

      default:
        return Future.error(response.statusCode);
    }
  }
}
