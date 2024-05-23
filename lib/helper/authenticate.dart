import 'package:chat_app/views/signin.dart';
import 'package:chat_app/views/signup.dart';
import 'package:flutter/material.dart';
class authenticate extends StatefulWidget {
  const authenticate({Key? key}) : super(key: key);

  @override
  _authenticateState createState() => _authenticateState();
}

class _authenticateState extends State<authenticate> {
  bool showsignin=true;
  void toggleview(){
    setState(() {
      showsignin= !showsignin;
    });
  }
  @override
  Widget build(BuildContext context) {
    if (showsignin){
      return signIn(toggleview);

    }
    else
      {
        return signUp(toggleview);
      }
  }
}
