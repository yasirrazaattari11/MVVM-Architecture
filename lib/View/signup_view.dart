import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mvvm_architecture/Utils/Routes/routes_name.dart';
import 'package:provider/provider.dart';

import '../Res/Components/round_button.dart';
import '../Res/colors.dart';
import '../Utils/utils.dart';
import '../ViewModel/auth_view_model.dart';
class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  ValueNotifier<bool> _obscurePassword = ValueNotifier<bool>(true);
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  FocusNode emailNode = FocusNode();
  FocusNode passwordNode = FocusNode();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    emailNode.dispose();
    passwordNode.dispose();
    _obscurePassword.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);
    final height = MediaQuery.of(context).size.height *1;
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextFormField(
                controller: _emailController,
                textAlign: TextAlign.start,
                textInputAction: TextInputAction.none,
                obscureText: false,
                focusNode: emailNode,
                autofocus: false,
                style: GoogleFonts.poppins(fontSize: 15),
                keyboardType: TextInputType.emailAddress,
                textAlignVertical: TextAlignVertical.center,
                onFieldSubmitted: (value){
                  Utils.fieldFocus(context, emailNode, passwordNode);
                },
                decoration: InputDecoration(
                  fillColor: Colors.grey.withOpacity(0.2),
                  filled: true,
                  prefixIcon: Icon(Icons.alternate_email),
                  prefixIconColor: Colors.grey,
                  hintText: 'Email',
                  hintStyle: GoogleFonts.poppins(
                      fontSize: 15, color: Colors.grey),
                  helperText: 'e.g john@gmail.com',
                  helperStyle: GoogleFonts.poppins(
                      fontSize: 12, color: Colors.grey),
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(30)),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Enter Email';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10,),
              ValueListenableBuilder(valueListenable: _obscurePassword, builder: (context, value, child){
                return TextFormField(
                  controller: _passwordController,
                  textAlign: TextAlign.start,
                  textInputAction: TextInputAction.none,
                  obscureText: _obscurePassword.value,
                  autofocus: false,
                  obscuringCharacter: '*',
                  style: GoogleFonts.poppins(fontSize: 15),
                  keyboardType: TextInputType.text,
                  focusNode: passwordNode,
                  textAlignVertical: TextAlignVertical.center,
                  decoration: InputDecoration(
                    suffixIcon: InkWell(child: Icon(_obscurePassword == true?Icons.visibility_off:Icons.visibility),onTap: (){
                      _obscurePassword.value = !_obscurePassword.value;
                    },),
                    suffixIconColor: Colors.grey,
                    fillColor: Colors.grey.withOpacity(0.2),
                    filled: true,
                    prefixIcon: Icon(Icons.lock_outline),
                    prefixIconColor: Colors.grey,
                    hintText: 'Password',
                    hintStyle: GoogleFonts.poppins(
                        fontSize: 15, color: Colors.grey),
                    helperText: 'must be 6 digits at least',
                    helperStyle: GoogleFonts.poppins(
                        fontSize: 12, color: Colors.grey),
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(30)),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter Password';
                    }
                    return null;
                  },
                );
              }),
              SizedBox(height: height * 0.085,),
              RoundButton(title: 'SIGN UP',loading: authViewModel.signupLoading ,onPress: (){
                if(_emailController.text.isEmpty){
                  Utils.flushbarErrorMessage('Please Enter Email', context);
                }else if(_passwordController.text.isEmpty){
                  Utils.flushbarErrorMessage('Please Enter Password', context);
                }else if(_passwordController.text.length<6){
                  Utils.flushbarErrorMessage('Please Enter 6 Digit Password', context);
                }else{
                  Map data = {
                    'email':_emailController.text.toString(),
                    'password':_passwordController.text.toString()
                  };
                  authViewModel.registerApi(data, context);
                }
              }),
              SizedBox(height: height * 0.02,),
              Row(
                children: [Text("Already Have an Account?",style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: AppColors.blackColor
                ),),
                  InkWell(
                    onTap: (){
                      Navigator.pushNamed(context, RoutesName.login);
                    },
                    child: Text(" SIGN IN",style: GoogleFonts.poppins(
                        fontSize: 19,
                        fontWeight: FontWeight.w800,
                        color: AppColors.greenColor
                    ),),
                  )],
              )
            ],
          ),
        ),
      ),
    );
  }
}
