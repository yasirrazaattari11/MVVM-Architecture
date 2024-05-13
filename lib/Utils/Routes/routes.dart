import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvvm_architecture/Utils/Routes/routes_name.dart';
import 'package:mvvm_architecture/View/home_screen.dart';
import 'package:mvvm_architecture/View/login_view.dart';
import 'package:mvvm_architecture/View/signup_view.dart';
import 'package:mvvm_architecture/View/splash_view.dart';
class Routes{
  static Route<dynamic> generateRoute(RouteSettings settings){
    switch (settings.name){
      case RoutesName.splash:
        return MaterialPageRoute(builder: (BuildContext context) => SplashView());
      case RoutesName.home:
        return MaterialPageRoute(builder: (BuildContext context) => HomeScreen());
      case RoutesName.login:
        return MaterialPageRoute(builder: (BuildContext context) => LoginView());
      case RoutesName.signup:
        return MaterialPageRoute(builder: (BuildContext context) => SignupView());
      default:
        return MaterialPageRoute(builder: (_){
          return Scaffold(
            body: Center(child: Text('No route defined'),),
          );
        });

    }
  }
}