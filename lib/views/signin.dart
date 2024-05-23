import 'dart:ui';
import 'package:chat_app/helper/helperfunctions.dart';
import 'package:chat_app/services/auth.dart';
import 'package:chat_app/services/database.dart';
import 'package:chat_app/widgets/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'chatsroom.dart';
class signIn extends StatefulWidget {
  final Function toggle;
  signIn(this.toggle);


  @override
  _signInState createState() => _signInState();
}

class _signInState extends State<signIn> {
  final formkey=GlobalKey<FormState>();
  TextEditingController emailTextEdittingController=new TextEditingController();
  TextEditingController passwordTextEdittingController=new TextEditingController();
  authmethods auth=new authmethods();
  databasemethods db=new databasemethods();
  bool isloading=false;
  QuerySnapshot? snapshotuserinfo;
  SIGNIN(){
    if (formkey.currentState!.validate()){
      helperfunction.saveuseremail(emailTextEdittingController.text);
      setState(() {
        isloading=true;
      });
      try {
         db.getUseremail(emailTextEdittingController.text).then((val){
          snapshotuserinfo=val;
          helperfunction.saveusernamesharedpreference(snapshotuserinfo!.docs[0]['name']);


        });
      }
      catch(e){
        print("the error ${e}");
      }

      auth.signInwithEmailandPassword(emailTextEdittingController.text, passwordTextEdittingController.text).then((val){
        if(val!=null)
          {

            helperfunction.saveuserloggedInsharedPreference(true);
            Navigator.pushReplacement(context, MaterialPageRoute(
                builder: (context)=>chatroom()));

          }
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Image.asset("assets/images/logo.png",height: 50,),
      ),

      body: Center(
        child: SingleChildScrollView(
          child: Container(
            //height: MediaQuery.of(context).size.height,
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "Chat App",
                      style: TextStyle(
                        fontSize: 32, // Increase font size
                        color: Colors.white,
                        fontWeight: FontWeight.bold, // Add bold font weight
                        fontFamily: 'Pacifico', // Example of using a different font
                        letterSpacing: 2.0, // Increase letter spacing for a fancy look
                        shadows: [
                          Shadow(
                            color: Colors.black,
                            blurRadius: 2,
                            offset: Offset(1, 1),
                          ),
                        ],
                      ),
                    ),
                    Form(
                      key: formkey,
                      child: Column(
                        children: [
                          TextFormField(
                            validator: (val){
                              return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(val!) ? null : "please provide valid email" ;

                            },
                            controller: emailTextEdittingController,
                            style: simpletextstyle(),

                            decoration:textFieldInputDecoration("Email"),

                          ),
                          TextFormField(
                            validator: (val){
                              return val!.length>6? null:"please provide valid password";

                            },
                            controller: passwordTextEdittingController,
                            style: simpletextstyle(),
                            obscureText: true,
                            decoration: textFieldInputDecoration("Password"),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 8,),
                    Container(
                      alignment: Alignment.centerRight,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 16,vertical: 8),
                        child: Text("forgot password?",style: simpletextstyle(),),
                      ),
                    ),
                    SizedBox(height: 8,),
                    GestureDetector(
                      onTap: (){
                        SIGNIN();
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.symmetric(vertical: 20),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              const Color(0xff007EF4),
                              const Color(0xff2A75BC)
                            ]

                          ),
                          borderRadius: BorderRadius.circular(30)
                        ),
                        child: Text("Sign In",style: TextStyle(
                          color: Colors.white,
                          fontSize: 17
                        ),),
                      ),
                    ),
                    SizedBox(height: 16,),
                    Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.symmetric(vertical: 20),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30)
                      ),
                      child: Text("Sign In With Google",style: TextStyle(
                          color: Colors.black87,
                          fontSize: 17
                      ),),
                    ),
                    SizedBox(height: 16,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Don't have an account ?",style: mediumtextstyle(),),
                        GestureDetector(
                          onTap: (){
                            widget.toggle();
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 8),
                            child: Text(" Register now ",style: TextStyle(
                              color: Colors.blue,
                              fontSize: 17,
                              decoration: TextDecoration.underline
                            ),),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 50,),
                  ],
                )),
          ),
        ),
      ),


    );
  }
}
