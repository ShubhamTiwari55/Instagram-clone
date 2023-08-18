import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:insta_clone/providers/userProvider.dart';
import 'package:insta_clone/responsive/layout_screen.dart';
import 'package:insta_clone/responsive/mobileScreenLayout.dart';
import 'package:insta_clone/responsive/webScreenLayout.dart';
import 'package:insta_clone/screen/login_screen.dart';
import 'package:insta_clone/widgets/signUp_screen.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  if(kIsWeb){
    await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyBiCnjI7zlNj25fjOpoltnFtFvXS3aSm80",
          appId: "1:103878985706:web:c0c8c387d906f2effc5493",
          messagingSenderId: "103878985706",
          projectId: "insta-clone-d4884",
          storageBucket: "insta-clone-d4884.appspot.com"
      )
    );
  }
  else{
    await Firebase.initializeApp();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)=> UserProvider(),
        )
      ],
      child: MaterialApp(
        title: 'Insta clone',
        theme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: Colors.black,
        ),
          // home: ResponsiveLayout(webScreenLayout: WebScreenLayout(), mobileScreenLayout: MobileScreenLayout())
          home: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot){
              if(snapshot.connectionState == ConnectionState.active){
                if(snapshot.hasData){
                  return const ResponsiveLayout(
                      webScreenLayout: WebScreenLayout(),
                      mobileScreenLayout: MobileScreenLayout(),
                  );
                }else if(snapshot.hasError){
                  return Center(
                    child: Text('${snapshot.error}'),
                  );
                }
              }
              if(snapshot.connectionState == ConnectionState.waiting){
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                );
              }
              return const LoginScreen();
            },
          )
      ),
    );
  }
}
