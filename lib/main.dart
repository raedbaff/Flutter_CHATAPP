import 'package:chat_app/views/chatsroom.dart';
import 'package:chat_app/views/signin.dart';
import 'package:chat_app/views/signup.dart';
import 'package:flutter/material.dart';
import 'helper/helperfunctions.dart';
import 'helper/authenticate.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Startit();
  runApp( MyApp());
}
Future<void>Startit()async{
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    print("success bro");

  }
  catch(error){
    print("error bro :$error");
  }
}

class MyApp extends StatefulWidget {


  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool? userisloggedin=false;
  @override
  void initState() {
    getloggedinstate();
    // TODO: implement initState
    super.initState();
  }
  getloggedinstate() async{
    await helperfunction.getuserloggedin().then((val){
      setState(() {
        userisloggedin=val;
      });

    });
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Color(0xff145C9E),
        scaffoldBackgroundColor: Color(0xff1F1F1F),

      ),
      home: authenticate(),
    );
  }
}




