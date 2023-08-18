import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:insta_clone/providers/userProvider.dart';
import 'package:insta_clone/utils/utils.dart';
import 'package:provider/provider.dart';

import '../models/user.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({Key? key}) : super(key: key);

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  Uint8List? _file;
  final TextEditingController _descriptionController = TextEditingController();

  _selecImage(BuildContext context)async{
    return showDialog(context: context, builder: (context){
      return SimpleDialog(
        title: const Text('Create a Post'),
        children: [
          SimpleDialogOption(
            padding: const EdgeInsets.all(20),
            child: const Text('Take a Photo'),
            onPressed: ()async{
              Navigator.of(context).pop();
              Uint8List file = await pickImage(ImageSource.camera);
              setState(() {
                _file = file;
              });
            },
          ),
          SimpleDialogOption(
            padding: const EdgeInsets.all(20),
            child: const Text('Choose from Gallery'),
            onPressed: ()async{
              Navigator.of(context).pop();
              Uint8List file = await pickImage(ImageSource.gallery);
              setState(() {
                _file = file;
              });
            },
          ),
          SimpleDialogOption(
            padding: const EdgeInsets.all(20),
            child: const Text('Cancel'),
            onPressed: ()async{
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<UserProvider>(context).getUser;
     return _file == null?Center(
      child: IconButton(
       icon: const Icon(Icons.upload),
       onPressed: ()=>_selecImage(context),
      ),
     )
    :Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: (){},
        ),
        title: const Text('New post'),
        actions: [
          TextButton(onPressed: () {},
              child: const Text('Post', style: TextStyle(
                color: Colors.blueAccent,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),),
          ),
        ],),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(user.photoUrl),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width*0.3,
                child: TextField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(
                    hintText: 'Write a Caption...',
                    border: InputBorder.none
                  ),
                  maxLines: 8,
                ),
              ),
              SizedBox(
                height: 45,
                width: 45,
                child: AspectRatio(
                  aspectRatio: 487/451,
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: MemoryImage(_file!),
                      ),
                    ),
                  ),
                ),
              ),
              const Divider(),
            ],
          )
        ],
      ),
    );
  }
}
