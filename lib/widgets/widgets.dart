import 'dart:ui';

import 'package:flutter/material.dart';
const TextInputDecoration =  InputDecoration(
    fillColor: Colors.white,
    filled: true,
    enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.white,
          width: 2.0,
        )
    ),
    focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.pink,
          width: 2.0,
        )
    )
);
Widget appbarMain(BuildContext context){
  return AppBar(
    title: Image.asset("assets/images/logo.png", height: 50,),
  );
}
InputDecoration textFieldInputDecoration(String hintText){
  return  InputDecoration(hintText: hintText,hintStyle: TextStyle(
      color: Colors.white54),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.white),


      ),
      enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white)
      ));

}
TextStyle simpletextstyle(){
  return TextStyle(
    color: Colors.white,
    fontSize: 16
  );
}
TextStyle mediumtextstyle(){
  return TextStyle(
      color: Colors.white,
      fontSize: 17
  );

}