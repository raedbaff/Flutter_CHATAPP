import 'package:chat_app/helper/helperfunctions.dart';
import 'package:chat_app/services/auth.dart';
import 'package:chat_app/services/database.dart';
import 'package:chat_app/widgets/widgets.dart';
import 'package:flutter/material.dart';

import 'chatsroom.dart';
class signUp extends StatefulWidget {
  final Function toggle;
  signUp(this.toggle);


  @override
  _signUpState createState() => _signUpState();
}

class _signUpState extends State<signUp> {
  authmethods auth=new authmethods();
  databasemethods db=new databasemethods();
  helperfunction help=new helperfunction();
  final formKey = GlobalKey<FormState>();
  final TextEditingController userNameTextEdittingController = TextEditingController();
  final TextEditingController emailTextEdittingController = TextEditingController();
  final TextEditingController passwordTextEdittingController = TextEditingController();
  bool isLoading = false;
  signmeup(){
    if (formKey.currentState!.validate())
      {
        Map<String,String> userinfomap={
          "name" :userNameTextEdittingController.text,
          "email":emailTextEdittingController.text
        };
        helperfunction.saveuseremail(emailTextEdittingController.text);
        helperfunction.saveusernamesharedpreference(userNameTextEdittingController.text);
        setState(() {
          isLoading=true;

        });
        auth.signupwithemailandpassword(emailTextEdittingController.text, passwordTextEdittingController.text).then((val){
          //print("$val");

          db.uploaduserinfo(userinfomap);
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>chatroom()));
        });

      }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Image.asset("assets/images/logo.png",height: 50,),
      ),
      body: isLoading ? Container(
        child: Center(child: CircularProgressIndicator()),
      ): Center(
        child: SingleChildScrollView(
          child: Container(
           // height: MediaQuery.of(context).size.height =50,
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
                      key: formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            validator: (val){
                              return val!.isEmpty || val.length<4 ? "please provide valid info" : null;

                            },
                            controller: userNameTextEdittingController,
                            style: simpletextstyle(),

                            decoration:textFieldInputDecoration("Username"),

                          ),
                          TextFormField(
                            validator: (val){
                              return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(val!) ? null : "please provide valid email" ;

                            },
                            controller: emailTextEdittingController,
                            style: simpletextstyle(),

                            decoration:textFieldInputDecoration("Email"),

                          ),
                          TextFormField(
                            obscureText: true,
                            validator: (val){
                              return val!.length>6? null:"please provide valid password";

                            },
                            controller: passwordTextEdittingController,
                            style: simpletextstyle(),
                            decoration: textFieldInputDecoration("Password"),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 8,),
                    GestureDetector(
                      onTap: (){


                      },
                      child: Container(
                        alignment: Alignment.centerRight,
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 16,vertical: 8),
                          child: Text("forgot password?",style: simpletextstyle(),),
                        ),
                      ),
                    ),
                    SizedBox(height: 8,),
                    GestureDetector(
                      onTap: (){
                        signmeup();
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
                        child: Text("Sign Up",style: TextStyle(
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
                      child: Text("Sign up With Google",style: TextStyle(
                          color: Colors.black87,
                          fontSize: 17
                      ),),
                    ),
                    SizedBox(height: 16,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Already with an account ?",style: mediumtextstyle(),),
                        GestureDetector(
                          onTap: (){
                            widget.toggle();
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 8),
                            child: Text("Sign in now ",style: TextStyle(
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

