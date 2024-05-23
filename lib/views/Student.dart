import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'form.dart';
class student extends StatefulWidget {



  @override
  _studentState createState() => _studentState();
}

class _studentState extends State<student> {

  final _formKey= GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Container(

      child: Scaffold(


        appBar: AppBar(
          automaticallyImplyLeading: true,
          backgroundColor: Colors.green,
          title: Center(
            child: Text('ADD STUDENT'),


          ),
        ),

        body:

        form(),
      ),
    );





  }


}

