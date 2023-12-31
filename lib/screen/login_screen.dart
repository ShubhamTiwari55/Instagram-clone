import 'package:flutter/material.dart';
import 'package:insta_clone/resources/authMethods.dart';
import 'package:insta_clone/utils/utils.dart';
import 'package:insta_clone/widgets/signUp_screen.dart';
import 'package:insta_clone/widgets/textFieldInput.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../responsive/layout_screen.dart';
import '../responsive/mobileScreenLayout.dart';
import '../responsive/webScreenLayout.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void loginUser()async{
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().loginUser(
        email: _emailController.text,
        password: _passwordController.text
    );
    if(res == "Success"){
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context)=>
          const ResponsiveLayout(webScreenLayout: WebScreenLayout(),
            mobileScreenLayout: MobileScreenLayout(),),)
      );
    }else{
      showSnackBar(res, context);
    }
    setState(() {
      _isLoading = false;
    });
  }

  void navigateToSignUp(){
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context)=>const signUpScreen(),
    ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
        child: Container(
        padding: EdgeInsets.symmetric(horizontal: 32, vertical: 20),
    width: double.infinity,
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Flexible(flex: 2,child: Container(),),
    // svg image
    SvgPicture.asset('assets/images/ic_instagram.svg',height: 64,
    color: Colors.white,),
    //text field for username
    SizedBox(height: 40,),
      TextFieldInput(
          textEditingController: _emailController,
          hintText: 'Enter Your Email',
          textInputType: TextInputType.emailAddress),
      //text field for password
      SizedBox(height: 20,),
      TextFieldInput(textEditingController: _passwordController,
          hintText: 'Enter your password',
          textInputType: TextInputType.text,
        isPass: true,
      ),
      //button for login
      SizedBox(height: 20,),
      InkWell(
        onTap: loginUser,
        child: Container(
          child: _isLoading? Center(
            child: CircularProgressIndicator(
              color: Colors.white,
            ),
          ):
          const Text('Log in', style: TextStyle(
            fontSize: 18,
          ),),
          width: 150,
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(vertical: 12),
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(4)),
            ),
            color: Colors.blueAccent
          ),
        ),
      ),
      SizedBox(height: 12,),
      Flexible(child: Container(), flex: 2,),
      //Transitioning to sign up!
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
                Container(
                child: Text('Do not have an account? '),
                padding: EdgeInsets.symmetric(vertical: 8),
              ),
          GestureDetector(
            onTap: navigateToSignUp,
            child: Container(
              child: Text('Sign up!', style: TextStyle(
                fontWeight: FontWeight.bold,
              ),),
              padding: EdgeInsets.symmetric(vertical: 8),
            ),
          )
        ],
      ),
    ],
    ),
    ),
        ),
    );
  }
}
