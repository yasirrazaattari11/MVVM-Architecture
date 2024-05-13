import 'package:flutter/material.dart';
import 'package:mvvm_architecture/Utils/Routes/routes_name.dart';
import 'package:mvvm_architecture/View/login_view.dart';
import 'package:mvvm_architecture/View/user_view_model.dart';
import 'package:mvvm_architecture/ViewModel/auth_view_model.dart';
import 'package:provider/provider.dart';

import 'Utils/Routes/routes.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (_)=> AuthViewModel()),
    ChangeNotifierProvider(create: (_)=> UserViewModel())
    ],child: MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: RoutesName.splash,
      onGenerateRoute: Routes.generateRoute,),);
  }
}
