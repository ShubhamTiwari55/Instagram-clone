import 'dart:ffi';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthMethods{
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  //sign up user
Future<String> signUpUser({
    required String email,
    required String password,
    required String username,
    required String bio,
    //required Uint8List file
})async{
  String res = "An error occurred";
      try{
          if(email.isNotEmpty || password.isNotEmpty || username.isNotEmpty ||
          bio.isNotEmpty) {
            //register user
            UserCredential cred = await auth.createUserWithEmailAndPassword(
                email: email, password: password);
            print(cred.user!.uid);
            //add user to the database
            await firestore.collection('users').doc(cred.user!.uid).set({
              'username': username,
              'uid': cred.user!.uid,
              'email': email,
              'bio': bio,
              'followers': [],
              'following': []
            });
            //Another way of executing the above method
            // await firestore.collection('users').add({
            //   'username': username,
            //   'uid': cred.user!.uid,
            //   'email': email,
            //   'bio': bio,
            //   'followers': [],
            //   'following': []
            // });
            res = "success";
          }
      }catch(e){
    res = e.toString();
  }
return res;
}


}



