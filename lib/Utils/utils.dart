import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_route.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Utils {
  static double averageRating(List<num> ratings){
    num avgRating = 0;
    for(int i=0;i<ratings.length;i++){
      avgRating = avgRating + ratings[i];
    }
    return double.parse((avgRating/ratings.length).toStringAsFixed(1));
  }
  static void fieldFocus(BuildContext context,FocusNode current, FocusNode next){
    current.unfocus();
    FocusScope.of(context).requestFocus(next);

  }
  static toastMessage(String message) {
    Fluttertoast.showToast(
        msg: message,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        toastLength: Toast.LENGTH_LONG);
  }

  static void flushbarErrorMessage(String message, BuildContext context) {
    showFlushbar(
        context: context,
        flushbar: Flushbar(
          message: message,
          forwardAnimationCurve: Curves.decelerate,
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          padding: EdgeInsets.all(20),
          titleColor: Colors.white,
          duration: Duration(seconds: 3),
          borderRadius: BorderRadius.circular(20),
          reverseAnimationCurve: Curves.easeInOut,
          flushbarPosition: FlushbarPosition.TOP,
          icon: Icon(
            Icons.error,
            size: 28,
            color: Colors.white,
          ),
          positionOffset: 20,
        )..show(context));
  }

  static snakbar(String message, BuildContext context) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.black,
      ),
    );
  }
}
