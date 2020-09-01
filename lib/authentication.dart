import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import 'exception.dart';

class Authenticate with ChangeNotifier {
  Future<void> SignUp(String email, String password) async {
    const url =
        'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyDU8kBPgd-BjQ47PuG5CftgeVuxjfpvjjg';
    try {
      final responce = await http.post(
        url,
        body: jsonEncode(
          {
            'email': email,
            'password': password,
            'returnSecureToken': true,
          },
        ),
      );
      final responsedata = json.decode(responce.body);
      if (responsedata['error'] != null) {
        throw Http_Exception(responsedata['error']['message']);
      }
      // print(responsedata);
    } catch (error) {
      throw error;
    }
  }

  Future<void> LogIn(String email, String password) async {
    const url =
        'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyDU8kBPgd-BjQ47PuG5CftgeVuxjfpvjjg';
    try {
      final responce = await http.post(
        url,
        body: jsonEncode(
          {
            'email': email,
            'password': password,
            'returnSecureToken': true,
          },
        ),
      );
      final responsedata = json.decode(responce.body);
      if (responsedata['error'] != null) {
        throw Http_Exception(responsedata['error']['message']);
      }
      //  print(responsedata);
    } catch (error) {
      throw error;
    }
  }
}
