import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:insta_clone/resources/authMethods.dart';
import 'package:insta_clone/utils/utils.dart';
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
  Uint8List? _image;
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    bioController.dispose();
    usernameController.dispose();
  }

  void selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }

  void signUpUser()async{
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().signUpUser(
        email: _emailController.text,
        password: _passwordController.text,
        username: usernameController.text,
        bio: bioController.text,
        file: _image!
    );
    setState(() {
      _isLoading = false;
    });
    if(res!='success'){
      showSnackBar(res, context);
    }
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
              Flexible(
                child: Container(),
                flex: 2,
              ),
              // svg image
              SvgPicture.asset(
                'assets/images/ic_instagram.svg',
                height: 60,
                color: Colors.white,
              ),
              SizedBox(
                height: 10,
              ),
              //circular avatar widget
              Stack(
                children: [
                  _image != null
                      ? CircleAvatar(
                          radius: 60,
                          backgroundImage: MemoryImage(_image!),
                        )
                      : const CircleAvatar(
                          radius: 60,
                          backgroundImage: NetworkImage(
                              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQWo3luud5KPZknLR5zdUUwzvYBztWgTxrkbA&usqp=CAU'),
                        ),
                  Positioned(
                      bottom: -15,
                      left: 75,
                      child: IconButton(
                        onPressed: selectImage,
                        icon: Icon(Icons.add_a_photo),
                        color: Colors.grey,
                      ))
                ],
              ),
              //text field for username
              SizedBox(
                height: 40,
              ),
              TextFieldInput(
                  textEditingController: usernameController,
                  hintText: 'Enter Your Username',
                  textInputType: TextInputType.text),
              //Text field for email
              SizedBox(
                height: 20,
              ),
              TextFieldInput(
                  textEditingController: _emailController,
                  hintText: 'Enter Your Email',
                  textInputType: TextInputType.emailAddress),
              //text field for password
              SizedBox(
                height: 20,
              ),
              TextFieldInput(
                textEditingController: _passwordController,
                hintText: 'Enter your password',
                textInputType: TextInputType.text,
                isPass: true,
              ),
              //bio field input
              SizedBox(
                height: 20,
              ),
              TextFieldInput(
                  textEditingController: bioController,
                  hintText: 'Describe Yourself',
                  textInputType: TextInputType.text),
              //button for login
              SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: signUpUser,
                child: Container(
                  child: _isLoading? Center(
                    child: CircularProgressIndicator(color: Colors.white),
                  )
                  : const Text(
                    'Log in',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  width: 150,
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(vertical: 12),
                  decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                      ),
                      color: Colors.blueAccent),
                ),
              ),
              SizedBox(
                height: 12,
              ),
              Flexible(
                child: Container(),
                flex: 2,
              ),
              //Transitioning to sign up!
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: Text('Do not have an account? '),
                    padding: EdgeInsets.symmetric(vertical: 8),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      child: Text(
                        'Sign up!',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
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
