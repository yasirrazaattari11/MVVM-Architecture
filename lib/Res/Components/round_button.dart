import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mvvm_architecture/Res/colors.dart';
class RoundButton extends StatelessWidget {
  final String title;
  final bool loading;
  final VoidCallback onPress;
  const RoundButton({required this.title,this.loading = false,required this.onPress});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        height: 40,
        width: 200,
        decoration: BoxDecoration(
          color: AppColors.greenColor,
          borderRadius: BorderRadius.circular(20)
        ),
        child: Center(
          child:  loading == true? CircularProgressIndicator(color: AppColors.whiteColor,):Text(title,style: GoogleFonts.nunito(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: AppColors.whiteColor
          ),),
        ),
      ),
      onTap: onPress,
    );
  }
}
