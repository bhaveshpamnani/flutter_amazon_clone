import 'package:amazon_clone/features/auth/screens/auth_screen.dart';
import 'package:amazon_clone/home/screens/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Route<dynamic> genrateRoute(RouteSettings routeSettings){
  switch(routeSettings.name){
    case AuthScreen.routeName:
      return MaterialPageRoute(builder: (context) => const AuthScreen(),);
    case HomeScreen.routeName:
      return MaterialPageRoute(builder: (context) => const HomeScreen(),);
    default :
      return MaterialPageRoute(builder: (context) => Scaffold(
        body: Center(
          child: Text('Page not Found'),
        ),
      ),);
  }
}