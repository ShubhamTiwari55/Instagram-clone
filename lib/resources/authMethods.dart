import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:insta_clone/models/user.dart' as model;
import 'package:insta_clone/resources/storage_methods.dart';

class AuthMethods{
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<model.User> getUserDetails() async{
    User? currentUser = auth.currentUser;
    
    DocumentSnapshot snap = await firestore.collection('users').doc(currentUser!.uid).get();
    
    return model.User.fromSnap(snap);
 
  }
  //sign up user
Future<String> signUpUser({
    required String email,
    required String password,
    required String username,
    required String bio,
    required Uint8List file
})async{
  String res = "An error occurred";
      try{
          if(email.isNotEmpty || password.isNotEmpty || username.isNotEmpty ||
          bio.isNotEmpty || file!=null) {
            //register user
            UserCredential cred = await auth.createUserWithEmailAndPassword(
                email: email, password: password);
            print(cred.user!.uid);

            String photoUrl = await StorageMethods(
            ).uploadImage('profileImage', file, false);
            //add user to the database

            model.User user = model.User(
                email: email,
                username: username,
                uid: cred.user!.uid,
                bio: bio,
                photoUrl: photoUrl,
                followers: [],
                following: [],);

            await firestore.collection('users').doc(cred.user!.uid).set(user.toJson(),);
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
//logging in user
Future<String> loginUser({
    required String email,
    required String password
})async{
  String res = "Some error occurred";
  try{
    if(email.isNotEmpty || password.isNotEmpty){
     await auth.signInWithEmailAndPassword(email: email,
          password: password);
     res = "success";
    }else{
      res = "Please enter all the fields";
    }
  }catch(err){
    res = err.toString();
  }
  return res;
}

}



