import 'package:mvvm_architecture/Data/Network/BaseApiServices.dart';
import 'package:mvvm_architecture/Data/Network/NetworkApiServices.dart';
import 'package:mvvm_architecture/Res/app_url.dart';

class AuthRepository{
 BaseApiServices _apiServices = NetworkApiService();
 Future<dynamic> loginApi(dynamic data)async{
   try{
    dynamic response = await _apiServices.getPostApiResponse(AppUrl.loginUrl, data);
    return response;
   }catch(e){
    throw e;
   }
 }
 Future<dynamic> regiterApi(dynamic data)async{
  try{
   dynamic response = await _apiServices.getPostApiResponse(AppUrl.registerUrl, data);
   return response;
  }catch(e){
   throw e;
  }
 }
}