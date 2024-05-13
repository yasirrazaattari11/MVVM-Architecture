import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:mvvm_architecture/Model/user_model.dart';
import 'package:mvvm_architecture/Repositries/auth_repository.dart';
import 'package:mvvm_architecture/Utils/Routes/routes_name.dart';
import 'package:mvvm_architecture/Utils/utils.dart';
import 'package:mvvm_architecture/View/user_view_model.dart';
import 'package:provider/provider.dart';

class AuthViewModel with ChangeNotifier{
  final _myRepo = AuthRepository();
  bool _loading = false;
  bool _signupLoading = false;
  bool get loading => _loading;
  bool get signupLoading => _signupLoading;
  setLoading(bool value){
    _loading = value;
    notifyListeners();
  }
  setsignupLoading(bool value){
    _signupLoading = value;
    notifyListeners();
  }
  Future<void> loginApi(dynamic data,BuildContext context) async{
    setLoading(true);
    _myRepo.loginApi(data).then((value) {
      setLoading(false);
      final userPreferences = Provider.of<UserViewModel>(context,listen: false);
      userPreferences.saveUser(UserModel(
        token: value['token'].toString()
      ));
      Utils.flushbarErrorMessage('Login Successfully', context);
      Navigator.pushNamed(context, RoutesName.home);
      if(kDebugMode){
        print(value.toString());
      }
    }).onError((error, stackTrace){
      setLoading(false);
      if(kDebugMode){
        Utils.flushbarErrorMessage(error.toString(), context);
        print(error.toString());
      }
    });
  }
  Future<void> registerApi(dynamic data,BuildContext context) async{
    setsignupLoading(true);
    _myRepo.regiterApi(data).then((value) {
      setsignupLoading(false);
      Utils.flushbarErrorMessage('Registered Successfully', context);
      Navigator.pushNamed(context, RoutesName.home);
      if(kDebugMode){
        print(value.toString());
      }
    }).onError((error, stackTrace){
      setsignupLoading(false);
      if(kDebugMode){
        Utils.flushbarErrorMessage(error.toString(), context);
        print(error.toString());
      }
    });
  }
}