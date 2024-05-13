import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mvvm_architecture/Res/colors.dart';
import 'package:mvvm_architecture/Utils/Routes/routes_name.dart';
import 'package:mvvm_architecture/Utils/utils.dart';
import 'package:mvvm_architecture/View/user_view_model.dart';
import 'package:mvvm_architecture/ViewModel/home_view_model.dart';
import 'package:provider/provider.dart';

import '../Data/Response/status.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeViewViewModel homeViewViewModel = HomeViewViewModel();
  @override
  void initState() {
    // TODO: implement initState
    homeViewViewModel.fetchMoviesList();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final userPreferences = Provider.of<UserViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: InkWell(
          onTap: (){
            userPreferences.removeUser().then((value){
              Navigator.pushNamed(context, RoutesName.login);
            });
          },
          child: Text('Log out',style: GoogleFonts.nunito(
              fontSize: 25,
              fontWeight: FontWeight.w900,
              color: AppColors.greenColor
          ),),
        ),
        automaticallyImplyLeading: false,
      ),
      body: ChangeNotifierProvider<HomeViewViewModel>(
        create: (BuildContext context) =>homeViewViewModel,
        child: Consumer<HomeViewViewModel>(
          builder: (context,value,_){
            switch(value.moviesList.status){
              case Status.LOADING:
                return Center(child: CircularProgressIndicator());
              case Status.ERROR:
                return Center(child: Text(value.moviesList.message.toString()));
              case Status.COMPLETED:
                return ListView.builder(
                    itemCount:value.moviesList.data!.movies!.length,
                    itemBuilder: (context,index){
                  return Card(
                    child: ListTile(
                      leading: Image.network(value.moviesList.data!.movies![index].posterurl.toString(),
                      errorBuilder: (context,error,stack){
                        return Icon(Icons.error,color: Colors.red,);
                      },
                        height: 40,
                        width: 40,
                        fit: BoxFit.cover,
                      ),
                      title: Text(value.moviesList.data!.movies![index].title.toString()),
                      subtitle: Text(value.moviesList.data!.movies![index].year.toString()),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text((Utils.averageRating(value.moviesList.data!.movies![index].ratings!)).toString()),
                          Icon(Icons.star,color: Colors.yellow,)
                        ],
                      ),
                    ),
                  );
                });

              case null:
                // TODO: Handle this case.
            }
            return Container(

            );
          },
        ),
      )
    );
  }
}
