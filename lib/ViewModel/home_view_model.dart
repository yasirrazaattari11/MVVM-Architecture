import 'package:flutter/cupertino.dart';
import 'package:mvvm_architecture/Data/Response/api_response.dart';
import 'package:mvvm_architecture/Model/MoviesListModel.dart';
import 'package:mvvm_architecture/Repositries/home_repository.dart';

class HomeViewViewModel with ChangeNotifier{
   final _myrepo = HomeRepository();
   ApiResponse<MoviesListModel> moviesList= ApiResponse.loading();
   setMoviesList(ApiResponse<MoviesListModel> response){
     moviesList = response;
     notifyListeners();
   }
   Future<void> fetchMoviesList()async{
     setMoviesList(ApiResponse.loading());
     _myrepo.fetchMovieslist().then((value){
       setMoviesList(ApiResponse.completed(value));
     }).onError((error, stackTrace){
       setMoviesList(ApiResponse.error(error.toString()));
     });
   }
}