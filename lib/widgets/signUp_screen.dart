import 'package:flutter/material.dart';
import 'package:insta_clone/widgets/textFieldInput.dart';
import 'package:flutter_svg/flutter_svg.dart';

class signUpScreen extends StatefulWidget {
  const signUpScreen({Key? key}) : super(key: key);

  @override
  State<signUpScreen> createState() => _signUpScreenState();
}

class _signUpScreenState extends State<signUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController bioController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    bioController.dispose();
    usernameController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 32, vertical: 15),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(child: Container(), flex: 2,),
              // svg image
              SvgPicture.asset('assets/images/ic_instagram.svg',height: 60,
                color: Colors.white,),
              SizedBox(height: 10,),
              //circular avatar widget
              Stack(
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundImage: NetworkImage('https://images.unsplash.com/photo-1691162534642-eb3779a8c231?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHx0b3BpYy1mZWVkfDE0fHRvd0paRnNrcEdnfHxlbnwwfHx8fHw%3D&auto=format&fit=crop&w=600&q=60'),
                  ),
                      Positioned(
                          bottom: -15,
                          left: 75,
                          child: IconButton(
                        onPressed: (){},
                        icon: Icon(Icons.add_a_photo),
                            color: Colors.grey,
                      ))
                ],
              ),
              //text field for username
              SizedBox(height: 40,),
              TextFieldInput(
                  textEditingController: _emailController,
                  hintText: 'Enter Your Email',
                  textInputType: TextInputType.emailAddress),
              //Text field for email
              SizedBox(height: 20,),
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
              //bio field input
              SizedBox(height: 20,),
              TextFieldInput(
                  textEditingController: bioController,
                  hintText: 'Describe Yourself',
                  textInputType: TextInputType.text),
              //button for login
              SizedBox(height: 20,),
              InkWell(
                child: Container(
                  child: Text('Log in', style: TextStyle(
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
                    onTap: (){},
                    child: Container(
                      child: Text('Sign up!', style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),),
                      padding: EdgeInsets.symmetric(vertical: 5),
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

