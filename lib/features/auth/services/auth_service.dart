import 'dart:convert';

import 'package:amazon_clone/constants/error_handling.dart';
import 'package:amazon_clone/constants/global_var.dart';
import 'package:amazon_clone/constants/utils.dart';
import 'package:amazon_clone/home/screens/home_screen.dart';
import 'package:amazon_clone/models/user.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  ///Sign-Up User
  void signUpUser(
      {required String email,
      required String password,
      required BuildContext context,
      required String name}) async {
    try {
      User user = User(
          id: '',
          name: name,
          email: email,
          password: password,
          address: '',
          token: '',
          type: '');
      http.Response res = await http.post(Uri.parse("$uri/api/signup"),
          body: user.toJson(),
          headers: <String, String>{
            'Content-Type': 'application/json;charset=UTF-8'
          });
      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            showSnackBar(
                context, 'Account created! Login with the same credentials!');
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void signInUser({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      http.Response res = await http.post(Uri.parse("$uri/api/signin"),
          body: jsonEncode({
            "email": email,
            "password": password,
          }),
          headers: <String, String>{
            'Content-Type': 'application/json;charset=UTF-8'
          });
      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            Provider.of<UserProvider>(context, listen: false).setUser(res.body);
            await prefs.setString(
                'x-auth-token', jsonDecode(res.body)['token']);
            Navigator.pushNamedAndRemoveUntil(
                context, HomeScreen.routeName, (route) => false);
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  ///Get User Data
  void getUserData(BuildContext context) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');

      if (token == null) {
        prefs.setString('x-auth-token', '');
      }
      var tokenRes = await http
          .post(Uri.parse("$uri/tokenIsValid"), headers: <String, String>{
        'Content-Type': 'application/json;charset=UTF-8',
        'x-auth-token': token!,
      });

      var response = jsonDecode(tokenRes.body);

      if(response == true){
       http.Response userRes =  await http.get(Uri.parse("$uri/"),
           headers: <String, String>{
             'Content-Type': 'application/json;charset=UTF-8',
             'x-auth-token': token,
           }
        );

       var userProvider = Provider.of<UserProvider>(context,listen: false);
       userProvider.setUser(userRes.body);
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
