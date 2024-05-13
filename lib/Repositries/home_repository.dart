import 'package:mvvm_architecture/Model/MoviesListModel.dart';

import '../Data/Network/BaseApiServices.dart';
import '../Data/Network/NetworkApiServices.dart';
import '../Res/app_url.dart';

class HomeRepository{
  BaseApiServices _apiServices = NetworkApiService();
  Future<MoviesListModel> fetchMovieslist()async{
    try{
      dynamic response = await _apiServices.getGetApiResponse(AppUrl.moviesUrl);
      return response = MoviesListModel.fromJson(response);
    }catch(e){
      throw e;
    }
  }
}