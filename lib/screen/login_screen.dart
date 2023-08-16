import 'package:flutter/material.dart';
import 'package:insta_clone/widgets/textFieldInput.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
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
      Flexible(child: Container(), flex: 2,),
    SizedBox(height: 40,),
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
      SizedBox(height: 20,),
      Container(
        child: Text('Log in'),
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
          Container(
            child: Text('Sign up!', style: TextStyle(
              fontWeight: FontWeight.bold,
            ),),
            padding: EdgeInsets.symmetric(vertical: 8),
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
