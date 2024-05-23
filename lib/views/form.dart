import 'dart:io';
import 'dart:math';

import 'package:chat_app/widgets/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';


class form extends StatefulWidget {
  @override
  State<form> createState() => _formState();}


class _formState extends State<form> {
  final _formKey= GlobalKey<FormState>();

  var name='';

  var email='';

  var age='';

  var level='';
  late String imageUrl;

  File? image;

  @override
  Widget build(BuildContext context) {
    CollectionReference studenttt=FirebaseFirestore.instance.collection('student');
    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage('assets/images/student.jpg'),fit: BoxFit.cover,
          ),),

        child: Form(

          key: _formKey,

          child: Column(


            children: <Widget>[
              image!=null ? Image.file(image!,
                width: 90,
                height: 90,): FlutterLogo(size: 50,),
              SizedBox(height: 20),
              Text('Name',
                style: TextStyle(
                  letterSpacing: 3.0,
                  fontSize: 20,
                ),),
              TextFormField(
                onChanged: (val){
                  name=val;
                },
                decoration: TextInputDecoration.copyWith(hintText: 'enter name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10.0),
              Text('email',
                style: TextStyle(
                  letterSpacing: 3.0,
                  fontSize: 20,
                ),),
              TextFormField(
                onChanged: (val){
                  email=val;
                },

                decoration: TextInputDecoration.copyWith(hintText: 'enter email'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter email';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10.0),
              Text('age',
                style: TextStyle(
                  letterSpacing: 3.0,
                  fontSize: 20,
                ),),
              TextFormField(
                onChanged: (val){
                  age=val;
                },
                decoration: TextInputDecoration.copyWith(hintText: 'enter age'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter age';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10.0),
              Text('Level',
                style: TextStyle(
                  letterSpacing: 3.0,
                  fontSize: 20,
                ),),
              SizedBox(height: 10.0),
              TextFormField(
                onChanged: (val){
                  level=val;
                },
                decoration: TextInputDecoration.copyWith(hintText: 'enter level'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter level of student';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              Center(
                  child:ElevatedButton(
                    onPressed: (){
                      if (_formKey.currentState!.validate()){
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('Sending Data to Cloud'),

                        ),
                        );
                        studenttt.add({'name': name,'age':age ,'email':email,'level':level,'url':imageUrl})
                            .then((val)=>print('user added'));

                      }
                    },
                    child: Text('Submit'),
                  )

              ),
              Center(
                  child: ElevatedButton(
                    onPressed: (()=>pickImage()),
                    child: Text('upload Image'),
                  )
              ),


            ],
          ),
        ),
      ),
    );
  }

  Future pickImage() async {
    Random random = new Random();
    int randomNumber = random.nextInt(100);
    String imagename=randomNumber.toString();
    final _storage=FirebaseStorage.instance;
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image==null) return;
    final imageSelected=File(image.path);
    setState(()=>this.image=imageSelected);
    if(image!=null){
      var snapshot= await
      _storage.ref().child('Images/$imagename').putFile(imageSelected);
      var downloadUrl=await snapshot.ref.getDownloadURL();
      setState(() {
        imageUrl=downloadUrl;

      });


    }
    else
    {
      return null;

    }
  }
}